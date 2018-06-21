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
            FirstImageView.image = UIImage(named: unwrappedPage.imageName)
        }
    }
    
    private let FirstImageView: UIImageView = {
        let imageView = UIImageView(image : UIImage(named: "preview")!)
        imageView.layer.borderWidth = 4
        imageView.layer.cornerRadius = 10
        imageView.layer.borderColor = UIColor(red: 168/255, green: 60/255, blue: 76/255, alpha: 0.5).cgColor
        return imageView
    }()
    private let pageControl: UIPageControl = {
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
    private func setupLayout() {
        let previewImage = UIView()
        addSubview(previewImage)
        previewImage.snp.makeConstraints{(make) in
            make.height.equalTo(231)
            make.width.equalTo(311)
            make.top.equalTo(75)
            make.left.equalTo(32)
            make.right.equalTo(-32)
            
            previewImage.addSubview(FirstImageView) 
        }
    }
    //    func infoLabel(){
    //        view.addSubview(previewImage)
    //        previewImage.image = #imageLiteral(resourceName: "preview")
    //        previewImage.snp.makeConstraints{(make) in
    //            make.height.equalTo(231)
    //            make.width.equalTo(311)
    //            make.top.equalTo(75)
    //            make.left.equalTo(32)
    //            make.right.equalTo(-32)
    //        }
    //    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
