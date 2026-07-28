
import UIKit

class Tendi_InformationViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var bioTextField: UITextField!
    @IBOutlet private weak var birthdayLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var completesLoginOnNext = false
    var profileUser: TendiLocalUser?

    private let dataStore = TendiLocalDataStore.shared
    private weak var activeTextField: UITextField?
    private var originalContentInset: UIEdgeInsets = .zero
    private var originalVerticalScrollIndicatorInsets: UIEdgeInsets = .zero
    private let keyboardInputSpacing: CGFloat = 16
    
    private let birthdayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }()

    private let payloadBirthdayFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()
    
    private var selectedBirthday: Date?

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentInsetAdjustmentBehavior = .never
        originalContentInset = scrollView.contentInset
        originalVerticalScrollIndicatorInsets = scrollView.verticalScrollIndicatorInsets
        navigationItem.title = profileUser == nil ? "Information" : "Edit Profile"
        avatarImageView.layer.cornerRadius = 36
        avatarImageView.layer.masksToBounds = true
        configureTextFields()
        configureProfileInfo()
        configureKeyboardDismissGesture()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        resetScrollViewInsets()
    }

    private func configureTextFields() {
        usernameTextField.delegate = self
        bioTextField.delegate = self
        usernameTextField.returnKeyType = .next
        bioTextField.returnKeyType = .done
    }

    private func configureProfileInfo() {
        guard let profileUser else {
            selectedBirthday = birthdayFormatter.date(from: birthdayLabel.text ?? "")
            return
        }

        usernameTextField.text = profileUser.nickname
        bioTextField.text = profileUser.bio
        avatarImageView.image = UIImage(named: profileUser.avatarImageName) ?? UIImage(named: "tendi_avatar")

        if let birthday = payloadBirthdayFormatter.date(from: profileUser.birthdayRawValue) {
            selectedBirthday = birthday
            birthdayLabel.text = birthdayFormatter.string(from: birthday)
        } else {
            selectedBirthday = birthdayFormatter.date(from: birthdayLabel.text ?? "")
        }
    }
    
    @IBAction private func avatarButtonTapped(_ sender: UIButton) {
        ChoosePhotoView.show(
            in: view,
            cameraAction: { [weak self] in
                self?.openCamera()
            },
            albumAction: { [weak self] in
                self?.openAlbum()
            }
        )
    }
    
    private func openCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            TendiHUD.showToast("Camera is unavailable on this device.", in: view)
            return
        }
        
        presentImagePicker(sourceType: .camera)
    }
    
    private func openAlbum() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            TendiHUD.showToast("Photo library is unavailable.", in: view)
            return
        }
        
        presentImagePicker(sourceType: .photoLibrary)
    }
    
    private func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = sourceType
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
    }
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        let image = (info[.editedImage] as? UIImage) ?? (info[.originalImage] as? UIImage)
        avatarImageView.image = image
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    @IBAction private func birthdayButtonTapped(_ sender: UIButton) {
        dismissCurrentKeyboard()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) { [weak self] in
            guard let self else { return }
            BirthdayPickerView.show(in: self.view, selectedDate: self.selectedBirthday) { [weak self] date in
                self?.selectedBirthday = date
                self?.birthdayLabel.text = self?.birthdayFormatter.string(from: date)
            }
        }
    }

    @IBAction private func nextButtonTapped(_ sender: UIButton) {
        dismissCurrentKeyboard()

        guard validateProfileInfo() else {
            return
        }

        saveProfileInfo()

        if completesLoginOnNext {
            TendiAuthSession.switchToMain(from: view)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }

    private func validateProfileInfo() -> Bool {
        guard currentUsername.isEmpty == false else {
            TendiHUD.showToast("Please enter username.", in: view)
            return false
        }

        guard currentBio.isEmpty == false else {
            TendiHUD.showToast("Please write your bio.", in: view)
            return false
        }

        guard selectedBirthday != nil else {
            TendiHUD.showToast("Please select birthday.", in: view)
            return false
        }

        return true
    }

    private func saveProfileInfo() {
        guard let selectedBirthday else { return }

        dataStore.updateCurrentUserProfile(
            nickname: currentUsername,
            bio: currentBio,
            birthdayRawValue: payloadBirthdayFormatter.string(from: selectedBirthday)
        )
    }

    private var currentUsername: String {
        usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    }

    private var currentBio: String {
        bioTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    }

    private func dismissCurrentKeyboard() {
        view.endEditing(true)
        view.window?.endEditing(true)
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }

    private func configureKeyboardDismissGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(blankAreaTapped))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func blankAreaTapped() {
        dismissCurrentKeyboard()
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
        scrollActiveTextFieldIntoView()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if activeTextField === textField {
            activeTextField = nil
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === usernameTextField {
            bioTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }

    private func registerKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
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
        updateKeyboardLayout(with: notification, isHiding: false)
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        updateKeyboardLayout(with: notification, isHiding: true)
    }

    private func updateKeyboardLayout(with notification: Notification, isHiding: Bool) {
        let duration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0.25
        let curveValue = (notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue
            ?? UInt(UIView.AnimationCurve.easeInOut.rawValue)
        let options = UIView.AnimationOptions(rawValue: curveValue << 16)

        let keyboardOverlap: CGFloat
        if isHiding {
            keyboardOverlap = 0
        } else if let frameValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrame = scrollView.convert(frameValue.cgRectValue, from: nil)
            keyboardOverlap = max(0, scrollView.bounds.maxY - keyboardFrame.minY)
        } else {
            keyboardOverlap = 0
        }

        UIView.animate(withDuration: duration, delay: 0, options: options) {
            self.applyKeyboardOverlap(keyboardOverlap)
        } completion: { _ in
            if isHiding == false {
                self.scrollActiveTextFieldIntoView()
            }
        }
    }

    private func applyKeyboardOverlap(_ keyboardOverlap: CGFloat) {
        var contentInset = originalContentInset
        contentInset.bottom += keyboardOverlap
        scrollView.contentInset = contentInset

        var verticalIndicatorInsets = originalVerticalScrollIndicatorInsets
        verticalIndicatorInsets.bottom += keyboardOverlap
        scrollView.verticalScrollIndicatorInsets = verticalIndicatorInsets
    }

    private func resetScrollViewInsets() {
        activeTextField = nil
        scrollView.contentInset = originalContentInset
        scrollView.verticalScrollIndicatorInsets = originalVerticalScrollIndicatorInsets
    }

    private func scrollActiveTextFieldIntoView() {
        guard let activeTextField else { return }

        let textFieldFrame = activeTextField.convert(activeTextField.bounds, to: scrollView)
        let visibleRect = textFieldFrame.insetBy(dx: 0, dy: -keyboardInputSpacing)
        scrollView.scrollRectToVisible(visibleRect, animated: true)
    }

}
