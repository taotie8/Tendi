
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
        navigationController?.pushViewController(Tendi_LoginViewController(), animated: true)
    }
    
    @IBAction private func newAccountButtonTapped(_ sender: UIButton) {
        print("newAccountButtonTapped")
    }
    
    @IBAction private func agreementButtonTapped(_ sender: UIButton) {
        isAgreementSelected.toggle()
    }
    
    @IBAction private func policyButtonTapped(_ sender: UIButton) {
        print("policyButtonTapped")
    }


}
