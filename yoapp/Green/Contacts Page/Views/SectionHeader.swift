//
//  SectionHeader.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/17/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit
import SnapKit

private struct Constants {
    static let searchResult = "Результаты поиска"
    static let allContacts = "Все, кто в теме"
}

class SectionHeader: UICollectionReusableView {
    var sectionInfo: (section: Int, charCount: Int?, isEmpty: Bool)? {
        didSet {
            guard let section = sectionInfo, let charCount = section.charCount else { return }
            changeParameters(sectionIndex: section.section, charCount: charCount, isEmpty: section.isEmpty)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hexString: "81E2AA")
        addSubview(categoryTitleLabel)
        categoryTitleLabel.snp.makeConstraints { (constraint) in
            constraint.left.equalToSuperview().offset(20)
            constraint.top.equalToSuperview().offset(3)
        }
    }
    
    private func changeParameters(sectionIndex: Int, charCount: Int, isEmpty: Bool) {
        if sectionIndex == 1, (charCount > 0 || isEmpty) {
            self.isHidden = true
        }
        else {
            if charCount > 0 {
                self.categoryTitleLabel.text = Constants.searchResult
            }
            else if isEmpty {
                self.categoryTitleLabel.text = Constants.allContacts
            }
            self.isHidden = false
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let categoryTitleLabel: UILabel = {
        let categoryTitleLabel = UILabel()
        categoryTitleLabel.textColor = UIColor.init(hexString: "308757")
        categoryTitleLabel.font = UIFont.systemFont(ofSize: 16)
        categoryTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryTitleLabel.textAlignment = .left
        
        return categoryTitleLabel
    }()
}
