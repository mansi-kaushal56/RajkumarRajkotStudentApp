//
//  StudentProfileVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 04/07/23.
//

import UIKit
import Kingfisher
import ObjectMapper

class StudentProfileVC: UIViewController {
    var studentProfileObj : StudentProfileModel?
    
    @IBOutlet weak var branchNameLbl: UILabel!
    @IBOutlet weak var studentImgView: UIImageView!
    @IBOutlet weak var admissionNoLbl: UILabel!
    @IBOutlet weak var rollNoLbl: UILabel!
    @IBOutlet weak var dobLbl: UILabel!
    @IBOutlet weak var fatherNameLbl: UILabel!
    @IBOutlet weak var motherNameLbl: UILabel!
    @IBOutlet weak var contactNoLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var studentNameLbl: UILabel!
    @IBOutlet weak var classNameAndSectionLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Student Profile")
        studentProfileAPI()
        // Do any additional setup after loading the view.
    }
    func showdata() {
        studentNameLbl.text = studentProfileObj?.studentName
        classNameAndSectionLbl.text = "Class - \(studentProfileObj?.className ?? "") \(studentProfileObj?.sectionName ?? "")"
        branchNameLbl.text = studentProfileObj?.branch_name
        admissionNoLbl.text = studentProfileObj?.enrollNo
        rollNoLbl.text = studentProfileObj?.rollNo
        dobLbl.text = studentProfileObj?.dOB
        fatherNameLbl.text = studentProfileObj?.fatherName
        motherNameLbl.text = studentProfileObj?.motherName
        contactNoLbl.text = studentProfileObj?.mobileNo
        addressLbl.text = "\(studentProfileObj?.permanentAddress ?? ""),\(studentProfileObj?.state_name ?? "")"
        let img = (studentProfileObj?.studentImage ?? "")
        let imgUrl = URL(string: img)
        studentImgView.kf.setImage(with: imgUrl)
    }
}
extension StudentProfileVC {
    func studentProfileAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(Base_Url)\(End_Points.Api_Get_Profile.getEndpoints).php?enroll_no=\(UserDefaults.getUserDetail()?.enrollNo ?? "")&session_id=\(UserDefaults.getUserDetail()?.session_id ?? "")&student_id=\(UserDefaults.getUserDetail()?.studentId ?? "")&branch_id=\(UserDefaults.getUserDetail()?.branch_id ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Get_Profile.getEndpoints, apiRequestURL: strUrl)
    }
}

extension StudentProfileVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_Get_Profile.getEndpoints {
            //            let apiResponse = "\(response)"
            let status = response["status"] as! Int
            if status == 1 {
                if let studentProfileDictData = Mapper<StudentProfileModel>().map(JSONObject: response) {
                    studentProfileObj = studentProfileDictData
                    print(studentProfileDictData)
                    DispatchQueue.main.async {
                        self.showdata()
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
    }
    
    func failure() {
        DispatchQueue.main.async {
            CommonObjects.shared.stopProgress()
            CommonObjects.shared.showToast(message: AppMessages.MSG_FAILURE_ERROR, controller: self)
        }
    }
}
