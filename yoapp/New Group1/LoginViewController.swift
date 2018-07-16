//
//  LoginViewController.swift
//  yoapp
//
//  Created by Arthur Belyankov on 19.06.2018.
//  Copyright © 2018 Kurmanbay Ayan. All rights reserved.
//

import UIKit
import AccountKit

class LoginViewController: UIViewController,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout,
    AKFViewControllerDelegate {
    
    let swypePage = ["balloon","phone","bumb"]
    var accountKit: AKFAccountKit!
    var bottomControllView = UIStackView()
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = swypePage.count
        pc.currentPageIndicatorTintColor = UIColor(red: 153/255, green: 69/255, blue: 113/255, alpha: 1)
        pc.pageIndicatorTintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        return pc
    }()
    
    var descriptionView: RegistrationDescriptionView = {
        let view = RegistrationDescriptionView()
        return view
    }()
    
    let registrationButton = ActionButton(title: "Зарегистрироваться", type: .rgstr)
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.CVLayout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layer.borderWidth = 4
        collectionView.layer.cornerRadius = 12
        collectionView.layer.borderColor = UIColor(red: 168/255, green: 60/255, blue: 76/255, alpha: 0.5).cgColor
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ImageSwipeCell.self, forCellWithReuseIdentifier: "Cell")
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
        self.navigationController?.isNavigationBarHidden = true
        setupBottomControls()
        setupCollectionView()
        collectionView.register(ImageSwipeCell.self, forCellWithReuseIdentifier: "Cell")
        registrationButton.addTarget(self, action: #selector(loginBtnPressed), for: .touchUpInside)
        collectionView.isPagingEnabled = true
        if accountKit == nil {
            self.accountKit = AKFAccountKit(responseType: .accessToken)
        }
    }
    
    func setupCollectionView(){
        view.addSubview(collectionView)
        view.addSubview(descriptionView)
        view.addSubview(registrationButton)
        
        registrationButton.layer.borderColor = UIColor(red: 168/255, green: 60/255, blue: 76/255, alpha: 0.5).cgColor
        collectionView.layer.borderWidth = 4
        collectionView.layer.cornerRadius = 12
        collectionView.layer.borderColor = UIColor(red: 168/255, green: 60/255, blue: 76/255, alpha: 0.5).cgColor
        
        collectionView.snp.makeConstraints{
            $0.top.equalTo(75)
            $0.left.equalTo(32)
            $0.right.equalTo(-32)
            $0.height.equalTo(190)
            $0.bottom.equalTo(bottomControllView.snp.top).offset(-20)
        }
        
        descriptionView.snp.makeConstraints{
            if screenHeight == 568 {
                $0.top.equalTo(bottomControllView.snp.bottom).offset(24)
            } else {
                $0.top.equalTo(bottomControllView.snp.bottom).offset(32)
            }
            $0.centerX.equalToSuperview()
            $0.height.equalTo(140)
        }
       
        registrationButton.snp.makeConstraints {
            $0.top.equalTo(descriptionView.snp.bottom).offset(screenHeight / 14.2)
            $0.height.equalTo(50)
            $0.left.equalTo(40)
            $0.right.equalTo(-40)
//            if screenHeight == 812 {
//                $0.bottom.equalToSuperview().offset(-100)
//            } else if {
//                $0.bottom.equalToSuperview().offset(-25)
//            }
        }
    }
    
    func setupBottomControls() {
        bottomControllView = UIStackView(arrangedSubviews: [pageControl])
        bottomControllView.backgroundColor = .red
        view.addSubview(bottomControllView)
        bottomControllView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-15)
            $0.width.equalTo(50)
            $0.height.equalTo(10)
        }
    }
    
    func prepareLoginViewController(_ loginViewController: AKFViewController) {
        loginViewController.delegate = self
        loginViewController.setAdvancedUIManager(nil)
        loginViewController.defaultCountryCode = "KZ"
        
        let theme = AKFTheme.default()
        theme.statusBarStyle = .lightContent
        theme.inputTextColor = .white
        theme.textColor = .white
        theme.headerBackgroundColor = UIColor(red: 237/255, green: 95/255, blue: 117/255, alpha: 1)
        theme.backgroundColor = UIColor(red: 237/255, green: 95/255, blue: 117/255, alpha: 1)
        theme.headerTextColor = .white
        theme.iconColor = UIColor(red: 237/255, green: 95/255, blue: 117/255, alpha: 1)
        theme.inputBorderColor = .white
        theme.inputBackgroundColor = UIColor(red: 237/255, green: 95/255, blue: 117/255, alpha: 1)
        theme.buttonBorderColor = UIColor(red: 168/255, green: 60/255, blue: 76/255, alpha: 0.5)
        theme.buttonBackgroundColor = UIColor(red: 254/255, green: 193/255, blue: 87/255, alpha: 1)
        theme.buttonTextColor = UIColor(red: 168/255, green: 60/255, blue: 76/255, alpha: 1)
        theme.titleColor = UIColor(red: 0.247, green: 0.247, blue: 0.247, alpha: 1)
        
        loginViewController.setTheme(theme)
    }
    
    @objc func loginBtnPressed() {
        let inputState = UUID().uuidString
        let viewController = accountKit.viewControllerForPhoneLogin(with: nil, state: inputState) as AKFViewController
        viewController.enableSendToFacebook = true
        self.prepareLoginViewController(viewController)
        self.present(viewController as! UIViewController, animated: true, completion: nil)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageSwipeCell
        cell.firstImageView.image = UIImage(named: swypePage[indexPath.row])   
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func viewController(_ viewController: (UIViewController & AKFViewController)!, didCompleteLoginWith accessToken: AKFAccessToken!, state: String!) {
        print("accessToken:", accessToken.tokenString)
        UserDefaults().setAccessToken(value: accessToken.tokenString)
        SessionsApi.createSession(token: accessToken.tokenString, success: { profile in
            Token.shared.accessToken = accessToken.tokenString
            Application.shared.login(profile: profile)
        }) { errorMessage in
            self.showAlert(errorType: "Ошибка авторизации", image: #imageLiteral(resourceName: "errorIcon"))
        }
    }
}
