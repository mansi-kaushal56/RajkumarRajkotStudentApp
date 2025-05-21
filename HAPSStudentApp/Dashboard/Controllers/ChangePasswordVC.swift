//
//  ChangePasswordVC.swift
//  HAPSStudentApp
//
//  Created by Raj Mohan on 19/05/25.
//

import UIKit

class ChangePasswordVC: UIViewController {

    @IBOutlet weak var confirmPswdTxtFld: UITextField!
    @IBOutlet weak var newPswdTxtFld: UITextField!
    @IBOutlet weak var oldPswdTxtFld: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Change password")

        // Do any additional setup after loading the view.
    }
    

    @IBAction func changePswdAction(_ sender: UIButton) {
        let alertVC = UIAlertController(title: "Change Password", message: AppMessages.MSG_CHANGE_PSWD, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "YES", style: .default,handler: { (action:UIAlertAction!) in
            
            self.changePswdApi()
            
        }))
        alertVC.addAction(UIAlertAction(title: "NO", style: .cancel))
        present(alertVC, animated: true)
        
    }
    private func openViewController() {
        let storyboard = UIStoryboard(name: AppStoryboards.main.getDescription, bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: AppViewControllerID.loginVC.getIdentifier)
        present(vc, animated: true)
    }
    
}
extension ChangePasswordVC {
    func changePswdApi() {
        //CommonObjects.shared.showProgress()
        let oldPassword = oldPswdTxtFld.text ?? ""
        if oldPassword.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_EMPTY_Field)
            return
        }
        let newPassword = newPswdTxtFld.text ?? ""
        if newPassword.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_EMPTY_Field)
            return
        }
        let confirmPswd = confirmPswdTxtFld.text ?? ""
        if confirmPswd.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_EMPTY_Field)
            return
        }
       
        let strUrl = "\(Base_Url)\(End_Points.Api_Change_Password.getEndpoints).php?enroll_no=\(UserDefaults.getUserDetail()?.enrollNo ?? "")&old_password=\(oldPassword)&new_password=\(newPassword)&confirm_password=\(confirmPswd)"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Change_Password.getEndpoints, apiRequestURL: strUrl)
    }
}
extension ChangePasswordVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_Change_Password.getEndpoints {
            let responseStatus = response["status"] as! Bool
            let message = response["msg"] as! String
            if responseStatus == true {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: message)
                    UserDefaults.removeAppData()
                    self.openViewController()
                }
            }
        }
    }
    
    func failure() {
        DispatchQueue.main.async {
            CommonObjects.shared.showToast(message: AppMessages.MSG_FAILURE_ERROR)
        }
    }
}
