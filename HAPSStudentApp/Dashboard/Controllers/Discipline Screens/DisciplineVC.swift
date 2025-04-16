//
//  DisciplineVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 04/07/23.
//

import UIKit
import ObjectMapper

class DisciplineVC: UIViewController {
    var disciplineCountObj : DisciplineCountModel?
    @IBOutlet weak var smilecountLbl : UILabel!
    @IBOutlet weak var frownycountLbl: UILabel!
    @IBOutlet weak var totalLbl : UILabel!
    @IBOutlet weak var totalLblView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disciplineCountApi()
        backBtn(title: "Discipline")
        let smilecountTap = UITapGestureRecognizer()
        smilecountLbl.addGestureRecognizer(smilecountTap)
        smilecountTap.addTarget(self, action: #selector(smilecountTapped))
        
        let frownycountTap = UITapGestureRecognizer()
        frownycountLbl.addGestureRecognizer(frownycountTap)
        frownycountTap.addTarget(self, action: #selector(frowneyCountTapped))
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppSegue.smileySegue.getDescription {
            if let destinationvc = segue.destination as? DisciplineDetailVC {
                destinationvc.type = "Smiley"
            }
        } else {
            if let destinationvc = segue.destination as? DisciplineDetailVC {
                destinationvc.type = "Frowney"
            }
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        totalLblView.layer.borderColor = UIColor.AppGreen.cgColor
    }
    func showData() {
        smilecountLbl.text  = "\(disciplineCountObj?.disciplineCountarr?[0].smilecount ?? 0)"
        frownycountLbl.text  = "\(disciplineCountObj?.disciplineCountarr?[0].frownycount ?? 0)"
        totalLbl.text = "\(disciplineCountObj?.disciplineCountarr?[0].total ?? 0)"
    }
    @objc func smilecountTapped(_ sender : UITapGestureRecognizer) {
        performSegue(withIdentifier: AppSegue.smileySegue.getDescription, sender: nil)
    }
    @objc func frowneyCountTapped(_ sender : UITapGestureRecognizer) {
        performSegue(withIdentifier: AppSegue.frowneySegue.getDescription, sender: nil)
    }
}
extension DisciplineVC {
    func disciplineCountApi(){
        let strUrl = "\(Base_Url)\(End_Points.Api_Count_Discipline.getEndpoints).php?EnrollNo=\(UserDefaults.getUserDetail()?.enrollNo ?? "")&Session=\(UserDefaults.getUserDetail()?.session_id  ?? "")&BranchId=\(UserDefaults.getUserDetail()?.branch_id ?? "")"
//        let strUrl = "\(Base_Url)\(End_Points.Api_Count_Discipline.getEndpoints).php?EnrollNo=\("9887")&Session=\("26")&BranchId=\("2")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Count_Discipline.getEndpoints, apiRequestURL: strUrl)
        //    https://himacademy.in/student-app/Discipline.php?EnrollNo=9887&Type=Frowny&Session=26&BranchId=2
    }
}
extension DisciplineVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_Count_Discipline.getEndpoints {
            let status = response["status"] as! Int
            if status == 1 {
                if let diciplineCountDictData = Mapper<DisciplineCountModel>().map(JSONObject: response) {
                    disciplineCountObj = diciplineCountDictData
                    //print(circularModelDictData)
                    DispatchQueue.main.async {
                        self.showData()
                    }
                }
            } else {
//                DispatchQueue.main.async {
//                    CommonObjects.shared.showToast(message: AppMessages.MSG_NO_DATA_FOUND, controller: self)
//                }
//
            }
        }
    }
    
    func failure() {
        DispatchQueue.main.async {
            CommonObjects.shared.showToast(message: AppMessages.MSG_FAILURE_ERROR, controller: self)
        }
    }
}

