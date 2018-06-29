//
//  PushAlert.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/22/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import Foundation
import UIKit

class PushAlert: UIView {
    let submitButton = ActionButton(title: "OK", type: .write)
    
    let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "6BBE90")
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor(hexString: "5AA079").cgColor
        view.layer.borderWidth = 5
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "alert")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let alertLabel: UILabel = {
        let label = UILabel()
        label.text = "Пуш в пути"
        label.font = UIFont(name: "Avenir Next", size: 18)
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return label
    }()
    
    required init() {
        super.init(frame: .zero)
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6)
        isHidden = true
        
        submitButton.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
        setupViews()
    }
    
    @objc func submitButtonPressed() {
        isHidden = true
    }
    
    func setupViews() {
        addSubview(alertView)
        [imageView, alertLabel, submitButton].forEach {
            alertView.addSubview($0)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(alertView.snp.top).offset(12)
            $0.centerX.equalTo(self.snp.centerX)
            $0.width.equalTo(142)
            $0.height.equalTo(93)
        }
        alertLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom)
            $0.centerX.equalTo(self.snp.centerX)
        }
        submitButton.snp.makeConstraints {
            $0.left.equalTo(alertView.snp.left).offset(60)
            $0.top.equalTo(alertLabel.snp.bottom).offset(22)
            $0.width.equalTo(alertView.snp.width).inset(60)
            $0.height.equalTo(50)
        }
        alertView.snp.makeConstraints {
            $0.center.equalTo(self.snp.center)
            $0.left.equalTo(self.snp.left).offset(32)
            $0.width.equalTo(self.snp.width).inset(32)
            $0.height.equalTo(226)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
