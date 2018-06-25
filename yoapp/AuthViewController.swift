//
//  AuthViewController.swift
//  yoapp
//
//  Created by Kurnmanbay Ayan on 6/20/18.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    // TEST SAMPLE
    
    let nametest = "Ayan"
    let urltest = "qwe@mail.com"
    let passwordtest = "Qwerty123"

    override func viewDidLoad() {
        super.viewDidLoad()
        let user = User(name: nametest, url: urltest, password: passwordtest)
        User.addToUserDefaults(user)
        view.backgroundColor = .red
    }

}
//class AuthViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
//
//    let nametest = "Ayan"
//    let emailtest = "qwe@mail.com"
//    let passwordtest = "Qwerty123"
//    let swypePage = [
//        ImageSwypeStruct(imageName: "preview"),
//        ImageSwypeStruct(imageName: "preview"),
//        ImageSwypeStruct(imageName: "preview")
//    ]
//
//    private lazy var pageControl: UIPageControl = {
//        let pc = UIPageControl()
//        pc.currentPage = 0
//        pc.numberOfPages = swypePage.count
//        pc.currentPageIndicatorTintColor = UIColor(red: 153/255, green: 69/255, blue: 113/255, alpha: 1)
//        pc.pageIndicatorTintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
//        return pc
//    }()
//      var CVLayout: UICollectionViewFlowLayout = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        //        layout.itemSize = CGSize(width: screenWidth / 2.89, height: screenWidth / 2.89)
//        //        layout.minimumLineSpacing = screenWidth / 10.71
//        //        layout.minimumInteritemSpacing = screenWidth / 10.71
//        //        layout.sectionInset = UIEdgeInsets(top: screenWidth / 10.71, left: screenWidth / 9.375, bottom: screenWidth / 10.71, right: screenWidth / 9.375)
//        return layout
//    }()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: CVLayout)
//        let user = User(name: nametest, email: emailtest, password: passwordtest)
//        let userDefaults = UserDefaults.standard
//        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: user)
//        userDefaults.set(encodedData, forKey: "user")
//        userDefaults.synchronize()
//        collectionView?.backgroundColor = UIColor(red: 237/255, green: 95/255, blue: 117/255, alpha: 1)
//        setupBottomControls()
//        collectionView?.register(ImageSwypeCell.self, forCellWithReuseIdentifier: "Cell")
//        collectionView?.isPagingEnabled = true
//    }
//
//    fileprivate func setupBottomControls() {
//        let bottomControlsView = UIStackView(arrangedSubviews: [pageControl])
//        bottomControlsView.backgroundColor = .red
//        view.addSubview(bottomControlsView)
//        bottomControlsView.snp.makeConstraints{(make) in
//            make.height.equalTo(10)
//            make.width.equalTo(50)
//            make.top.equalTo(338)
//            make.left.equalTo(163)
//            make.right.equalTo(-162)
//        }
//    }
/*
    @objc private func handlePrev() {
        let nextIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc private func handleNext() {
        let nextIndex = min(pageControl.currentPage + 1, swypePage.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        
        pageControl.currentPage = Int(x / view.frame.width)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return swypePage.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageSwypeCell
        
        let page = swypePage[indexPath.item]
        cell.page = page
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}

*/
