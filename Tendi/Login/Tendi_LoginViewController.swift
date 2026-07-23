

import UIKit

class Tendi_LoginViewController: BaseViewController {
    
    enum Mode {
        case signIn
        case signUp
        
        var title: String {
            switch self {
            case .signIn:
                return "Sign in"
            case .signUp:
                return "Sign up"
            }
        }
        
        var buttonImageName: String {
            switch self {
            case .signIn:
                return "login_tap"
            case .signUp:
                return "sign_up_tap"
            }
        }
        
        var showsConfirmPassword: Bool {
            switch self {
            case .signIn:
                return false
            case .signUp:
                return true
            }
        }
    }
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var confirmPasswordTextField: UITextField!
    @IBOutlet private weak var confirmPasswordView: UIView!
    @IBOutlet private weak var submitButton: UIButton!
    
    private let mode: Mode
    
    init(mode: Mode = .signIn) {
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.mode = .signIn
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureForMode()
        emailTextField.text = "jeanne@gmail.com"
        passwordTextField.text = "123456"
    }
    
    @IBAction private func submitButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        
        guard let email = validatedEmail(),
              let password = validatedPassword() else {
            return
        }
        
        switch mode {
        case .signIn:
            signIn(email: email, password: password)
        case .signUp:
            guard validateConfirmedPassword(password) else { return }
            signUp(email: email, password: password)
        }
    }
    
    private func signIn(email: String, password: String) {
        enterInformationPage(prefillsCurrentUser: true)
    }
    
    private func signUp(email: String, password: String) {
        enterInformationPage(prefillsCurrentUser: false)
    }
    
    private func enterInformationPage(prefillsCurrentUser: Bool) {
        TendiAuthSession.markProfileCompletionRequired()

        let informationViewController = Tendi_InformationViewController()
        informationViewController.completesLoginOnNext = true
        if prefillsCurrentUser {
            informationViewController.profileUser = TendiLocalDataStore.shared.currentUserProfile
        }
        navigationController?.pushViewController(informationViewController, animated: true)
    }
    
    private func configureForMode() {
        navigationItem.title = mode.title
        confirmPasswordView.isHidden = !mode.showsConfirmPassword
        confirmPasswordTextField.text = nil
        submitButton.setImage(UIImage(named: mode.buttonImageName), for: .normal)
        
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.clearButtonMode = .whileEditing
        
        passwordTextField.isSecureTextEntry = true
        passwordTextField.clearButtonMode = .whileEditing
        
        confirmPasswordTextField.isSecureTextEntry = true
        confirmPasswordTextField.clearButtonMode = .whileEditing
    }
    
    private func validatedEmail() -> String? {
        let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        guard !email.isEmpty else {
            showMessage("Please enter your email address.")
            return nil
        }
        
        guard email.contains("@") else {
            showMessage("Please enter a valid email address.")
            return nil
        }
        
        return email
    }
    
    private func validatedPassword() -> String? {
        let password = passwordTextField.text ?? ""
        
        guard !password.isEmpty else {
            showMessage("Please enter your password.")
            return nil
        }
        
        return password
    }
    
    private func validateConfirmedPassword(_ password: String) -> Bool {
        let confirmedPassword = confirmPasswordTextField.text ?? ""
        
        guard !confirmedPassword.isEmpty else {
            showMessage("Please enter the password again.")
            return false
        }
        
        guard confirmedPassword == password else {
            showMessage("The passwords do not match.")
            return false
        }
        
        return true
    }
    
    private func showMessage(_ message: String) {
        TendiHUD.showToast(message, in: view)
    }



}
