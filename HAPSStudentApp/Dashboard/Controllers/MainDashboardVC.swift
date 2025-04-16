//
//  MainDashboardVC.swift
//  HAPSStudentApp
//
//  Created by Raj Mohan on 25/06/24.
//

import UIKit

class MainDashboardVC: UIViewController {
    var currentTabIndex = 0
    @IBOutlet weak var newsFeedView: UIView!
    
    @IBOutlet weak var dashboardContainerView: UIView!
    @IBOutlet weak var dashboardLabel: UILabel!
    @IBOutlet weak var newsFeedLabel: UILabel!
    @IBOutlet weak var dashbordView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.NotificationAction(_:)), name: .passNextVC, object: nil)
        dashboardPage(type: .NewsFeed)
        tapGestureRecognizers()
        barBtns()

        // Do any additional setup after loading the view.
    }
    @IBAction func menuBtnAction(_ sender: Any) {
        openDrawer()
    }
    
    
    @objc func NotificationAction(_ notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let index = userInfo["userInfo"] as? Int {
                var currentVc = String()
                switch index {
                case 1:
                    currentVc = AppViewControllerID.newsFeedvc.getIdentifier
                case 2:
                    currentVc = AppViewControllerID.dashboardVC.getIdentifier
                default:
                    print("Unkown Selection")
                }
                
                if self.children.count > 0 {
                    let viewControllers:[UIViewController] = self.children
                    for viewContoller in viewControllers{
                        viewContoller.willMove(toParent: nil)
                        viewContoller.view.removeFromSuperview()
                        viewContoller.removeFromParent()
                    }
                }
                
                if !currentVc.isEmpty {
                    var storyBoard = String()
                    storyBoard = AppStoryboards.dashboard.getDescription
                    let vc = UIStoryboard(name: storyBoard, bundle: Bundle.main).instantiateViewController(withIdentifier: currentVc)
                    embed(viewController: vc, inView: dashboardContainerView)
                }
            }
        }
    }
    func dashboardPage(type:ScreenType) {
        switch type {
        case .NewsFeed:
            newsFeedView.backgroundColor = .AppCyan
            dashbordView.backgroundColor = .BgColor
            currentTabIndex = 1
            NotificationCenter.default.post(name:.passNextVC , object: self, userInfo:["userInfo": currentTabIndex])
        case .Dashboard:
            newsFeedView.backgroundColor = .BgColor
            dashbordView.backgroundColor = .AppCyan
            currentTabIndex = 2
            NotificationCenter.default.post(name:.passNextVC , object: self, userInfo:["userInfo": currentTabIndex])
        default:
            print("Unknown type")
        }
        
    }
    func tapGestureRecognizers() {
        newsFeedLabel.addTapGestureRecognizer {
            self.dashboardPage(type: .NewsFeed)
        }
        dashboardLabel.addTapGestureRecognizer {
            self.dashboardPage(type: .Dashboard)
        }
    }
    
    @objc func logoutBtnTapped(){
        let alertVC = UIAlertController(title: "Logout", message: AppMessages.MSG_LOGOUT, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "YES", style: .default,handler: { (action:UIAlertAction!) in
            UserDefaults.removeAppData()
            self.openViewController()
            
        }))
        alertVC.addAction(UIAlertAction(title: "NO", style: .cancel))
        present(alertVC, animated: true)
    }
    @objc private func profileImageTapped() {
        // Handle the tap action
        performSegue(withIdentifier: AppSegue.profileSegue.getDescription, sender: nil)
    }
    
    
    @objc func notificationBtnTapped() {
        performSegue(withIdentifier: AppSegue.notificationsListSegue.getDescription, sender: nil)
    }
    private func barBtns() {
        let logoutBtn = setupLogoutButton()
        let rightNotiBarbtn = setupNotificationButton()
        let profileBarBtn = setupProfileButton()
        
        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixedSpace.width = 20
        
        navigationItem.rightBarButtonItems = [logoutBtn, rightNotiBarbtn, fixedSpace, profileBarBtn]
        
    }
    
    
    private func setupLogoutButton() -> UIBarButtonItem {
        let logoutBtn = UIBarButtonItem(image: UIImage.LogoutIcon, style: .plain, target: self, action: #selector(logoutBtnTapped))
        return logoutBtn
        //navigationItem.rightBarButtonItems = [logoutBtn]
    }
    
    private func setupNotificationButton() -> UIBarButtonItem {
        let notificationBtn = UIButton(type: .custom)
        notificationBtn.setImage(UIImage.BellNotificationAlarm, for: .normal)
        notificationBtn.addTarget(self, action: #selector(notificationBtnTapped), for: .touchUpInside)
        
        let countLbl = UILabel(frame: CGRect(x: -5, y: -5, width: 17, height: 17))
        countLbl.font = UIFont(name: AppFonts.Roboto_Regular, size: 12)
        countLbl.text = "0"
        countLbl.textAlignment = .center
        countLbl.textColor = .white
        countLbl.backgroundColor = .AppRed
        countLbl.layer.cornerRadius = countLbl.frame.width / 2
        countLbl.clipsToBounds = true
        
        notificationBtn.addSubview(countLbl)
        
        let rightNotiBarbtn = UIBarButtonItem(customView: notificationBtn)
        return rightNotiBarbtn
    }
    
    private func setupProfileButton() -> UIBarButtonItem {
        let profileImageView = UIImageView()
        setUpImage(image: UserDefaults.getUserDetail()?.studentImage ?? "", imageView: profileImageView)
        profileImageView.contentMode = .scaleToFill
        profileImageView.backgroundColor = .white
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Making the image view circular
        profileImageView.layer.cornerRadius = 15 // Half of the width and height (30 / 2)
        profileImageView.clipsToBounds = true
        
        // Adding the image view to the view
        view.addSubview(profileImageView)
        
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 30),
            profileImageView.heightAnchor.constraint(equalToConstant: 30),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Adding tap gesture to the image view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(tapGesture)
        
        
        
        let profileBarBtn = UIBarButtonItem(customView: profileImageView)
        return profileBarBtn
    }
    
    private func openViewController() {
        let storyboard = UIStoryboard(name: AppStoryboards.main.getDescription, bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: AppViewControllerID.loginVC.getIdentifier)
        present(vc, animated: true)
    }
}

