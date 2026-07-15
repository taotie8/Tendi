import UIKit

enum TendiHUD {
    private static let loadingTag = 910_001
    private static let toastTag = 910_002
    private static let promptTag = 910_003
    
    static func showLoading(in view: UIView? = nil, message: String = "Loading...") {
        guard let view = targetView(from: view) else { return }
        hideLoading(in: view)
        
        let overlayView = UIView()
        overlayView.tag = loadingTag
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.28)
        view.addSubview(overlayView)
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = UIColor(red: 25 / 255.0, green: 28 / 255.0, blue: 27 / 255.0, alpha: 0.92)
        contentView.layer.cornerRadius = 14
        contentView.layer.masksToBounds = true
        overlayView.addSubview(contentView)
        
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.color = .white
        indicatorView.startAnimating()
        contentView.addSubview(indicatorView)
        
        let messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.text = message
        messageLabel.textColor = .white
        messageLabel.font = TendiFont.custom("MiSansLatin-Regular", size: 14)
        messageLabel.textAlignment = .center
        contentView.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            overlayView.topAnchor.constraint(equalTo: view.topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor),
            contentView.widthAnchor.constraint(equalToConstant: 132),
            contentView.heightAnchor.constraint(equalToConstant: 112),
            
            indicatorView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            indicatorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            messageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            messageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -18)
        ])
        
        overlayView.alpha = 0
        UIView.animate(withDuration: 0.16) {
            overlayView.alpha = 1
        }
    }
    
    static func hideLoading(in view: UIView? = nil) {
        guard let view = targetView(from: view),
              let overlayView = view.viewWithTag(loadingTag) else {
            return
        }
        
        UIView.animate(withDuration: 0.12, animations: {
            overlayView.alpha = 0
        }, completion: { _ in
            overlayView.removeFromSuperview()
        })
    }
    
    static func showToast(_ message: String, in view: UIView? = nil, duration: TimeInterval = 1.5) {
        guard let view = targetView(from: view), !message.isEmpty else { return }
        view.viewWithTag(toastTag)?.removeFromSuperview()
        
        let containerView = UIView()
        containerView.tag = toastTag
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0.78)
        containerView.layer.cornerRadius = 12
        containerView.layer.masksToBounds = true
        view.addSubview(containerView)
        
        let messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.text = message
        messageLabel.textColor = .white
        messageLabel.font = TendiFont.custom("MiSansLatin-Regular", size: 14)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        containerView.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 28),
            containerView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -28),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -72),
            
            messageLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 18),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -18),
            messageLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12)
        ])
        
        containerView.alpha = 0
        containerView.transform = CGAffineTransform(translationX: 0, y: 8)
        UIView.animate(withDuration: 0.18) {
            containerView.alpha = 1
            containerView.transform = .identity
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            UIView.animate(withDuration: 0.18, animations: {
                containerView.alpha = 0
                containerView.transform = CGAffineTransform(translationX: 0, y: 8)
            }, completion: { _ in
                containerView.removeFromSuperview()
            })
        }
    }
    
    static func showPrompt(
        in view: UIView? = nil,
        title: String,
        message: String,
        primaryTitle: String = "OK",
        secondaryTitle: String? = nil,
        primaryAction: (() -> Void)? = nil,
        secondaryAction: (() -> Void)? = nil
    ) {
        guard let view = targetView(from: view) else { return }
        guard view.viewWithTag(promptTag) == nil else { return }
        
        let promptView = TendiPromptView(
            title: title,
            message: message,
            primaryTitle: primaryTitle,
            secondaryTitle: secondaryTitle,
            primaryAction: primaryAction,
            secondaryAction: secondaryAction
        )
        promptView.tag = promptTag
        promptView.show(in: view)
    }
    
    private static func targetView(from view: UIView?) -> UIView? {
        if let view {
            return view
        }
        
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }
}

private final class TendiPromptView: UIView {
    private let primaryAction: (() -> Void)?
    private let secondaryAction: (() -> Void)?
    
    init(
        title: String,
        message: String,
        primaryTitle: String,
        secondaryTitle: String?,
        primaryAction: (() -> Void)?,
        secondaryAction: (() -> Void)?
    ) {
        self.primaryAction = primaryAction
        self.secondaryAction = secondaryAction
        super.init(frame: .zero)
        setup(title: title, message: message, primaryTitle: primaryTitle, secondaryTitle: secondaryTitle)
    }
    
    required init?(coder: NSCoder) {
        self.primaryAction = nil
        self.secondaryAction = nil
        super.init(coder: coder)
    }
    
