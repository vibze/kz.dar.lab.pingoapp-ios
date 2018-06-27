//
//  BlockUserLabelView.swift
//  yoapp
//
//  Created by Kamila Kusainova on 25.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class BlockUserLabelView: UIView {
    
    let titleLabel = UILabel.basic(textColor: .myPurple, fontSize: 12)
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(hexString: "FED88B")
        self.addSubview(titleLabel)
        titleLabel.text = "Заблокированные контакты"
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.left.equalToSuperview().offset(20)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
