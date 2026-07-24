
import UIKit
import StoreKit

private struct TendiCoinRechargePackage {
    let price: String
    let coinAmount: Int
    let productIdentifier: String
    let alternateProductIdentifiers: [String]

    init(
        price: String,
        coinAmount: Int,
        productIdentifier: String,
        alternateProductIdentifiers: [String] = []
    ) {
        self.price = price
        self.coinAmount = coinAmount
        self.productIdentifier = productIdentifier
        self.alternateProductIdentifiers = alternateProductIdentifiers
    }

    var allProductIdentifiers: [String] {
        [productIdentifier] + alternateProductIdentifiers
    }

    func matches(productIdentifier: String) -> Bool {
        allProductIdentifiers.contains(productIdentifier)
    }
}

private enum TendiStoreKitPaymentError: LocalizedError {
    case paymentsUnavailable
    case productUnavailable
    case verificationFailed
    case productMismatch
    case rechargeFailed

    var errorDescription: String? {
        switch self {
        case .paymentsUnavailable:
            return "Purchases are unavailable."
        case .productUnavailable:
            return "This recharge package is unavailable."
        case .verificationFailed:
            return "Payment verification failed."
        case .productMismatch:
            return "Payment product does not match."
        case .rechargeFailed:
            return "Recharge failed."
        }
    }
}

class Tendi_DallarViewController: BaseViewController {

    private static let processedStoreKitTransactionKey = "Tendi.processedStoreKitTransactionIdentifiers"

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var dallar_label: UILabel!

