//
//  ComposeViewController.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/21/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    override var prefersStatusBarHidden: Bool {
        return true
    }
    let profileImageView = ImageView(radius: 90 / 2)
    let composeButton = ActionButton(title: "Отправить сообщение", type: .write)
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.text = "asasdasdas"
        label.font = UIFont(name: "Avenir Next", size: 20)
        return label
    }()
    
    let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.text = "870707007070"
        label.font = UIFont(name: "Avenir Next", size: 16)
        return label
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "left-arrow"), for: .normal)
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let messageTextField: UITextField = {
        let textField = UITextField()
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 10
        textField.isUserInteractionEnabled = true
        textField.layer.borderColor = UIColor(hexString: "5AA079").cgColor
        textField.layer.borderWidth = 5
        textField.borderStyle = .none
        textField.font = UIFont(name: "Avenir Next", size: 18)
        textField.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(16, 0, 0)
        
        return textField
    }()
    
    @objc func backButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func composeButtonPressed() {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        self.messageTextField.delegate = self
        composeButton.addTarget(self, action: #selector(composeButtonPressed), for: .touchUpInside)
        view.backgroundColor = UIColor(hexString: "6BBE90")
    }
    
    func setupViews() {
        [profileImageView, backButton, phoneNumberLabel, nameLabel, messageTextField].forEach {
            view.addSubview($0)
        }
        
        backButton.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(32)
            $0.height.width.equalTo(24)
        }
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(14)
            $0.centerX.equalTo(self.view.center)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(16)
            $0.centerX.equalTo(self.view.center)
        }
        phoneNumberLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.centerX.equalTo(self.view.center)
        }
        messageTextField.snp.makeConstraints {
            $0.top.equalTo(phoneNumberLabel.snp.bottom).offset(24)
            $0.left.equalToSuperview().offset(32)
            $0.width.equalToSuperview().inset(32)
            $0.height.equalTo(100)
        }
        composeButton.snp.makeConstraints {
            $0.top.equalTo(messageTextField.snp.bottom).offset(24)
            $0.left.equalToSuperview().offset(32)
            $0.width.equalToSuperview().inset(32)
            $0.height.equalTo(50)
        }
    }
}

extension ComposeViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.leftViewMode = UITextFieldViewMode.never
        textField.leftViewMode = .never
        self.hideKeyboard()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            if text.count == 0 {
                textField.leftViewMode = UITextFieldViewMode.always
                textField.leftViewMode = .always
            }
        }
    }
}


