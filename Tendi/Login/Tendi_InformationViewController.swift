
import UIKit

class Tendi_InformationViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var bioTextField: UITextField!
    @IBOutlet private weak var birthdayLabel: UILabel!

    var completesLoginOnNext = false
    var profileUser: TendiLocalUser?

    private let dataStore = TendiLocalDataStore.shared
    
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
        navigationItem.title = profileUser == nil ? "Information" : "Edit Profile"
        avatarImageView.layer.cornerRadius = 36
        avatarImageView.layer.masksToBounds = true
        configureProfileInfo()
        configureKeyboardDismissGesture()
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

}
