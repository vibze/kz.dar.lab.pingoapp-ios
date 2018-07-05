//
//  PageCell.swift
//  yoapp
//
//  Created by Arthur Belyankov on 21.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class ImageSwipeCell: UICollectionViewCell {
    var page: ImageSwipeStruct? {
        didSet {
            guard let unwrappedPage = page else { return }
            firstImageView.image = UIImage(named: unwrappedPage.imageName)
        }
    }
    
     let firstImageView: UIImageView = {
        let imageView = UIImageView()
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
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
