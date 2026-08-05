import SafariServices
import UIKit

extension UIViewController {
    private static var tendiUserAgreementURL: URL? {
        URL(string: "https://app.wqtogeply.com/policy")
    }

    private static var tendiPrivacyAgreementURL: URL? {
        URL(string: "https://app.wqtogeply.com/privacy")
    }

    func presentTendiUserAgreement() {
        presentTendiAgreement(Self.tendiUserAgreementURL, unavailableMessage: "User Agreement is unavailable.")
    }

    func presentTendiPrivacyAgreement() {
        presentTendiAgreement(Self.tendiPrivacyAgreementURL, unavailableMessage: "Privacy Agreement is unavailable.")
    }

    private func presentTendiAgreement(_ url: URL?, unavailableMessage: String) {
        guard let url else {
            TendiHUD.showToast(unavailableMessage, in: view)
            return
        }

        let safariViewController = SFSafariViewController(url: url)
        safariViewController.modalPresentationStyle = .pageSheet
        present(safariViewController, animated: true)
    }
}
