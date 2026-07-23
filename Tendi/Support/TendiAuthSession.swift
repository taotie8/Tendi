import UIKit

enum TendiAuthSession {
    private static let isLoggedInKey = "TendiAuthSession.isLoggedIn"
    private static let hasCompletedProfileKey = "TendiAuthSession.hasCompletedProfile"

    static var isLoggedIn: Bool {
        UserDefaults.standard.bool(forKey: isLoggedInKey)
    }

    static var hasCompletedProfile: Bool {
        UserDefaults.standard.bool(forKey: hasCompletedProfileKey)
    }

    static func markLoggedIn() {
        UserDefaults.standard.set(true, forKey: isLoggedInKey)
        UserDefaults.standard.set(true, forKey: hasCompletedProfileKey)
    }

    static func markProfileCompletionRequired() {
        UserDefaults.standard.set(true, forKey: isLoggedInKey)
        UserDefaults.standard.set(false, forKey: hasCompletedProfileKey)
    }

    static func markLoggedOut() {
        UserDefaults.standard.set(false, forKey: isLoggedInKey)
        UserDefaults.standard.set(false, forKey: hasCompletedProfileKey)
    }

    static func makeInitialRootViewController() -> UIViewController {
        if isLoggedIn && hasCompletedProfile {
            return makeMainRootViewController()
        }

        if isLoggedIn {
            return makeProfileCompletionRootViewController()
        }

        return makeAuthRootViewController()
    }

    static func switchToMain(from view: UIView) {
        markLoggedIn()
        switchRoot(from: view, to: makeMainRootViewController())
    }

    static func switchToAuth(from view: UIView) {
        markLoggedOut()
        switchRoot(from: view, to: makeAuthRootViewController())
    }

    private static func makeAuthRootViewController() -> UIViewController {
        let navigationController = UINavigationController(rootViewController: AuthMainViewController())
        navigationController.setNavigationBarHidden(true, animated: false)
        return navigationController
    }

    private static func makeMainRootViewController() -> UIViewController {
        let navigationController = UINavigationController(rootViewController: BaseTabbarController())
        navigationController.setNavigationBarHidden(true, animated: false)
        return navigationController
    }

    private static func makeProfileCompletionRootViewController() -> UIViewController {
        let informationViewController = Tendi_InformationViewController()
        informationViewController.completesLoginOnNext = true
        informationViewController.profileUser = TendiLocalDataStore.shared.currentUserProfile

        let navigationController = UINavigationController(rootViewController: informationViewController)
        navigationController.setNavigationBarHidden(true, animated: false)
        return navigationController
    }

    private static func switchRoot(from view: UIView, to rootViewController: UIViewController) {
        guard let window = view.window else { return }

        UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve) {
            window.rootViewController = rootViewController
        }
    }
}
