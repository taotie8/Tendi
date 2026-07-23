import UIKit

class Tendi_VideoChatViewController: UIViewController {

    var user: TendiLocalUser?

    private let gradientLayer = CAGradientLayer()
    private let dimLayer = CAGradientLayer()
    private let remoteAvatarHaloView = UIView()
    private let remoteAvatarImageView = TendiVideoRoundImageView()
    private let remoteNameLabel = UILabel()
    private let durationLabel = UILabel()
    private let localPreviewView = UIView()
    private let localAvatarImageView = TendiVideoRoundImageView()
    private let localNameLabel = UILabel()
    private let endButton = UIButton(type: .custom)

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUsers()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
        dimLayer.frame = view.bounds
        remoteAvatarHaloView.layer.cornerRadius = min(remoteAvatarHaloView.bounds.width, remoteAvatarHaloView.bounds.height) / 2
        localPreviewView.layer.cornerRadius = 18
        endButton.layer.cornerRadius = endButton.bounds.width / 2
    }

    private func setupUI() {
        view.backgroundColor = UIColor(red: 16 / 255.0, green: 22 / 255.0, blue: 21 / 255.0, alpha: 1)

        gradientLayer.colors = [
            UIColor(red: 28 / 255.0, green: 47 / 255.0, blue: 42 / 255.0, alpha: 1).cgColor,
            UIColor(red: 14 / 255.0, green: 17 / 255.0, blue: 20 / 255.0, alpha: 1).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.1, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.9, y: 1)
        view.layer.insertSublayer(gradientLayer, at: 0)

        dimLayer.colors = [
            UIColor.black.withAlphaComponent(0.06).cgColor,
            UIColor.black.withAlphaComponent(0.28).cgColor
        ]
        dimLayer.startPoint = CGPoint(x: 0.5, y: 0)
        dimLayer.endPoint = CGPoint(x: 0.5, y: 1)
        view.layer.insertSublayer(dimLayer, above: gradientLayer)

        setupLocalPreview()
        setupRemoteUser()
        setupEndButton()
    }

    private func setupLocalPreview() {
        localPreviewView.translatesAutoresizingMaskIntoConstraints = false
        localPreviewView.backgroundColor = UIColor.white.withAlphaComponent(0.13)
        localPreviewView.layer.borderColor = UIColor.white.withAlphaComponent(0.22).cgColor
        localPreviewView.layer.borderWidth = 1
        localPreviewView.layer.masksToBounds = true
        view.addSubview(localPreviewView)

        localAvatarImageView.translatesAutoresizingMaskIntoConstraints = false
        localAvatarImageView.contentMode = .scaleAspectFill
        localAvatarImageView.clipsToBounds = true
        localPreviewView.addSubview(localAvatarImageView)

        localNameLabel.translatesAutoresizingMaskIntoConstraints = false
        localNameLabel.textColor = .white
        localNameLabel.font = TendiFont.custom("MiSansLatin-Medium", size: 12, fallbackWeight: .medium)
        localNameLabel.textAlignment = .center
        localNameLabel.lineBreakMode = .byTruncatingTail
        localPreviewView.addSubview(localNameLabel)

        NSLayoutConstraint.activate([
            localPreviewView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
            localPreviewView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            localPreviewView.widthAnchor.constraint(equalToConstant: 112),
            localPreviewView.heightAnchor.constraint(equalToConstant: 152),

            localAvatarImageView.centerXAnchor.constraint(equalTo: localPreviewView.centerXAnchor),
            localAvatarImageView.topAnchor.constraint(equalTo: localPreviewView.topAnchor, constant: 30),
            localAvatarImageView.widthAnchor.constraint(equalToConstant: 64),
            localAvatarImageView.heightAnchor.constraint(equalTo: localAvatarImageView.widthAnchor),

            localNameLabel.leadingAnchor.constraint(equalTo: localPreviewView.leadingAnchor, constant: 10),
            localNameLabel.trailingAnchor.constraint(equalTo: localPreviewView.trailingAnchor, constant: -10),
            localNameLabel.topAnchor.constraint(equalTo: localAvatarImageView.bottomAnchor, constant: 16)
        ])
    }

    private func setupRemoteUser() {
        remoteAvatarHaloView.translatesAutoresizingMaskIntoConstraints = false
        remoteAvatarHaloView.backgroundColor = UIColor(red: 128 / 255.0, green: 223 / 255.0, blue: 180 / 255.0, alpha: 0.14)
        remoteAvatarHaloView.layer.borderColor = UIColor.white.withAlphaComponent(0.14).cgColor
        remoteAvatarHaloView.layer.borderWidth = 1
        remoteAvatarHaloView.layer.cornerCurve = .continuous
        remoteAvatarHaloView.layer.masksToBounds = true
        view.addSubview(remoteAvatarHaloView)

        remoteAvatarImageView.translatesAutoresizingMaskIntoConstraints = false
        remoteAvatarImageView.contentMode = .scaleAspectFill
        remoteAvatarImageView.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        remoteAvatarImageView.layer.borderWidth = 2
        remoteAvatarImageView.layer.borderColor = UIColor.white.withAlphaComponent(0.9).cgColor
        remoteAvatarHaloView.addSubview(remoteAvatarImageView)

        remoteNameLabel.translatesAutoresizingMaskIntoConstraints = false
        remoteNameLabel.textColor = .white
        remoteNameLabel.font = TendiFont.custom("MiSansLatin-Heavy", size: 28, fallbackWeight: .heavy)
        remoteNameLabel.textAlignment = .center
        remoteNameLabel.numberOfLines = 1
        remoteNameLabel.adjustsFontSizeToFitWidth = true
        remoteNameLabel.minimumScaleFactor = 0.72
        view.addSubview(remoteNameLabel)

        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        durationLabel.textColor = UIColor.white.withAlphaComponent(0.72)
        durationLabel.font = TendiFont.custom("MiSansLatin-Medium", size: 15, fallbackWeight: .medium)
        durationLabel.textAlignment = .center
        durationLabel.text = "Connecting..."
        view.addSubview(durationLabel)

        NSLayoutConstraint.activate([
            remoteAvatarHaloView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            remoteAvatarHaloView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -74),
            remoteAvatarHaloView.widthAnchor.constraint(equalToConstant: 172),
            remoteAvatarHaloView.heightAnchor.constraint(equalTo: remoteAvatarHaloView.widthAnchor),

            remoteAvatarImageView.centerXAnchor.constraint(equalTo: remoteAvatarHaloView.centerXAnchor),
            remoteAvatarImageView.centerYAnchor.constraint(equalTo: remoteAvatarHaloView.centerYAnchor),
            remoteAvatarImageView.widthAnchor.constraint(equalToConstant: 132),
            remoteAvatarImageView.heightAnchor.constraint(equalTo: remoteAvatarImageView.widthAnchor),

            remoteNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            remoteNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            remoteNameLabel.topAnchor.constraint(equalTo: remoteAvatarHaloView.bottomAnchor, constant: 28),

            durationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            durationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            durationLabel.topAnchor.constraint(equalTo: remoteNameLabel.bottomAnchor, constant: 10)
        ])
    }

    private func setupEndButton() {
        endButton.translatesAutoresizingMaskIntoConstraints = false
        endButton.setImage(UIImage(named: "end_video"), for: .normal)
        endButton.imageView?.contentMode = .scaleAspectFit
        endButton.accessibilityLabel = "End video"
        endButton.addTarget(self, action: #selector(endVideoTapped), for: .touchUpInside)
        view.addSubview(endButton)

        NSLayoutConstraint.activate([
            endButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            endButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -34),
            endButton.widthAnchor.constraint(equalToConstant: 72),
            endButton.heightAnchor.constraint(equalTo: endButton.widthAnchor)
        ])
    }

    private func configureUsers() {
        let remoteUser = user
        remoteAvatarImageView.image = avatarImage(named: remoteUser?.avatarImageName)
        remoteNameLabel.text = remoteUser?.nickname ?? "Tendi user"

        if let currentUser = TendiLocalDataStore.shared.currentUserProfile {
            localAvatarImageView.image = avatarImage(named: currentUser.avatarImageName)
            localNameLabel.text = currentUser.nickname
        } else {
            localAvatarImageView.image = avatarImage(named: nil)
            localNameLabel.text = "Me"
        }
    }

    private func avatarImage(named imageName: String?) -> UIImage? {
        if let imageName, imageName.isEmpty == false, let image = UIImage(named: imageName) {
            return image
        }

        return UIImage(named: "tendi_avatar")
    }

    @objc private func endVideoTapped() {
        if let navigationController {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true)
        }
    }
}

private final class TendiVideoRoundImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = min(bounds.width, bounds.height) / 2
        layer.cornerCurve = .continuous
        layer.masksToBounds = true
    }
}
