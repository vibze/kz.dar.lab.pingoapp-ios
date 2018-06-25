//
//  PageCell.swift
//  yoapp
//
//  Created by Arthur Belyankov on 21.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class ImageSwypeCell: UICollectionViewCell {
    var page: ImageSwypeStruct? {
        didSet {
            guard let unwrappedPage = page else { return }
            firstImageView.image = UIImage(named: unwrappedPage.imageName)
        }
    }
    
     let firstImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.layer.borderWidth = 4
//        imageView.layer.cornerRadius = 10
//        imageView.layer.borderColor = UIColor(red: 168/255, green: 60/255, blue: 76/255, alpha: 0.5).cgColor
        return imageView
    }()
    
     let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 3
        pc.currentPageIndicatorTintColor = .black
        pc.pageIndicatorTintColor = .black
        return pc
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
     func setupLayout() {
        addSubview(firstImageView)
        firstImageView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview()
//            make.top.equalTo(0)
//            make.leading.equalTo(0)
//            make.trailing.equalTo(0)
//            make.height.equalTo(231)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
