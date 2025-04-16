//
//  OverallAttendanceVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 28/06/23.
//

import UIKit
import ObjectMapper
import Kingfisher

class OverallAttendanceVC: UIViewController {
    @IBOutlet weak var absentNumLbl : UILabel!
    @IBOutlet weak var presentNumLbl : UILabel!
    @IBOutlet weak var leaveNumLbl : UILabel!
    @IBOutlet weak var totalClassesNumLbl : UILabel!
    @IBOutlet weak var studentNameLbl : UILabel!
    @IBOutlet weak var studentImgView : UIImageView!
    @IBOutlet weak var studentClassLbl : UILabel!
    @IBOutlet weak var absentView : UIView!
    @IBOutlet weak var leaveView : UIView!
    
    var attendanceObj : OverallAttendanceModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Overall Attendance")
        overallAttendanceApi()
        setLblData()
        let absentTapGesture = UITapGestureRecognizer()
        absentView.addGestureRecognizer(absentTapGesture)
        absentTapGesture.addTarget(self, action: #selector(absentTapped))
        
        let leaveTapGesture = UITapGestureRecognizer()
        leaveView.addGestureRecognizer(leaveTapGesture)
        leaveTapGesture.addTarget(self, action: #selector(leaveTapped))
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppSegue.presentSegue.getDescription {
            if let destinationVC = segue.destination as? AttendanceDetailsVC {
                destinationVC.saguevc = "PresentVC"
                
            }
        }
    }
    
    func showdata() {
        absentNumLbl.text = attendanceObj.absent
        presentNumLbl.text = attendanceObj.present
        leaveNumLbl.text = attendanceObj.leave
        totalClassesNumLbl.text = attendanceObj.total
    }
    func setLblData() {
        studentNameLbl.text = UserDefaults.getUserDetail()?.studentName
        studentClassLbl.text = "Class - \(UserDefaults.getUserDetail()?.className ?? ""), \(UserDefaults.getUserDetail()?.sectionName ?? "")"
        let image = (UserDefaults.getUserDetail()?.studentImage ?? "")
        let imageURL = URL(string: image)
        studentImgView.kf.setImage(with: imageURL,placeholder: UIImage(named: "userProfileIcon"))
    }
    @objc func absentTapped() {
        performSegue(withIdentifier: AppSegue.presentSegue.getDescription, sender: nil)
    }
    @objc func leaveTapped() {
        performSegue(withIdentifier: AppSegue.leaveSegue.getDescription, sender: nil)
    }
}
extension OverallAttendanceVC {
    func overallAttendanceApi(){
        let strUrl = "\(Base_Url)\(End_Points.Api_Overall_Attendance.getEndpoints).php?stcode=\(UserDefaults.getUserDetail()?.enrollNo ?? "")&branch_id=\(UserDefaults.getUserDetail()?.branch_id ?? "")&session_id=\(UserDefaults.getUserDetail()?.session_id ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Overall_Attendance.getEndpoints, apiRequestURL: strUrl)
    }
}
extension OverallAttendanceVC  : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_Overall_Attendance.getEndpoints {
            let status = response["status"] as! Bool
            if status == true {
                if let userModelDictData = Mapper<OverallAttendanceModel>().map(JSONObject: response) {
                    attendanceObj = userModelDictData
                    print(userModelDictData)
                    DispatchQueue.main.async {
                        self.showdata()
                    }
                }
            } else {
                DispatchQueue.main.async {
                   
                }
            }
        }
    }
    func failure() {
    }
}
