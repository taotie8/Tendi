
import UIKit

class BaseViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 27 / 255.0, green: 27 / 255.0, blue: 28 / 255.0, alpha: 1)
        navigationBar()
    }
    
    private func navigationBar() {
        let nav_apance = UINavigationBarAppearance()
        nav_apance.configureWithOpaqueBackground()
        nav_apance.backgroundColor = .clear
        nav_apance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: TendiFont.custom("MiSansLatin-Heavy", size: 18, fallbackWeight: .heavy)
        ]
        nav_apance.shadowColor = nil
        
        navigationController?.navigationBar.standardAppearance = nav_apance
        navigationController?.navigationBar.scrollEdgeAppearance = nav_apance
        navigationController?.setNavigationBarHidden(false, animated: true)
        view.backgroundColor = UIColor(red: 27 / 255.0, green: 27 / 255.0, blue: 28 / 255.0, alpha: 1)
        
        if navigationController?.viewControllers.count ?? 0 > 1 {
            let backButton = UIButton(type: .custom)
            backButton.translatesAutoresizingMaskIntoConstraints = false
            backButton.setImage(UIImage(named: "base_back"), for: .normal)
            backButton.imageView?.contentMode = .scaleAspectFit
            backButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
            backButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
            backButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
            backButton.addTarget(self, action: #selector(navBackAction), for: .touchUpInside)
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        }
    }
    
    @objc func navBackAction() {
        navigationController?.popViewController(animated: true)
    }

}
