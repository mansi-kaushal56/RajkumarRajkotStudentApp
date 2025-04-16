//
//  AppointmentEntryVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 03/07/23.
//

import UIKit
import ObjectMapper
import DZNEmptyDataSet
import Kingfisher

class AppointmentEntryVC: UIViewController {
    var studentAppointmentObj : StudentAppointmentModel?

    @IBOutlet weak var appointmentTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        appointmentEntryAPI()
        appointmentTblView.emptyDataSetSource = self
        appointmentTblView.emptyDataSetDelegate = self
        backBtn(title: "Appointment Entry")
    }

}
extension AppointmentEntryVC : UITableViewDelegate {
    
}
extension AppointmentEntryVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentAppointmentObj?.studentAppointmentArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let appointmentEntryCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.appointmentEntryCell.getIdentifier, for: indexPath) as! StudentAppointmentTblVCell
        appointmentEntryCell.admissionNoLbl.text = studentAppointmentObj?.studentAppointmentArr?[indexPath.row].adminno
        appointmentEntryCell.yearLbl.text = studentAppointmentObj?.studentAppointmentArr?[indexPath.row].year
        appointmentEntryCell.lblstudentName.text = studentAppointmentObj?.studentAppointmentArr?[indexPath.row].stname
        appointmentEntryCell.desLbl.text = studentAppointmentObj?.studentAppointmentArr?[indexPath.row].des
        appointmentEntryCell.postLbl.text = studentAppointmentObj?.studentAppointmentArr?[indexPath.row].post
        let img = (studentAppointmentObj?.studentAppointmentArr?[indexPath.row].file ?? "")
        let imgURl = URL(string: img)
        appointmentEntryCell.studentImgView.kf.setImage(with: imgURl)
        if studentAppointmentObj?.studentAppointmentArr?[indexPath.row].file == "" {
            appointmentEntryCell.lblAndImageView.isHidden = true
        } else {
            appointmentEntryCell.lblAndImageView.isHidden = false
        }
        return appointmentEntryCell
    }
    
    
}
extension AppointmentEntryVC : DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "No Data Available!"
        let attStr = [NSAttributedString.Key.foregroundColor : UIColor.FontColor]
        let attributedStr = NSAttributedString(string: str,attributes: attStr)
        return attributedStr
    }
    
}
extension AppointmentEntryVC {
    func appointmentEntryAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(Base_Url)\(End_Points.Api_Student_Appointment.getEndpoints).php?branch_id=\(UserDefaults.getUserDetail()?.branch_id ?? "")&session_id=\(UserDefaults.getUserDetail()?.session_id ?? "")&enroll_no=\(UserDefaults.getUserDetail()?.enrollNo ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Student_Appointment.getEndpoints, apiRequestURL: strUrl)
    }
}
extension AppointmentEntryVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_Student_Appointment.getEndpoints {
            let status = response["status"] as! Bool
            if status == true {
                if let activityDetailDictData = Mapper<StudentAppointmentModel>().map(JSONObject: response) {
                    studentAppointmentObj = activityDetailDictData
                    print(activityDetailDictData)
                    DispatchQueue.main.async {
                        self.appointmentTblView.reloadData()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.stopProgress()
                    CommonObjects.shared.showToast(message: AppMessages.MSG_NO_DATA_FOUND, controller: self)
                }
            }
        }
    }

    func failure() {
        DispatchQueue.main.async {
            CommonObjects.shared.showProgress()
            CommonObjects.shared.showToast(message: AppMessages.MSG_FAILURE_ERROR, controller: self)
        }
    }
}
