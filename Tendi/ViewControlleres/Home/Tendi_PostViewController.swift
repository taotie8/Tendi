
import AVFoundation
import UIKit
import UniformTypeIdentifiers

class Tendi_PostViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, UIGestureRecognizerDelegate {

    enum PublishMode {
        case video
        case text
    }

    @IBOutlet private weak var contentTextView: UITextView!
    @IBOutlet private weak var contentPlaceholderLabel: UILabel!
    @IBOutlet private weak var mediaTitleLabel: UILabel!
    @IBOutlet private weak var mediaPreviewImageView: UIImageView!
    @IBOutlet private weak var mediaCloseButton: UIButton!

    var publishMode: PublishMode = .video
    
    private var selectedImage: UIImage?
    private var selectedVideoURL: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureContentInput()
        configureKeyboardDismissal()
        configurePublishMode()
    }
    
    private var trimmedContent: String {
        contentTextView.text.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    private func configureContentInput() {
        contentTextView.delegate = self
        contentTextView.inputAccessoryView = makeKeyboardToolbar()
        updateContentPlaceholder()
    }
    
    private func configureKeyboardDismissal() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
    }
    
    private func makeKeyboardToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeyboard))
        toolbar.items = [flexibleSpace, doneButton]
        
        return toolbar
    }

    private func configurePublishMode() {
        switch publishMode {
        case .video:
            mediaTitleLabel.text = "Video:"
        case .text:
            mediaTitleLabel.text = "Photo:"
        }

        mediaPreviewImageView.layer.cornerRadius = 24
        mediaPreviewImageView.layer.masksToBounds = true
        resetSelectedMedia()
    }
    
    @IBAction private func addMediaButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        
        ChoosePhotoView.show(
            in: view,
            cameraAction: { [weak self] in
                self?.openMediaPicker(sourceType: .camera)
            },
            albumAction: { [weak self] in
                self?.openMediaPicker(sourceType: .photoLibrary)
            }
        )
    }
    
    @IBAction private func mediaCloseButtonTapped(_ sender: UIButton) {
        resetSelectedMedia()
    }
    
    @IBAction private func publishButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        
        guard validatePublishInput() else {
            return
        }
        
        TendiHUD.showPrompt(
            in: view,
            title: "Under Review",
            message: reviewMessage,
            primaryTitle: "OK",
            primaryAction: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        )
    }
    
    private func validatePublishInput() -> Bool {
        guard trimmedContent.isEmpty == false else {
            TendiHUD.showToast("Please enter content.", in: view)
            return false
        }
        
        switch publishMode {
        case .video:
            guard selectedVideoURL != nil else {
                TendiHUD.showToast("Please add a video.", in: view)
                return false
            }
        case .text:
            guard selectedImage != nil else {
                TendiHUD.showToast("Please add a photo.", in: view)
                return false
            }
        }
        
        return true
    }
    
    private var reviewMessage: String {
        switch publishMode {
        case .video:
            return "Your video has been submitted and is under review."
        case .text:
            return "Your dynamic has been submitted and is under review."
        }
    }
    
    private func openMediaPicker(sourceType: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else {
            TendiHUD.showToast(sourceType == .camera ? "Camera is unavailable on this device." : "Photo library is unavailable.", in: view)
            return
        }
        
        guard let mediaType = preferredMediaType(for: sourceType) else {
            TendiHUD.showToast(publishMode == .video ? "Video is unavailable." : "Photo is unavailable.", in: view)
            return
        }
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = sourceType
        imagePickerController.mediaTypes = [mediaType]
        imagePickerController.allowsEditing = publishMode == .text
        imagePickerController.delegate = self
        present(imagePickerController, animated: true)
    }
    
    private func preferredMediaType(for sourceType: UIImagePickerController.SourceType) -> String? {
        let preferredType = publishMode == .video ? UTType.movie.identifier : UTType.image.identifier
        let availableTypes = UIImagePickerController.availableMediaTypes(for: sourceType) ?? []
        return availableTypes.contains(preferredType) ? preferredType : nil
    }
    
    private func resetSelectedMedia() {
        selectedImage = nil
        selectedVideoURL = nil
        mediaPreviewImageView.image = UIImage(named: "upload_add")
        mediaCloseButton.isHidden = true
    }
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        defer {
            picker.dismiss(animated: true)
        }
        
        guard let mediaType = info[.mediaType] as? String else {
            return
        }
        
        if mediaType == UTType.image.identifier {
            selectedImage = (info[.editedImage] as? UIImage) ?? (info[.originalImage] as? UIImage)
            selectedVideoURL = nil
            mediaPreviewImageView.image = selectedImage ?? UIImage(named: "upload_add")
            mediaCloseButton.isHidden = selectedImage == nil
            return
        }
        
        if mediaType == UTType.movie.identifier,
           let videoURL = info[.mediaURL] as? URL {
            selectedImage = nil
            selectedVideoURL = videoURL
            mediaPreviewImageView.image = previewImage(forVideoAt: videoURL) ?? UIImage(named: "upload_add")
            mediaCloseButton.isHidden = false
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        updateContentPlaceholder()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let touchedView = touch.view else {
            return true
        }
        
        return touchedView.isDescendant(of: contentTextView) == false
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func updateContentPlaceholder() {
        contentPlaceholderLabel.isHidden = trimmedContent.isEmpty == false
    }
    
    private func previewImage(forVideoAt url: URL) -> UIImage? {
        let asset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true
        guard let cgImage = try? imageGenerator.copyCGImage(at: .zero, actualTime: nil) else {
            return nil
        }
        return UIImage(cgImage: cgImage)
    }

}
