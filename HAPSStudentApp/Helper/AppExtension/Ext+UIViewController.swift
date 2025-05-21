//
//  Ext+UIViewController.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 29/12/23.
//

import Foundation
import UIKit
import SideMenu
import AVFoundation

extension UIViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func setupLabelsStackView() {
        let labelsStackView = UIStackView()
        labelsStackView.axis = .horizontal
        labelsStackView.distribution = .fill
        labelsStackView.alignment = .fill
        labelsStackView.spacing = 0
        
        for _ in 1...6 {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.widthAnchor.constraint(equalToConstant: 75).isActive = true
            label.text = "Label"
            label.textAlignment = .center
            labelsStackView.addArrangedSubview(label)
        }
        
        view.addSubview(labelsStackView)
        
        // Use constraints or Auto Layout anchors to position the labelsStackView
        // Example constraints to center it horizontally and vertically:
        labelsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        labelsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    func setUpDefaultImage(image urlString: String, imageView: UIImageView) {
        let placeholder = UIImage(named: "defaultimage") // Make sure this is in Assets
        
        if let url = URL(string: urlString), !urlString.isEmpty {
            imageView.kf.setImage(
                with: url,
                placeholder: placeholder,
                options: [
                    .transition(.fade(0.2)),
                    .cacheOriginalImage
                ]
            )
        } else {
            imageView.image = placeholder
        }
    }

