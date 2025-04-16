//
//  SwitchUserVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 12/07/23.
//

import UIKit
import ObjectMapper
import Kingfisher

class SwitchUserVC: UIViewController {
    var switchUserObj: SwitchUserModel?
    //var switchUserEnrollNo: UserModel?
    var switchUserEnrollNoObj: UserModel?
    @IBOutlet weak var switchUserTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchUserAPI()
        backBtn(title: "Switch User")
    }
}
extension SwitchUserVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switchUserLoginAPI()
    }
}
extension SwitchUserVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return switchUserObj?.switchUserArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let switchUserCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.switchUserCell.getIdentifier, for: indexPath) as! SwitchUserTblVCell
        let userdata = switchUserObj?.switchUserArr?[indexPath.row]
        switchUserCell.admnNoLbl.text = "Admn No: \(userdata?.enrollNo ?? "")"
        switchUserCell.studentNameLbl.text = userdata?.studentName
        switchUserCell.relationLbl.text = userdata?.relation
        switchUserCell.classNameLbl.text = "Class: \(userdata?.className ?? "")"
        switchUserCell.rollnoLbl.text = "Roll No. : \(userdata?.rollNo ?? "")"
        let img = (userdata?.studentImage ?? "")
        let imgUrl = URL(string: img)
        switchUserCell.stImgView.kf.setImage(with: imgUrl)
        
        return switchUserCell
    }
}
extension SwitchUserVC {
    func  switchUserAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(Base_Url)\(End_Points.Api_Switch_User.getEndpoints).php?StudentDetailID=\(UserDefaults.getUserDetail()?.studentDetailId ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Switch_User.getEndpoints, apiRequestURL: strUrl)
    }
    func  switchUserLoginAPI() {
        let strUrl = "\(Base_Url)\(End_Points.Api_Switch_User_Login.getEndpoints).php?enroll_no=\(switchUserObj?.switchUserArr?[0].enrollNo ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Switch_User_Login.getEndpoints, apiRequestURL: strUrl)
    }
}
extension SwitchUserVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_Switch_User.getEndpoints {
            let status = response["status"] as! Bool
            if status == true {
                if let switchUserDictData = Mapper<SwitchUserModel>().map(JSONObject: response) {
                    switchUserObj = switchUserDictData
                    print(switchUserDictData)
                    DispatchQueue.main.async {
                        self.switchUserTblView.reloadData()
                    }
                }
                CommonObjects.shared.stopProgress()
            } else {
                
                DispatchQueue.main.async {
                    CommonObjects.shared.stopProgress()
                    CommonObjects.shared.showToast(message: AppMessages.MSG_NO_DATA_FOUND, controller: self)
                }
                
            }
        }
        if api == End_Points.Api_Switch_User_Login.getEndpoints {
            let status = response["status"] as! Bool
            if status == true {
                if let switchUserDictData = Mapper<UserModel>().map(JSONObject: response) {
                    switchUserEnrollNoObj = switchUserDictData
                    print(switchUserDictData)
                    UserDefaults.removeAppData()
                    UserDefaults.setUserDetail(switchUserDictData)
                    DispatchQueue.main.async {
                        let story = UIStoryboard(name: AppStoryboards.dashboard.getDescription, bundle:nil)
                        //let vc = story.instantiateViewController(withIdentifier: "splashVC")
                        let vc = story.instantiateViewController(withIdentifier: AppViewControllerID.navigationVC.getIdentifier )
                        UIApplication.shared.windows.first?.rootViewController = vc
                        UIApplication.shared.windows.first?.makeKeyAndVisible()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: AppMessages.MSG_NO_DATA_FOUND, controller: self)
                }
            }
        }
    }
    func failure() {
        DispatchQueue.main.async {
            CommonObjects.shared.showToast(message: AppMessages.MSG_FAILURE_ERROR, controller: self)
        }
    }
}