    func show(in view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.black.withAlphaComponent(0.55)
        alpha = 0
        view.addSubview(self)
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let contentView = subviews.first
        contentView?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1
            contentView?.transform = .identity
        }
    }
    
    private func setup(title: String, message: String, primaryTitle: String, secondaryTitle: String?) {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.clipsToBounds = true
        addSubview(contentView)
        
        let backgroundImageView = UIImageView(image: UIImage(named: "login_kk"))
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.contentMode = .scaleToFill
        contentView.addSubview(backgroundImageView)
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        titleLabel.textColor = UIColor(red: 28 / 255.0, green: 28 / 255.0, blue: 30 / 255.0, alpha: 1)
        titleLabel.font = TendiFont.custom("MiSansLatin-Heavy", size: 20, fallbackWeight: .heavy)
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)
        
        let messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.text = message
        messageLabel.textColor = UIColor(red: 74 / 255.0, green: 74 / 255.0, blue: 78 / 255.0, alpha: 1)
        messageLabel.font = TendiFont.custom("MiSansLatin-Regular", size: 14)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        contentView.addSubview(messageLabel)
        
        let primaryButton = makeButton(title: primaryTitle, isPrimary: true)
        primaryButton.translatesAutoresizingMaskIntoConstraints = false
        primaryButton.addTarget(self, action: #selector(primaryButtonTapped), for: .touchUpInside)
        contentView.addSubview(primaryButton)
        
        var buttonConstraints: [NSLayoutConstraint] = []
        if let secondaryTitle {
            let secondaryButton = makeButton(title: secondaryTitle, isPrimary: false)
            secondaryButton.translatesAutoresizingMaskIntoConstraints = false
            secondaryButton.addTarget(self, action: #selector(secondaryButtonTapped), for: .touchUpInside)
            contentView.addSubview(secondaryButton)
            
            buttonConstraints = [
                secondaryButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
                secondaryButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -26),
                secondaryButton.heightAnchor.constraint(equalToConstant: 40),
                
                primaryButton.leadingAnchor.constraint(equalTo: secondaryButton.trailingAnchor, constant: 12),
                primaryButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
                primaryButton.bottomAnchor.constraint(equalTo: secondaryButton.bottomAnchor),
                primaryButton.heightAnchor.constraint(equalTo: secondaryButton.heightAnchor),
                primaryButton.widthAnchor.constraint(equalTo: secondaryButton.widthAnchor)
            ]
        } else {
            buttonConstraints = [
                primaryButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                primaryButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -26),
                primaryButton.widthAnchor.constraint(equalToConstant: 128),
                primaryButton.heightAnchor.constraint(equalToConstant: 40)
            ]
        }
        
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: centerYAnchor),
            contentView.widthAnchor.constraint(equalToConstant: 275),
            contentView.heightAnchor.constraint(equalToConstant: 195),
            
            backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 36),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            messageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 28),
            messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -28)
        ] + buttonConstraints)
    }
    
    private func makeButton(title: String, isPrimary: Bool) -> UIButton {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.titleLabel?.font = TendiFont.custom("MiSansLatin-Heavy", size: 15, fallbackWeight: .heavy)
        button.setTitle(title, for: .normal)
        
        if isPrimary {
            button.backgroundColor = UIColor(red: 95 / 255.0, green: 233 / 255.0, blue: 157 / 255.0, alpha: 1)
            button.setTitleColor(UIColor(red: 18 / 255.0, green: 36 / 255.0, blue: 28 / 255.0, alpha: 1), for: .normal)
        } else {
            button.backgroundColor = UIColor.white.withAlphaComponent(0.75)
            button.layer.borderColor = UIColor(red: 195 / 255.0, green: 212 / 255.0, blue: 202 / 255.0, alpha: 1).cgColor
            button.layer.borderWidth = 1
            button.setTitleColor(UIColor(red: 54 / 255.0, green: 62 / 255.0, blue: 58 / 255.0, alpha: 1), for: .normal)
        }
        
        return button
    }
    
    @objc private func primaryButtonTapped() {
        dismiss { [primaryAction] in
            primaryAction?()
        }
    }
    
    @objc private func secondaryButtonTapped() {
        dismiss { [secondaryAction] in
            secondaryAction?()
        }
    }
    
    private func dismiss(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.16, animations: {
            self.alpha = 0
        }, completion: { _ in
            self.removeFromSuperview()
            completion?()
        })
    }
}
