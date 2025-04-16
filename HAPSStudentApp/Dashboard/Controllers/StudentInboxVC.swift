//
//  StudentInboxVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 03/07/23.
//

import UIKit
import ObjectMapper
import Kingfisher
import DZNEmptyDataSet

class StudentInboxVC: UIViewController {

    @IBOutlet weak var studentInboxTblView : UITableView!
    var studentInboxObj : StudentInboxModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        studentInboxAPI()
        backBtn(title: "Inbox")
        studentInboxTblView.emptyDataSetSource = self
        studentInboxTblView.emptyDataSetDelegate = self
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppSegue.studentinboxDetailSegue.getDescription {
            if let destinationVC = segue.destination as? StudentInboxDetailVC {
                destinationVC.msgid = studentInboxObj?.studentInboxArr?[sender as! Int].id
        }
        }
    }
}
extension StudentInboxVC : DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        emptySetMessage()
    }
}
extension StudentInboxVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: AppSegue.studentinboxDetailSegue.getDescription, sender: indexPath.row)
    }
}
extension StudentInboxVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentInboxObj?.studentInboxArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let studentIndexCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.studentIndexCell.getIdentifier, for: indexPath) as! StudentInboxTblVCell
        studentIndexCell.dateLbl.text = studentInboxObj?.studentInboxArr?[indexPath.row].date
        studentIndexCell.despLbl.text = studentInboxObj?.studentInboxArr?[indexPath.row].desp
        studentIndexCell.schoolLbl.text = studentInboxObj?.studentInboxArr?[indexPath.row].school
        let img = (studentInboxObj?.studentInboxArr?[indexPath.row].img ?? "")
        let imgurl = URL(string: img)
        studentIndexCell.msgImg.kf.setImage(with: imgurl,placeholder: UIImage.userIcon)
        return studentIndexCell
    }
}
extension StudentInboxVC {
    func studentInboxAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(Base_Url)\(End_Points.Api_Student_Inbox.getEndpoints).php?BranchId=\(UserDefaults.getUserDetail()?.branch_id ?? "")&Session=\(UserDefaults.getUserDetail()?.session_id ?? "")&enroll_no=\(UserDefaults.getUserDetail()?.enrollNo ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Student_Inbox.getEndpoints, apiRequestURL: strUrl)
    }
}
extension StudentInboxVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_Student_Inbox.getEndpoints {
            let status = response["status"] as! Int
            if status == 1 {
                if let studentInboxDictData = Mapper<StudentInboxModel>().map(JSONObject: response) {
                    studentInboxObj = studentInboxDictData
                    print(studentInboxDictData)
                    DispatchQueue.main.async {
                        self.studentInboxTblView.reloadData()
                    }
                }
                CommonObjects.shared.stopProgress()
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.stopProgress()
//                    CommonObjects.shared.showToast(message: AppMessages.MSG_NO_DATA_FOUND, controller: self)
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
