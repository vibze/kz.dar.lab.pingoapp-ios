//
//  AlertView.swift
//  yoapp
//
//  Created by Kamila Kusainova on 02.07.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class AlertView: UIView {
    
    var okButton: UIButton =  {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        button.isEnabled = true
        button.layer.cornerRadius = 10
        button.layer.borderColor = #colorLiteral(red: 0.1568627451, green: 0.4784313725, blue: 1, alpha: 1)
        button.layer.borderWidth = 5
        button.setTitle("OK", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.9803921569, green: 0.3529411765, blue: 0.3411764706, alpha: 1), for: .normal)
        return button
    }()
    
    let imgView = UIImageView()
    let errorTypeLabel = UILabel.basic(textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), fontSize: 18, fontType: .mySemiBold)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(hexString: "3C97E8")
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 5
        self.layer.borderColor = UIColor(hexString: "3070CD").cgColor
        
        self.addSubview(imgView)
        self.addSubview(errorTypeLabel)
        self.addSubview(okButton)
        configView()
    }
    
    func configView(){
        imgView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(30)
            $0.left.equalToSuperview().offset(88)
            $0.right.equalToSuperview().offset(-88)
            $0.bottom.equalTo(-115)
        }
        
        errorTypeLabel.snp.makeConstraints{
            $0.top.equalTo(imgView.snp.bottom).offset(10)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalTo(okButton.snp.top)
        }
        
        okButton.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-12)
            $0.left.equalToSuperview().offset(64)
            $0.right.equalToSuperview().offset(-64)
            $0.height.equalTo(50)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
