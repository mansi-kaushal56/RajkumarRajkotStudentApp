//
//  AttendanceDetailsVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 29/06/23.
//

import UIKit
import ObjectMapper

class AttendanceDetailsVC: UIViewController {
    @IBOutlet weak var attendanceDetailTblView : UITableView!
    @IBOutlet weak var studentNameLbl : UILabel!
    @IBOutlet weak var studentClassLbl : UILabel!
    @IBOutlet weak var studentImgView : UIImageView!
    
    var saguevc = ""
    var attendanceTypeObj : DetailAttendanceModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLblData()
        if saguevc == "PresentVC" {
            backBtn(title: "Absent Details")
            detailAttendanceAPI(atnType: "A")
        } else {
            backBtn(title: "Leave Details")
            detailAttendanceAPI(atnType: "L")
        }
    }
    func setLblData() {
        studentNameLbl.text = UserDefaults.getUserDetail()?.studentName
        studentClassLbl.text = "Class - \(UserDefaults.getUserDetail()?.className ?? ""), \(UserDefaults.getUserDetail()?.sectionName ?? "")"
        let image = (UserDefaults.getUserDetail()?.studentImage ?? "")
        let imageURL = URL(string: image)
        studentImgView.kf.setImage(with: imageURL,placeholder: UIImage(named: "userProfileIcon"))
    }
}
extension AttendanceDetailsVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: AppSegue., sender: <#T##Any?#>)
    }
    
}
extension AttendanceDetailsVC : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            if saguevc == "PresentVC" {
                return attendanceTypeObj?.detailAtendanceArr?.count ?? 0
            } else {
                return attendanceTypeObj?.detailAtendanceArr?.count ?? 0
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let headerCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.headerCell.getIdentifier, for: indexPath)
            return headerCell
        } else {
            let absentDetailsCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.absentDetailsCell.getIdentifier, for: indexPath) as! DetailAttendanceTblVCell
            absentDetailsCell.dateLbl.text = attendanceTypeObj?.detailAtendanceArr?[indexPath.row].date
            absentDetailsCell.dayLbl.text = attendanceTypeObj?.detailAtendanceArr?[indexPath.row].day
            absentDetailsCell.attendLbl.text = attendanceTypeObj?.detailAtendanceArr?[indexPath.row].attend
            return absentDetailsCell
        }
    }
}
extension AttendanceDetailsVC  {
    func detailAttendanceAPI(atnType:String) { // AtnType from atntype parameter
        let strUrl = "\(Base_Url)\(End_Points.Api_Detail_Attendance.getEndpoints).php?stcode=\(UserDefaults.getUserDetail()?.enrollNo ?? "")&branch_id=\(UserDefaults.getUserDetail()?.branch_id ?? "")&session_id=\(UserDefaults.getUserDetail()?.session_id ?? "")&atntype=\(atnType)"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Detail_Attendance.getEndpoints, apiRequestURL: strUrl)
    }
}
extension AttendanceDetailsVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_Detail_Attendance.getEndpoints {
            let status = response["status"] as! Bool
            if status == true {
                if let userModelDictData = Mapper<DetailAttendanceModel>().map(JSONObject: response) {
                    attendanceTypeObj = userModelDictData
                    print(userModelDictData)
                    DispatchQueue.main.async {
                        self.attendanceDetailTblView.reloadData()
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