    private let dataStore = TendiLocalDataStore.shared
    private var isPaymentProcessing = false
    private var paymentTask: Task<Void, Never>?
    private var productLoadTask: Task<Void, Never>?
    private var transactionUpdatesTask: Task<Void, Never>?
    private var storeProductsByIdentifier: [String: Product] = [:]
    private var processedStoreKitTransactionIdentifiers = Set(
        UserDefaults.standard.stringArray(forKey: Tendi_DallarViewController.processedStoreKitTransactionKey) ?? []
    )
    private let rechargePackages: [TendiCoinRechargePackage] = [
        TendiCoinRechargePackage(price: "99.99", coinAmount: 90000, productIdentifier: "ewcaufcdjmgwihww"),
        TendiCoinRechargePackage(price: "64.99", coinAmount: 58000, productIdentifier: "iejrnsjdnfjsfjnq"),
        TendiCoinRechargePackage(price: "49.99", coinAmount: 43000, productIdentifier: "uktosnzwaaseebti"),
        TendiCoinRechargePackage(price: "29.99", coinAmount: 24000, productIdentifier: "mnjkngjkbnewbdhj"),
        TendiCoinRechargePackage(price: "19.99", coinAmount: 15000, productIdentifier: "cjlfadigotzbpfvs"),
        TendiCoinRechargePackage(price: "14.99", coinAmount: 10500, productIdentifier: "unjdfhfjknfgjnjb"),
        TendiCoinRechargePackage(price: "9.99", coinAmount: 6500, productIdentifier: "ogcemyywccerkiyu"),
        TendiCoinRechargePackage(price: "4.99", coinAmount: 3000, productIdentifier: "yssftveqkpppgnhw"),
        TendiCoinRechargePackage(price: "1.99", coinAmount: 1100, productIdentifier: "dgmfndpynnfvtzyq"),
        TendiCoinRechargePackage(price: "0.99", coinAmount: 500, productIdentifier: "imzbocbztydkcmwc")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 66.1)/3, height: 137)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 13
        layout.minimumLineSpacing = 30
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: "Tendi_DallarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "item")
        configureCoinBalance()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(coinBalanceDidChange),
            name: .tendiCoinBalanceDidChange,
            object: nil
        )
        preloadStoreProducts()
        observeStoreKitTransactions()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureCoinBalance()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cancelPaymentLoading()
    }

    @MainActor deinit {
        paymentTask?.cancel()
        productLoadTask?.cancel()
        transactionUpdatesTask?.cancel()
        NotificationCenter.default.removeObserver(self)
    }

    private func configureCoinBalance() {
        dallar_label.text = "\(dataStore.currentCoinBalance)"
    }

    @objc private func coinBalanceDidChange() {
        configureCoinBalance()
    }

    private func startPayment(for package: TendiCoinRechargePackage) {
        guard isPaymentProcessing == false else { return }

        guard SKPaymentQueue.canMakePayments() else {
            TendiHUD.showToast(TendiStoreKitPaymentError.paymentsUnavailable.localizedDescription, in: view)
            return
        }

        isPaymentProcessing = true
        collectionView.isUserInteractionEnabled = false
        TendiHUD.showLoading(in: view, message: "Processing...")

        paymentTask?.cancel()
        paymentTask = Task { [weak self] in
            guard let self else { return }
            await self.purchaseStoreProduct(for: package)
        }
    }

    private func cancelPaymentLoading() {
        paymentTask = nil
        isPaymentProcessing = false
        collectionView?.isUserInteractionEnabled = true
        TendiHUD.hideLoading(in: view)
    }

    private func failPayment(_ message: String) {
        cancelPaymentLoading()
        TendiHUD.showToast(message, in: view)
    }

    private func preloadStoreProducts() {
        productLoadTask?.cancel()
        productLoadTask = Task { [weak self] in
            guard let self else { return }
            try? await self.loadStoreProducts(for: self.rechargePackages.flatMap(\.allProductIdentifiers))
        }
    }

    private func observeStoreKitTransactions() {
        transactionUpdatesTask?.cancel()
        transactionUpdatesTask = Task { [weak self] in
            for await verificationResult in Transaction.updates {
                guard let self else { break }
                await self.handleUpdatedTransaction(verificationResult)
            }
        }
    }

    private func purchaseStoreProduct(for package: TendiCoinRechargePackage) async {
        do {
            let product = try await storeProduct(for: package)
            let purchaseResult = try await product.purchase()

            switch purchaseResult {
            case .success(let verificationResult):
                let transaction = try verifiedTransaction(from: verificationResult)
                guard package.matches(productIdentifier: transaction.productID) else {
                    await transaction.finish()
                    throw TendiStoreKitPaymentError.productMismatch
                }

                try await completePayment(for: package, transaction: transaction, showsSuccessPrompt: true)

            case .pending:
                cancelPaymentLoading()
                TendiHUD.showPrompt(
                    in: view,
                    title: "Payment Pending",
                    message: "Your purchase is waiting for Apple approval. Coins will be added after the payment is confirmed.",
                    primaryTitle: "OK"
                )

            case .userCancelled:
                cancelPaymentLoading()

            @unknown default:
                throw TendiStoreKitPaymentError.productUnavailable
            }
        } catch is CancellationError {
            cancelPaymentLoading()
        } catch {
            failPayment(error.localizedDescription)
        }
    }

    private func handleUpdatedTransaction(_ verificationResult: VerificationResult<Transaction>) async {
        do {
            let transaction = try verifiedTransaction(from: verificationResult)
            guard let package = rechargePackages.first(where: { $0.matches(productIdentifier: transaction.productID) }) else {
                await transaction.finish()
                return
            }

            let shouldShowPrompt = viewIfLoaded?.window != nil
            try await completePayment(for: package, transaction: transaction, showsSuccessPrompt: shouldShowPrompt)
        } catch {
            if isPaymentProcessing {
                failPayment(error.localizedDescription)
            }
        }
    }

    private func completePayment(
        for package: TendiCoinRechargePackage,
        transaction: Transaction,
        showsSuccessPrompt: Bool
    ) async throws {
        let transactionIdentifier = String(transaction.id)
        if processedStoreKitTransactionIdentifiers.contains(transactionIdentifier) {
            await transaction.finish()
            cancelPaymentLoading()
            return
        }

        guard dataStore.addCoins(package.coinAmount) else {
            throw TendiStoreKitPaymentError.rechargeFailed
        }

        processedStoreKitTransactionIdentifiers.insert(transactionIdentifier)
        UserDefaults.standard.set(
            Array(processedStoreKitTransactionIdentifiers),
            forKey: Tendi_DallarViewController.processedStoreKitTransactionKey
        )
        await transaction.finish()
        cancelPaymentLoading()

        guard showsSuccessPrompt else { return }
        TendiHUD.showPrompt(
            in: view,
            title: "Recharge Successful",
            message: "\(package.coinAmount) coins have been added to your balance.",
            primaryTitle: "OK"
        )
    }

    private func storeProduct(for package: TendiCoinRechargePackage) async throws -> Product {
        if let product = package.allProductIdentifiers.compactMap({ storeProductsByIdentifier[$0] }).first {
            return product
        }

        try await loadStoreProducts(for: package.allProductIdentifiers)

        if let product = package.allProductIdentifiers.compactMap({ storeProductsByIdentifier[$0] }).first {
            return product
        }

        throw TendiStoreKitPaymentError.productUnavailable
    }

    private func loadStoreProducts(for productIdentifiers: [String]) async throws {
        let identifiers = Array(Set(productIdentifiers)).filter { $0.isEmpty == false }
        guard identifiers.isEmpty == false else { return }

        let products = try await Product.products(for: identifiers)
        for product in products {
            storeProductsByIdentifier[product.id] = product
        }
    }

    private func verifiedTransaction(
        from verificationResult: VerificationResult<Transaction>
    ) throws -> Transaction {
        switch verificationResult {
        case .verified(let transaction):
            return transaction
        case .unverified:
            throw TendiStoreKitPaymentError.verificationFailed
        }
    }

}

extension Tendi_DallarViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        rechargePackages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! Tendi_DallarCollectionViewCell
        cell.backgroundColor = .clear
        let package = rechargePackages[indexPath.item]
        cell.configure(
            price: package.price,
            coinAmount: package.coinAmount,
            productIdentifier: package.productIdentifier,
            isFeatured: indexPath.item == 0
        )
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let package = rechargePackages[indexPath.item]
        collectionView.deselectItem(at: indexPath, animated: true)
        startPayment(for: package)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: UIScreen.main.bounds.width - 40, height: 137)
        }
        return CGSize(width: (UIScreen.main.bounds.width - 66.1)/3, height: 137)
    }
    
}
