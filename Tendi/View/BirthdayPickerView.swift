import UIKit

final class BirthdayPickerView: UIView, UIGestureRecognizerDelegate {
    private static let viewTag = 920_002
    
    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let datePicker = UIDatePicker()
    private let cancelButton = UIButton(type: .custom)
    private let confirmButton = UIButton(type: .custom)
    
    private var confirmAction: ((Date) -> Void)?
    
    static func show(
        in view: UIView,
        selectedDate: Date?,
        confirmAction: @escaping (Date) -> Void
    ) {
        guard view.viewWithTag(viewTag) == nil else { return }
        
        let pickerView = BirthdayPickerView(selectedDate: selectedDate, confirmAction: confirmAction)
        pickerView.tag = viewTag
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pickerView)
        
        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: view.topAnchor),
            pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.layoutIfNeeded()
        pickerView.show()
    }
    
    private init(selectedDate: Date?, confirmAction: @escaping (Date) -> Void) {
        self.confirmAction = confirmAction
        super.init(frame: .zero)
        setupView(selectedDate: selectedDate)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView(selectedDate: nil)
    }
    
    private func setupView(selectedDate: Date?) {
        backgroundColor = UIColor.black.withAlphaComponent(0.45)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cancelButtonTapped))
        tapGesture.delegate = self
        addGestureRecognizer(tapGesture)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 28
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.layer.masksToBounds = true
        addSubview(contentView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Choose Birthday"
        titleLabel.textColor = UIColor(red: 24 / 255.0, green: 25 / 255.0, blue: 28 / 255.0, alpha: 1)
        titleLabel.font = TendiFont.custom("MiSansLatin-Heavy", size: 20, fallbackWeight: .heavy)
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.minimumDate = DateComponents(calendar: .current, year: 1900, month: 1, day: 1).date
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -18, to: Date())
        datePicker.date = selectedDate ?? datePicker.maximumDate ?? Date()
        contentView.addSubview(datePicker)
        
        configureButton(cancelButton, title: "Cancel", isPrimary: false)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        contentView.addSubview(cancelButton)
        
        configureButton(confirmButton, title: "Confirm", isPrimary: true)
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        contentView.addSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 370),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            datePicker.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            datePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            datePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            datePicker.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -18),
            
            cancelButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            cancelButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -18),
            cancelButton.heightAnchor.constraint(equalToConstant: 46),
            
            confirmButton.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor, constant: 12),
            confirmButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            confirmButton.bottomAnchor.constraint(equalTo: cancelButton.bottomAnchor),
            confirmButton.heightAnchor.constraint(equalTo: cancelButton.heightAnchor),
            confirmButton.widthAnchor.constraint(equalTo: cancelButton.widthAnchor)
        ])
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let touchedView = touch.view else { return true }
        return !touchedView.isDescendant(of: contentView)
    }
    
    private func configureButton(_ button: UIButton, title: String, isPrimary: Bool) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = TendiFont.custom("MiSansLatin-Heavy", size: 16, fallbackWeight: .heavy)
        button.layer.cornerRadius = 23
        button.layer.masksToBounds = true
        
        if isPrimary {
            button.backgroundColor = UIColor(red: 88 / 255.0, green: 232 / 255.0, blue: 154 / 255.0, alpha: 1)
            button.setTitleColor(UIColor(red: 18 / 255.0, green: 34 / 255.0, blue: 27 / 255.0, alpha: 1), for: .normal)
        } else {
            button.backgroundColor = UIColor(red: 242 / 255.0, green: 244 / 255.0, blue: 243 / 255.0, alpha: 1)
            button.setTitleColor(UIColor(red: 72 / 255.0, green: 78 / 255.0, blue: 75 / 255.0, alpha: 1), for: .normal)
        }
    }
    
    private func show() {
        alpha = 0
        contentView.transform = CGAffineTransform(translationX: 0, y: contentView.bounds.height)
        
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
            self.contentView.transform = .identity
        }
    }
    
    @objc private func cancelButtonTapped() {
        dismiss()
    }
    
    @objc private func confirmButtonTapped() {
        let selectedDate = datePicker.date
        dismiss { [confirmAction] in
            confirmAction?(selectedDate)
        }
    }
    
    private func dismiss(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
            self.contentView.transform = CGAffineTransform(translationX: 0, y: self.contentView.bounds.height)
        }, completion: { _ in
            self.removeFromSuperview()
            completion?()
        })
    }
}
