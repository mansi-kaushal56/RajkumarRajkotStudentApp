//
//  LoginVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 21/06/23.
//

import UIKit
import ObjectMapper

class LoginVC: UIViewController {
    @IBOutlet weak var usernameTxtFld : UITextField!
    @IBOutlet weak var passTxtFld : UITextField!
    
    var userObj : UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func loginbtn(_ sender : UIButton) {
        loginAPI()
        //print(userObj!)
    }
}

extension LoginVC {
    func loginAPI() {
        if usernameTxtFld.text!.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_USERNAME_EMPTY, controller: self)
            return
        }
        if passTxtFld.text!.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_PASSWORD_EMPTY, controller: self)
            return
        }
        CommonObjects.shared.showProgress()
        let strUrl = "\(Base_Url)\(End_Points.Api_login.getEndpoints).php?enroll_no=\(usernameTxtFld.text ?? "")&dob=\(passTxtFld.text ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_login.getEndpoints, apiRequestURL: strUrl)
        
    }
}

extension LoginVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_login.getEndpoints {
            if let status = response["status"] as? Bool {
                let msg = response["msg"] as! String
                if status == true {
                    if let userModelDictData = Mapper<UserModel>().map(JSONObject: response) {
                        userObj = userModelDictData
                        UserDefaults.setUserDetail(userModelDictData)
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: AppSegue.dashboardSegue.getDescription, sender: nil)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        CommonObjects.shared.showToast(message: msg, controller: self)
                    }
                }
            }
            
        }
    }
    
    func failure() {
        DispatchQueue.main.async {
            CommonObjects.shared.stopProgress()
            CommonObjects.shared.showToast(message: AppMessages.MSG_FAILURE_ERROR, controller: self)
        }
    }
}
