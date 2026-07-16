
import UIKit

class BaseTabbarController: UITabBarController {
    
    private struct TabItem {
        let viewController: UIViewController
        let normalImageName: String
        let selectedImageName: String
    }
    
    private let customTabBarView = UIView()
    private var tabButtons: [UIButton] = []
    private var tabButtonWidthConstraints: [NSLayoutConstraint] = []
    
    private let customTabBarHeight: CGFloat = 86
    private let normalItemWidth: CGFloat = 64
    private let selectedItemWidth: CGFloat = 122
    private let itemSpacing: CGFloat = 8

    override func viewDidLoad() {
        super.viewDidLoad()

        let items = [
            TabItem(viewController: Tendi_HomeViewController(), normalImageName: "tendi_home", selectedImageName: "tendi_home_s"),
            TabItem(viewController: ViewController(), normalImageName: "tendi_find", selectedImageName: "tendi_find_s"),
            TabItem(viewController: ViewController(), normalImageName: "tendi_message", selectedImageName: "tendi_message_s"),
            TabItem(viewController: ViewController(), normalImageName: "tendi_mine", selectedImageName: "tendi_mine_s")
        ]
        
        viewControllers = items.map { makeRootViewController(for: $0.viewController) }
        tabBar.isHidden = true
        setupCustomTabBar(with: items)
        updateTabBarSelection()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.isHidden = true
        view.bringSubviewToFront(customTabBarView)
    }
    
    private func makeRootViewController(for viewController: UIViewController) -> UIViewController {
        let rootVC = UINavigationController(rootViewController: viewController)
        rootVC.additionalSafeAreaInsets.bottom = customTabBarHeight
        return rootVC
    }
    
    private func setupCustomTabBar(with items: [TabItem]) {
        customTabBarView.translatesAutoresizingMaskIntoConstraints = false
        customTabBarView.backgroundColor = .white
        view.addSubview(customTabBarView)
        
        NSLayoutConstraint.activate([
            customTabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customTabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customTabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            customTabBarView.heightAnchor.constraint(equalToConstant: customTabBarHeight)
        ])
        
        for (index, item) in items.enumerated() {
            let button = makeTabButton(item: item, index: index)
            customTabBarView.addSubview(button)
            tabButtons.append(button)
            
            let widthConstraint = button.widthAnchor.constraint(equalToConstant: normalItemWidth)
            tabButtonWidthConstraints.append(widthConstraint)
            
            NSLayoutConstraint.activate([
                button.centerYAnchor.constraint(equalTo: customTabBarView.topAnchor, constant: 36),
                button.heightAnchor.constraint(equalToConstant: 56),
                widthConstraint
            ])
            
            if index == 0 {
                button.leadingAnchor.constraint(equalTo: customTabBarView.leadingAnchor, constant: 28).isActive = true
            } else {
                button.leadingAnchor.constraint(equalTo: tabButtons[index - 1].trailingAnchor, constant: itemSpacing).isActive = true
            }
        }
    }
    
    private func makeTabButton(item: TabItem, index: Int) -> UIButton {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = index
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(UIImage(named: item.normalImageName), for: .normal)
        button.setImage(UIImage(named: item.selectedImageName), for: .selected)
        button.addTarget(self, action: #selector(tabButtonTapped), for: .touchUpInside)
        return button
    }
    
    @objc private func tabButtonTapped(_ sender: UIButton) {
        selectedIndex = sender.tag
        updateTabBarSelection()
    }
    
    private func updateTabBarSelection() {
        for (index, button) in tabButtons.enumerated() {
            let isSelected = index == selectedIndex
            button.isSelected = isSelected
            tabButtonWidthConstraints[index].constant = isSelected ? selectedItemWidth : normalItemWidth
        }
        
        UIView.animate(withDuration: 0.2) {
            self.customTabBarView.layoutIfNeeded()
        }
    }
    
}
