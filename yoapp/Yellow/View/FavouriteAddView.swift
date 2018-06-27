//
//  FavouriteAddView.swift
//  yoapp
//
//  Created by Kamila Kusainova on 26.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class FavouriteAddView: UIView, UITextViewDelegate {
    
    var aboutLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.text = "Ваша избранная фраза"
        label.font = UIFont(name: "ProximaNovaSoft-Bold", size: 18)
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return label
    }()
    
    var inputWord: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        textField.text = " "
        textField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textField.clipsToBounds = true
        textField.textAlignment = .left
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.font = UIFont(name: "ProximaNovaSoft-Bold", size: 18)
        return textField
    }()
    
    var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отменить", for: .normal)
        button.backgroundColor = .myPurple
        button.titleLabel?.font = UIFont(name: "ProximaNovaSoft-Medium", size: 18)
        return button
    }()
    
    var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить", for: .normal)
        button.backgroundColor = .myPurple
        button.titleLabel?.font = UIFont(name: "ProximaNovaSoft-Medium", size: 18)
        return button
    }()
    
    let  stackView: UIStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(aboutLabel)
        self.addSubview(inputWord)
        self.addSubview(stackView)
//        self.addSubview(cancelButton)
//        self.addSubview(addButton)
        
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor(hexString: "FEC95F")
        self.layer.borderColor = UIColor.myYellow.cgColor
        self.layer.borderWidth = 5
        setUpViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addButton.roundCorners(corners: .bottomLeft, radius: 10)
        cancelButton.roundCorners(corners: .bottomRight, radius: 10)
    }
    
    
    func setUpViews(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneBTN = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.temp))
        
        toolBar.setItems([flexible, doneBTN], animated: false)
        
        inputWord.inputAccessoryView = toolBar
        
        aboutLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(36)
            $0.centerX.equalToSuperview().offset(0)
        }
        
        inputWord.snp.makeConstraints{
            $0.top.equalTo(aboutLabel.snp.bottom).offset(24)
            $0.height.equalTo(50)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
        
        stackView.snp.makeConstraints{
            $0.height.equalTo(inputWord)
            $0.left.right.equalTo(0)
            $0.bottom.equalTo(0)
        }
        
        configStackView()
    }
    
    func configStackView(){
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 1
        
        stackView.addArrangedSubview(addButton)
        stackView.addArrangedSubview(cancelButton)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder
        return true
    }
    
    @objc func temp(){
        self.endEditing(true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
