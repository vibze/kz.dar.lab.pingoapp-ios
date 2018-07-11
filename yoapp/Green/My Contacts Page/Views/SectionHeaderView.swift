//
//  SectionHeaderView.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/25/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import Foundation
import UIKit

private struct Constants {
    static let allContactsHeader = "Все контакты"
}

class SectionHeaderView: UIView {
    
    let headerView: UIView = {
        let headerView = UIView()
        headerView.backgroundColor = #colorLiteral(red: 0.5058823529, green: 0.8862745098, blue: 0.6666666667, alpha: 1)
        return headerView
    }()

    let headerLabel = UILabel.basic(textColor: #colorLiteral(red: 0.1882352941, green: 0.5294117647, blue: 0.3411764706, alpha: 1), fontSize: 16, fontType: .myRegular)
    
    required init() {
        super.init(frame: .zero)
        backgroundColor = #colorLiteral(red: 0.4196078431, green: 0.7450980392, blue: 0.5647058824, alpha: 1)
        headerLabel.text = Constants.allContactsHeader
        headerLabel.textAlignment = .left
        setupViews()
    }
    
    func setupViews() {
        headerView.addSubview(headerLabel)
        addSubview(headerView)
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(5)
            $0.left.equalTo(self.snp.left).offset(0)
            $0.width.equalTo(self.snp.width)
            $0.height.equalTo(25)
        }
        headerLabel.snp.makeConstraints {
            $0.top.equalTo(self.snp.top).offset(5)
            $0.left.equalTo(self.snp.left).offset(20)
            $0.width.equalTo(self.snp.width)
            $0.height.equalTo(25)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
