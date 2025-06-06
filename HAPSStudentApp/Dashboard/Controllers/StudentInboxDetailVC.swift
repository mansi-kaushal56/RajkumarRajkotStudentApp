//
//  StudentInboxDetailVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 04/07/23.
//

import UIKit
import ObjectMapper

class StudentInboxDetailVC: UIViewController {
    @IBOutlet weak var studentInboxDetailTblView : UITableView!
    
    var msgid : String?
    var studentInboxDetailObj : StudentInboxDetailModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Inbox Detail")
        studentInboxDetailAPI()
        
    }
    @objc func viewAttachment(sender:UITapGestureRecognizer) {
        switch studentInboxDetailObj?.studentInboxDetailArr?[sender.view?.tag ?? 0].fileType {
        case ImageType.pdf:
            openWebView(urlSting: studentInboxDetailObj?.studentInboxDetailArr?[sender.view?.tag ?? 0].file ?? "", viewController: self)
        case ImageType.jpeg:
            let storyboard = UIStoryboard(name: AppStoryboards.dashboard.getDescription, bundle: .main)
            if let showImgVc = storyboard.instantiateViewController(withIdentifier: AppViewControllerID.showImgVC.getIdentifier) as? ShowImgVC {
                showImgVc.image = studentInboxDetailObj?.studentInboxDetailArr?[sender.view?.tag ?? 0].file
                present(showImgVc, animated: true)
            }
        default:
            let storyboard = UIStoryboard(name: AppStoryboards.dashboard.getDescription, bundle: .main)
            if let showImgVc = storyboard.instantiateViewController(withIdentifier: AppViewControllerID.showImgVC.getIdentifier) as? ShowImgVC {
                showImgVc.image = studentInboxDetailObj?.studentInboxDetailArr?[sender.view?.tag ?? 0].file
                present(showImgVc, animated: true)
            }
            break
        }
        
    }
}
extension StudentInboxDetailVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentInboxDetailObj?.studentInboxDetailArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let inboxDetailCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.studentInboxDetailCell.getIdentifier, for: indexPath) as! StudentInboxDetailTblVCell
        inboxDetailCell.dateLbl.text = studentInboxDetailObj?.studentInboxDetailArr?[indexPath.row].date
        inboxDetailCell.despLbl.text = studentInboxDetailObj?.studentInboxDetailArr?[indexPath.row].desp
        inboxDetailCell.schoolLbl.text = studentInboxDetailObj?.studentInboxDetailArr?[indexPath.row].school
        inboxDetailCell.attachmentView.tag = indexPath.row
        
        let attachmentTap = UITapGestureRecognizer(target: self, action: #selector(viewAttachment(sender: )))
        inboxDetailCell.attachmentView.addGestureRecognizer(attachmentTap)
        
        
        return inboxDetailCell
    }
    
    
}
extension StudentInboxDetailVC {
    func studentInboxDetailAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(Base_Url)\(End_Points.Api_Inbox_Detail.getEndpoints).php?msgid=\(msgid ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Inbox_Detail.getEndpoints, apiRequestURL: strUrl)
    }
}
extension StudentInboxDetailVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_Inbox_Detail.getEndpoints {
//            let apiResponse = "\(response)"
            let status = response["status"] as! Int
            if status == 1 {
                if let studentInboxDetailDictData = Mapper<StudentInboxDetailModel>().map(JSONObject: response) {
                    studentInboxDetailObj = studentInboxDetailDictData
                    print(studentInboxDetailDictData)
                    DispatchQueue.main.async {
                        self.studentInboxDetailTblView.reloadData()
                    }
                }
                CommonObjects.shared.stopProgress()
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: AppMessages.MSG_NO_DATA_FOUND, controller: self)
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

