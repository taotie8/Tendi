
import UIKit

class ChoosePhotoView: UIView, UIGestureRecognizerDelegate {
    
    @IBOutlet private weak var bottomContainerView: UIView!
    
    private static let viewTag = 920_001
    
    private var cameraAction: (() -> Void)?
    private var albumAction: (() -> Void)?
    
    static func show(
        in view: UIView,
        cameraAction: (() -> Void)? = nil,
        albumAction: (() -> Void)? = nil
    ) {
        guard view.viewWithTag(viewTag) == nil,
              let choosePhotoView = Bundle.main.loadNibNamed("ChoosePhotoView", owner: nil)?.first as? ChoosePhotoView else {
            return
        }
        
        choosePhotoView.tag = viewTag
        choosePhotoView.cameraAction = cameraAction
        choosePhotoView.albumAction = albumAction
        choosePhotoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(choosePhotoView)
        
        NSLayoutConstraint.activate([
            choosePhotoView.topAnchor.constraint(equalTo: view.topAnchor),
            choosePhotoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            choosePhotoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            choosePhotoView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.layoutIfNeeded()
        choosePhotoView.show()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.black.withAlphaComponent(0.45)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        tapGesture.delegate = self
        addGestureRecognizer(tapGesture)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let touchedView = touch.view else { return true }
        return !touchedView.isDescendant(of: bottomContainerView)
    }
    
    @IBAction private func cameraButtonTapped(_ sender: UIButton) {
        dismiss { [cameraAction] in
            cameraAction?()
        }
    }
    
    @IBAction private func albumButtonTapped(_ sender: UIButton) {
        dismiss { [albumAction] in
            albumAction?()
        }
    }
    
    @IBAction private func cancelButtonTapped(_ sender: UIButton) {
        dismiss()
    }
    
    @objc private func backgroundTapped() {
        dismiss()
    }
    
    private func show() {
        alpha = 0
        bottomContainerView.transform = CGAffineTransform(translationX: 0, y: bottomContainerView.bounds.height)
        
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
            self.bottomContainerView.transform = .identity
        }
    }
    
    private func dismiss(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
            self.bottomContainerView.transform = CGAffineTransform(translationX: 0, y: self.bottomContainerView.bounds.height)
        }, completion: { _ in
            self.removeFromSuperview()
            completion?()
        })
    }

}