    //    func barBtns(){
    //        let notificationBtn = UIBarButtonItem(image: UIImage(named: "logoutIcon"), style: .plain, target: self, action: #selector(logoutBtnTapped))
    //        navigationItem.rightBarButtonItem = notificationBtn
    //
    //        let logoutBtn = UIBarButtonItem(image: UIImage(named: "bellNotificationAlarm"), style: .plain, target: self, action: #selector(button1Tapped))
    //        navigationItem.rightBarButtonItems = [notificationBtn, logoutBtn]
    //    }
    //    @objc func button1Tapped(){
    //        print("hello")
    //    }
    //    @objc func logoutBtnTapped(){
    ////        var alertVC = UIAlertController(title: "", message: "Are you sure, you want to Logout?", preferredStyle: .alert)
    ////        alertVC.addAction(UIAlertAction(title: "YES", style: .default,handler: { (action:UIAlertAction!) in
    ////            UserDefaults.removeAppData()
    ////            alertVC.openViewController()
    ////
    ////        }))
    ////        alertVC.addAction(UIAlertAction(title: "NO", style: .cancel))
    ////        present(alertVC, animated: true)
    //    }
    func defaultBackBarBtnItem() -> UIBarButtonItem {
        let backBtn = UIBarButtonItem()
        backBtn.tintColor = .white
        backBtn.image = UIImage(named: "backArrow")
        backBtn.target = self
        backBtn.width = 24
        
        return backBtn
    }
    func addBackBtnToLeftBarButtonItem() {
        let backBtn = defaultBackBarBtnItem()//UIBarButtonItem()
        backBtn.action = #selector(backBtnTapped(_:))
        navigationItem.leftBarButtonItem = backBtn
    }
    func backBtn(title:String){
        
        let backBtnName = UIButton()
        backBtnName.setTitle(title, for: .normal)
        backBtnName.titleLabel?.font = UIFont(name: AppFonts.Roboto_Medium, size: 16) // To add BackButton title
        
        let backButtonImg = UIButton()
        backButtonImg.setImage(UIImage(named: "backArrow"), for: .normal)
        backButtonImg.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside) // Back Btn Action
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(customView:backButtonImg),UIBarButtonItem(customView: backBtnName)]
    }
    @objc func backBtnTapped(_ sender: UIBarButtonItem) {
        if self.navigationController?.viewControllers.count == 1 {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    func openDrawer() {
        let vc = UIStoryboard(name: AppViewControllerID.drawerVC.getStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: AppViewControllerID.drawerVC.getIdentifier)
        let menu = SideMenuNavigationController(rootViewController: vc)
        menu.leftSide = true
        menu.menuWidth = UIScreen.main.bounds.width - (UIScreen.main.bounds.width * 0.3)
        menu.statusBarEndAlpha = 1
        menu.presentationStyle = .menuSlideIn
        menu.presentingViewControllerUserInteractionEnabled = false
        menu.presentationStyle.presentingEndAlpha = 0.5
        present(menu, animated: true)
    }
    func emptySetMessage() -> NSAttributedString {
        let str = "No Data Available!"
        let attStr = [NSAttributedString.Key.foregroundColor : UIColor.FontColor]
        let attributedStr = NSAttributedString(string: str,attributes: attStr)
        return attributedStr
    }
    func showAlert(title: String ,messsage: String) {
        let alertController = UIAlertController(title: title, message: messsage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default,handler: { [self] (UIAlertAction) in
            self.navigationController?.popViewController(animated: true)
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    func openWebView(urlSting:String,viewController : UIViewController) {
        if let url = URL(string: urlSting.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
        if let url = URL(string: urlSting), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            CommonObjects.shared.showToast(message: "Invalid input URL", controller: viewController)
        }
    }
    //Vijay 29, Dec 2023
    func checkCameraPermission() {
        let authStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch authStatus {
        case .denied:
            print ("Denied status callled")
            self.presentCameraSettings()
            break
        case .restricted:
            print ("User Don't allow")
            break
        case .authorized:
            print ("Success")
            self.callCamera()
            break
        case .notDetermined:
            AVCaptureDevice.requestAccess (for: .video) { (success) in
                if success {
                    print ("Permission Granted" )
                } else {
                    print ("Permission not granted" )
                }
            }
            break
        }
    }
    func presentCameraSettings () { // Present the setting to get the Permission to access the camera
        let alertController = UIAlertController(title: "Error",message: "Camera access is denied",preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel",style: .default))
        alertController.addAction(UIAlertAction(title: "Settings",style: .cancel) { _ in
            if let url = URL (string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:],completionHandler: { _ in })
            }})
        present (alertController, animated: true)
    }
    func callCamera(){
        let ac = UIAlertController(title : "HAPS Teacher App" , message: nil, preferredStyle: .actionSheet)
        let photoLibraryBtn = UIAlertAction(title: "Photo Library", style: .default) { [weak self](_) in
            self?.showImagePicker(selectedSourcs: UIImagePickerController.SourceType.photoLibrary)
        }
        let cameraBtn = UIAlertAction(title: "Camera", style: .default) { [weak self] (_) in
            self?.showImagePicker(selectedSourcs: UIImagePickerController.SourceType.camera)
        }
        let cencelBtn = UIAlertAction(title: "Cancel", style: .cancel)
        ac.addAction(cameraBtn)
        ac.addAction(photoLibraryBtn)
        ac.addAction(cencelBtn)
        self.present(ac, animated: true)
    }
    func showImagePicker(selectedSourcs:UIImagePickerController.SourceType){ // Show the imagepicker
        guard UIImagePickerController.isSourceTypeAvailable(selectedSourcs) else {
            print("hello")
            return
        }
        let imageController = UIImagePickerController()
        imageController.delegate = self
        imageController.allowsEditing = true
        imageController.sourceType = selectedSourcs
        self.present(imageController, animated: true, completion: nil)
    }
    //End Vijay
    
    //Date:: 10, Apr 2024 - set the image from kingfisher
    func setUpImage(image: String, imageView: UIImageView) {
        let imgURL =  URL(string: image)
        imageView.kf.setImage(with: imgURL,placeholder: UIImage.placeholder)
    }
    
    func embed(viewController:UIViewController, inView view:UIView){
        
        //To embed View Controller inside a view
        viewController.willMove(toParent: self)
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
        self.addChild(viewController)
        viewController.didMove(toParent: self)
    }
    func processHTMLString(_ htmlString: String) -> NSAttributedString {
        do {
            guard let data = htmlString.data(using: .utf8) else {
                return NSAttributedString()
            }
            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ]
            
            let attributedString = try NSMutableAttributedString(data: data, options: options, documentAttributes: nil)
            
            // Optionally, you can apply additional styling or modifications here
            
            return attributedString
        } catch {
            print("Error converting HTML string to attributed string: \(error.localizedDescription)")
            return NSAttributedString()
        }
    }
    func buildUrlWithParameters(base: String, endpoint: String, parameters: [String: String]) -> String {
        let urlString = "\(base)\(endpoint).php?"
        return addParametersToUrl(urlString: urlString, parameters: parameters)
    }
    func addParametersToUrl(urlString: String, parameters: [String: String]) -> String {
        var urlWithParams = urlString
        for (key, value) in parameters {
            urlWithParams += "\(key)=\(value)&"
        }
        // Remove the last '&' character
        urlWithParams.removeLast()
        return urlWithParams
    }
    
}
extension Notification.Name {
    static let passNextVC = Notification.Name("passNextVC")
}


