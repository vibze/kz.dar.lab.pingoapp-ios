//
//  SendAlerView.swift
//  yoapp
//
//  Created by Kamila Kusainova on 16.07.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class SendAlerView: UIView {
    
    let submitButton = ActionButton(title: "OK", type: .write)
    let imgView = UIImageView()
    let alertLabel = UILabel.basic(textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), fontSize: 18, fontType: .mySemiBold)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(hexString: "6BBE90")
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 5
        self.layer.borderColor = UIColor(hexString: "5AA079").cgColor
        
        self.addSubview(imgView)
        self.addSubview(alertLabel)
        self.addSubview(submitButton)
        configView()
    }
    
    func configView(){
        alertLabel.text = "Пуш в Пути"
        imgView.image = #imageLiteral(resourceName: "alert")
        imgView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.left.equalToSuperview().offset(88)
            $0.right.equalToSuperview().offset(-88)
            $0.bottom.equalTo(-115)
        }
        
        alertLabel.snp.makeConstraints {
            $0.top.equalTo(imgView.snp.bottom).offset(10)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalTo(submitButton.snp.top)
        }
        
        submitButton.snp.makeConstraints {
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
