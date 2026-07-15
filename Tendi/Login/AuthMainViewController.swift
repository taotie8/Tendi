
import UIKit

class AuthMainViewController: UIViewController {
    
    @IBOutlet private weak var agreementButton: UIButton!
    
    private var isAgreementSelected = false {
        didSet {
            let imageName = isAgreementSelected ? "select" : "un_select"
            agreementButton.setImage(UIImage(named: imageName), for: .normal)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        isAgreementSelected = false
    }
    
    @IBAction private func emailLoginButtonTapped(_ sender: UIButton) {
        guard isAgreementAccepted() else { return }
        navigationController?.pushViewController(Tendi_LoginViewController(mode: .signIn), animated: true)
    }
    
    @IBAction private func newAccountButtonTapped(_ sender: UIButton) {
        guard isAgreementAccepted() else { return }
        navigationController?.pushViewController(Tendi_LoginViewController(mode: .signUp), animated: true)
    }
    
    @IBAction private func agreementButtonTapped(_ sender: UIButton) {
        isAgreementSelected.toggle()
    }
    
    @IBAction private func policyButtonTapped(_ sender: UIButton) {
        TendiHUD.showToast("Privacy Policy", in: view)
    }
    
    private func isAgreementAccepted() -> Bool {
        guard isAgreementSelected else {
            showAgreementAlert()
            return false
        }
        return true
    }
    
    private func showAgreementAlert() {
        TendiHUD.showPrompt(
            in: view,
            title: "Terms Required",
            message: "Please agree to the Terms and Privacy Policy before continuing.",
            primaryTitle: "Agree",
            secondaryTitle: "Cancel",
            primaryAction: { [weak self] in
                self?.isAgreementSelected = true
            }
        )
    }


}
