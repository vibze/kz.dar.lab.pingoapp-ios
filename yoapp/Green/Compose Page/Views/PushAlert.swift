//
//  PushAlert.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/22/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import Foundation
import UIKit

protocol AlerViewDelegate: class {
    func closeButtonTapped(isClosed: Bool)
}

class PushAlert: UIView {
    
    weak var delegate: AlerViewDelegate?
    
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
    
    let alertLabel = UILabel.basic(textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), fontSize: 18, fontType: .mySemiBold)
    
    
    required init() {
        super.init(frame: .zero)
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6)
        isHidden = true
        
        submitButton.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
        setupViews()
    }
    
    @objc func submitButtonPressed() {
        isHidden = true
        delegate?.closeButtonTapped(isClosed: true)
    }
    
    func setupViews() {
        alertLabel.text = "Пуш в Пути"
        addSubview(alertView)
        [imageView, alertLabel, submitButton].forEach {
            alertView.addSubview($0)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.left.equalToSuperview().offset(88)
            $0.right.equalToSuperview().offset(-88)
            $0.bottom.equalTo(-115)
        }
        alertLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(10)
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
        
        alertView.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                if screenHeight == 568{
                    $0.height.equalTo(195)
                }else{
                    $0.height.equalTo(225)
                }
                $0.left.equalToSuperview().offset(24)
                $0.right.equalToSuperview().offset(-24)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
