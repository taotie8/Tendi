

import UIKit

class Tendi_LoginViewController: BaseViewController, UITextFieldDelegate {
    
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
    @IBOutlet private weak var contentView: UIView!
    
    private let mode: Mode
    private weak var activeTextField: UITextField?
    private var keyboardFrameInView: CGRect?
    private let keyboardInputSpacing: CGFloat = 16
    
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        keyboardFrameInView = nil
        contentView.transform = .identity
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

        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        emailTextField.returnKeyType = .next
        passwordTextField.returnKeyType = mode.showsConfirmPassword ? .next : .done
        confirmPasswordTextField.returnKeyType = .done
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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
        updateContentPosition(duration: 0.25, options: .curveEaseInOut)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if activeTextField === textField {
            activeTextField = nil
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField === passwordTextField, mode.showsConfirmPassword {
            confirmPasswordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            submitButtonTapped(submitButton)
        }
        return true
    }

    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillChangeFrame(_:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc private func keyboardWillChangeFrame(_ notification: Notification) {
        guard let frameValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }

        let keyboardFrame = view.convert(frameValue.cgRectValue, from: nil)
        keyboardFrameInView = keyboardFrame.intersects(view.bounds) ? keyboardFrame : nil
        updateContentPosition(with: notification)
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        keyboardFrameInView = nil
        updateContentPosition(with: notification)
    }

    private func updateContentPosition(with notification: Notification) {
        let duration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0.25
        let curveValue = (notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue
            ?? UInt(UIView.AnimationCurve.easeInOut.rawValue)
        let options = UIView.AnimationOptions(rawValue: curveValue << 16)

        updateContentPosition(duration: duration, options: options)
    }

    private func updateContentPosition(duration: TimeInterval, options: UIView.AnimationOptions) {
        let offset = requiredContentOffset()

        UIView.animate(withDuration: duration, delay: 0, options: options) {
            self.contentView.transform = CGAffineTransform(translationX: 0, y: -offset)
        }
    }

    private func requiredContentOffset() -> CGFloat {
        guard let activeTextField,
              let keyboardFrameInView else {
            return 0
        }

        let textFieldFrame = activeTextField.convert(activeTextField.bounds, to: view)
        return max(0, textFieldFrame.maxY + keyboardInputSpacing - keyboardFrameInView.minY)
    }

}
