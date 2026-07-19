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
    private var reportAction: (() -> Void)?
    private var blockAction: (() -> Void)?

    static func show(
        in view: UIView,
        reportAction: (() -> Void)? = nil,
        blockAction: (() -> Void)? = nil
    ) {
        guard view.viewWithTag(viewTag) == nil,
              let chooseMoeView = Bundle.main.loadNibNamed("ChooseMoeView", owner: nil)?.first as? ChooseMoeView else {
            return
        }

        chooseMoeView.tag = viewTag
        chooseMoeView.reportAction = reportAction
        chooseMoeView.blockAction = blockAction
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
        dismiss { [reportAction, blockAction] in
            if sender.tag == 985 {
                reportAction?()
            } else if sender.tag == 986 {
                blockAction?()
            }
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
    
}
