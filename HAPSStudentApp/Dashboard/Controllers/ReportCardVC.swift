//
//  ReportCardVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 25/07/23.
//

import UIKit
import ObjectMapper

class ReportCardVC: UIViewController {
    @IBOutlet weak var downloadImgView: UIImageView!
    var reportCardObj: ReportCardModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Report Card")
        let downloadTap = UITapGestureRecognizer()
        downloadImgView.addGestureRecognizer(downloadTap)
        downloadTap.addTarget(self, action: #selector(downloadImgViewTapped))
        
    }
    @objc func downloadImgViewTapped() {
        reportCardApi()
    }
}

extension ReportCardVC {
    func reportCardApi() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(Report_Card_Url)\(End_Points.Api_Reportcard_App.getEndpoints).php?StudentDetailId=\(UserDefaults.getUserDetail()?.studentDetailId ?? "")&enrollno=\(UserDefaults.getUserDetail()?.enrollNo ?? "")&branchid=\(UserDefaults.getUserDetail()?.branch_id ?? "")&sessionid=\(UserDefaults.getUserDetail()?.session_id ?? "")&classid=\(UserDefaults.getUserDetail()?.class_id ?? "")&sectionid=\(UserDefaults.getUserDetail()?.section_id ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Academic_Calendar_list.getEndpoints, apiRequestURL: strUrl)
    }
}
extension ReportCardVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_Academic_Calendar_list.getEndpoints {
            let status = response["Status"] as! Int
            let msg = response["message"] as! String
            if status == 1 {
                if let reportCardDictData = Mapper<ReportCardModel>().map(JSONObject: response) {
                    reportCardObj = reportCardDictData
                    print(reportCardDictData)
                    DispatchQueue.main.async {
                        if self.reportCardObj?.url == "" {
                            CommonObjects.shared.showToast(message: msg, controller: self)
                        } else {
                            self.openWebView(urlSting: self.reportCardObj?.url ?? "", viewController: self)
                        }
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
