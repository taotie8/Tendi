//
//  Tendi_SettingViewController.swift
//  Tendi
//
//  Created by JIAO on 2026/7/20.
//

import UIKit

class Tendi_SettingViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Setting"
        view.backgroundColor = .white
    }
    
    @IBAction private func editProfileButtonTapped(_ sender: UIButton) {
        let informationViewController = Tendi_InformationViewController()
        informationViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(informationViewController, animated: true)
    }
    
    @IBAction private func blacklistButtonTapped(_ sender: UIButton) {
        let person = Tendi_PersonViewController()
        person.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(person, animated: true)
    }
    
    @IBAction private func userAgreementButtonTapped(_ sender: UIButton) {
        showAgreementPlaceholder(title: "User Agreement")
    }
    
    @IBAction private func privacyAgreementButtonTapped(_ sender: UIButton) {
        showAgreementPlaceholder(title: "Privacy Agreement")
    }
    
    @IBAction private func deleteAccountButtonTapped(_ sender: UIButton) {
        TendiHUD.showPrompt(
            in: view,
            title: "",
            message: "Are you sure you want to delete your account? This operation will permanently delete your account and all your data, which cannot be recovered. Please operate with caution.",
            primaryTitle: "Delete",
            secondaryTitle: "Cancel",
            primaryAction: { [weak self] in
                self?.returnToAuthPage()
            }
        )
    }
    
    @IBAction private func logoutButtonTapped(_ sender: UIButton) {
        TendiHUD.showPrompt(
            in: view,
            title: "Log out",
            message: "Are you sure you want to log out?",
            primaryTitle: "Log out",
            secondaryTitle: "Cancel",
            primaryAction: { [weak self] in
                self?.returnToAuthPage()
            }
        )
    }
    
    private func showAgreementPlaceholder(title: String) {
        TendiHUD.showPrompt(
            in: view,
            title: title,
            message: "This document is not configured yet.",
            primaryTitle: "OK"
        )
    }
    
    private func returnToAuthPage() {
        guard let window = view.window else { return }
        
        let navigationController = UINavigationController(rootViewController: AuthMainViewController())
        navigationController.setNavigationBarHidden(true, animated: false)
        
        UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve) {
            window.rootViewController = navigationController
        }
    }


}
