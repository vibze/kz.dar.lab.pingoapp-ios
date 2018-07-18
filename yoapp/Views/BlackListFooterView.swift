//
//  BlackListFooterView.swift
//  yoapp
//
//  Created by Kamila Kusainova on 15.07.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class BlackListFooterView: UIView {
    
    let emptyLabel = UILabel.basic(textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), fontSize: 16, fontType: .mySemiBold)
    let emptyImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(emptyLabel)
        self.addSubview(emptyImage)
        setUpView()
    }
    
    func setUpView() {
        emptyLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(30)
            $0.centerX.equalToSuperview()
        }
        
        emptyImage.snp.makeConstraints {
            $0.top.equalTo(emptyLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(160)
        }
    }
    
    func viewData(text: String, image: UIImage) {
        emptyLabel.text = text
        emptyImage.image = image
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
