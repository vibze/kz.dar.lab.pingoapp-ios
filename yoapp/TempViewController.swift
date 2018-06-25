//
//  TempViewController.swift
//  yoapp
//
//  Created by Arthur Belyankov on 21.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit

class TempViewController: UIViewController,
                          UICollectionViewDelegate,
                          UICollectionViewDataSource,
                          UICollectionViewDelegateFlowLayout {

    let swypePage = ["preview","preview","preview"]
    
    let firstImageView: UIView = {
        let imageView = UIView()
        return imageView
    }()
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = swypePage.count
        pc.currentPageIndicatorTintColor = UIColor(red: 153/255, green: 69/255, blue: 113/255, alpha: 1)
        pc.pageIndicatorTintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        return pc
    }()
    
    let smallBubbleImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "login_screen_small_bubble")
        return iv
    }()

    var bottomControllView = UIStackView()

     lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.CVLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ImageSwypeCell.self, forCellWithReuseIdentifier: "Cell")
        return collectionView
    }()
    
     lazy  var CVLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 237/255, green: 95/255, blue: 117/255, alpha: 1)
        setupBottomControls()
        setupCollectionView()
        collectionView.register(ImageSwypeCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.isPagingEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupCollectionView(){
        view.addSubview(collectionView)
        collectionView.layer.borderWidth = 4
        collectionView.layer.cornerRadius = 12
        collectionView.layer.borderColor = UIColor(red: 168/255, green: 60/255, blue: 76/255, alpha: 0.5).cgColor
        collectionView.snp.makeConstraints{
            $0.top.equalTo(75)
            $0.left.equalTo(32)
            $0.right.equalTo(-32)
            $0.bottom.equalTo(bottomControllView.snp.top).offset(-32)
        }
        
        veiw.addSubview(smallBubbleImageView)
        smallBubbleImageView.snp.makeConstraints{
            $0.top.equalTo(bottomControllView.snp.bottom).offset(32)
            $0.centerX.equalToSuperview(bottomControllView)
        }
    }
    
    func setupBottomControls() {
        bottomControllView = UIStackView(arrangedSubviews: [pageControl])
        bottomControllView.backgroundColor = .red
        view.addSubview(bottomControllView)
        bottomControllView.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.width.equalTo(50)
            $0.height.equalTo(10)
        }
    }
    
    @objc func handlePrev() {
        let nextIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc func handleNext() {
        let nextIndex = min(pageControl.currentPage + 1, swypePage.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
     func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / scrollView.frame.width)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return swypePage.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageSwypeCell
        cell.firstImageView.image = UIImage(named: swypePage[indexPath.row])

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}

