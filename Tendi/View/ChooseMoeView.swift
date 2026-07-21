//
//  ChooseMoeView.swift
//  Tendi
//
//  Created by Mac on 2026/7/17.
//

import UIKit

class ChooseMoeView: UIView, UIGestureRecognizerDelegate {

    @IBOutlet private weak var bottomContainerView: UIView!

    private static let viewTag = 920_002
    private weak var navigationController: UINavigationController?

    static func show(
        in view: UIView,
        navigationController: UINavigationController?
    ) {
        guard view.viewWithTag(viewTag) == nil,
              let chooseMoeView = Bundle.main.loadNibNamed("ChooseMoeView", owner: nil)?.first as? ChooseMoeView else {
            return
        }

        chooseMoeView.tag = viewTag
        chooseMoeView.navigationController = navigationController
        chooseMoeView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(chooseMoeView)

        NSLayoutConstraint.activate([
            chooseMoeView.topAnchor.constraint(equalTo: view.topAnchor),
            chooseMoeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chooseMoeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chooseMoeView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        view.layoutIfNeeded()
        chooseMoeView.show()
    }

    static func show(from viewController: UIViewController) {
        let baseView: UIView = viewController.view
        let containerView = baseView.window
            ?? viewController.tabBarController?.view
            ?? viewController.navigationController?.view
            ?? baseView

        show(in: containerView, navigationController: viewController.navigationController)
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

    @IBAction func chooseMoreClick(_ sender: UIButton) {
        if sender.tag == 985 {
            dismiss { [weak self] in
                self?.pushReportDetail()
            }
        } else {
            dismiss()
        }
    }

    @IBAction func chooseCancelClick(_ sender: Any) {
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

    private func pushReportDetail() {
        let reportDetailViewController = ReportDetailViewController()
        reportDetailViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(reportDetailViewController, animated: true)
    }

}
