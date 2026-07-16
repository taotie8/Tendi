
import UIKit

class Tendi_InformationViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var birthdayLabel: UILabel!
    
    private let birthdayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }()
    
    private var selectedBirthday: Date?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Information"
        avatarImageView.layer.cornerRadius = 36
        selectedBirthday = birthdayFormatter.date(from: birthdayLabel.text ?? "")
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
        BirthdayPickerView.show(in: view, selectedDate: selectedBirthday) { [weak self] date in
            self?.selectedBirthday = date
            self?.birthdayLabel.text = self?.birthdayFormatter.string(from: date)
        }
    }


}
