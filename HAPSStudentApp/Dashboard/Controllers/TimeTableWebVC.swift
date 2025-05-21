//
//  TimeTableWebVC.swift
//  HAPSStudentApp
//
//  Created by Raj Mohan on 19/05/25.
//

import UIKit

class TimeTableWebVC: UIViewController {

    @IBOutlet weak var timeTableView: UIView!
    var wedsiteurl : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Time Table")
        let timeTableTapGesture = UITapGestureRecognizer()
        timeTableView.addGestureRecognizer(timeTableTapGesture)
        timeTableTapGesture.addTarget(self, action: #selector(downloadTimeTblTapped))
        // Do any additional setup after loading the view.
    }
    @objc func downloadTimeTblTapped() {
        timetblApi()
    }
    
}
extension TimeTableWebVC {
    func timetblApi() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(Base_Url)\(End_Points.Api_Time_Table.getEndpoints).php?section=\(UserDefaults.getUserDetail()?.section_id ?? "")&BranchId=\(UserDefaults.getUserDetail()?.branch_id ?? "")&session=\(UserDefaults.getUserDetail()?.session_id ?? "")&class=\(UserDefaults.getUserDetail()?.class_id ?? "")"
        print("Time table api is \(strUrl)")
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Time_Table.getEndpoints, apiRequestURL: strUrl)
    }
}
extension TimeTableWebVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_Time_Table.getEndpoints {
            let responseStatus = response["status"] as! Bool
            let message = response["msg"] as! String
            let pdfLink = response["pdfLink"] as! String
            if responseStatus == true {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: message)
                    self.wedsiteurl = pdfLink
                    self.openWebView(urlSting: self.wedsiteurl ?? "", viewController: self)
                    
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

