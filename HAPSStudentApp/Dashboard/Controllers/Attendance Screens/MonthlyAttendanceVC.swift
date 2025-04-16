//
//  MonthlyAttendanceVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 28/06/23.
//

import UIKit
import ObjectMapper

class MonthlyAttendanceVC: UIViewController {
    @IBOutlet weak var monthlyAttendanceTblView : UITableView!
    var monthlyAttendanceObj : MonthlyAttendanceModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        monthlyAttendanceApi()
        backBtn(title: "Monthly Attendance")
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppSegue.monthlyAttendanceDetailsSegue.getDescription {
            if let destinationVC = segue.destination as? MonthlyAttendanceDetailVC {
                destinationVC.months = monthlyAttendanceObj?.monthlyAttendanceArr?[sender as! Int].month
                destinationVC.absents = monthlyAttendanceObj?.monthlyAttendanceArr?[sender as! Int].absent
                destinationVC.leaves = monthlyAttendanceObj?.monthlyAttendanceArr?[sender as! Int].leave
                destinationVC.presents = monthlyAttendanceObj?.monthlyAttendanceArr?[sender as! Int].present
                destinationVC.totalClasses = "Total Classes: \(monthlyAttendanceObj?.monthlyAttendanceArr?[sender as! Int].total ?? "") days"
            }
        }
    }
    
    @objc func nextBtnTapped(sender:UIButton) {
        print(sender.tag)
        performSegue(withIdentifier: AppSegue.monthlyAttendanceDetailsSegue.getDescription, sender: sender.tag)
        
    }
}
extension MonthlyAttendanceVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // performSegue(withIdentifier: "monthlyAttendanceDetailsSegue", sender: nil)
    }
}
extension MonthlyAttendanceVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monthlyAttendanceObj?.monthlyAttendanceArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let monthlyAttendanceCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.monthlyAttendanceCell.getIdentifier, for: indexPath) as! MonthlyAttendanceTblVCell
        monthlyAttendanceCell.monthLbl.text = monthlyAttendanceObj?.monthlyAttendanceArr?[indexPath.row].month
        monthlyAttendanceCell.presentLbl.text = monthlyAttendanceObj?.monthlyAttendanceArr?[indexPath.row].present
        monthlyAttendanceCell.leaveLbl.text = monthlyAttendanceObj?.monthlyAttendanceArr?[indexPath.row].leave
        monthlyAttendanceCell.absentLbl.text = monthlyAttendanceObj?.monthlyAttendanceArr?[indexPath.row].absent
        monthlyAttendanceCell.totalClassesLbl.text = "Total Classes: \(monthlyAttendanceObj?.monthlyAttendanceArr?[indexPath.row].total ?? "") days"
        
        monthlyAttendanceCell.nextBtn.tag = indexPath.row
        monthlyAttendanceCell.nextBtn.addTarget(self, action: #selector(nextBtnTapped(sender: )), for: .touchUpInside)
        return monthlyAttendanceCell
    }
}
extension MonthlyAttendanceVC {
    func monthlyAttendanceApi(){
        CommonObjects.shared.showProgress()
        let strUrl = "\(Base_Url)\(End_Points.Api_Monthly_Attendance.getEndpoints).php?stcode=\(UserDefaults.getUserDetail()?.enrollNo ?? "")&branch_id=\(UserDefaults.getUserDetail()?.branch_id ?? "")&session_id=\(UserDefaults.getUserDetail()?.session_id ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Monthly_Attendance.getEndpoints, apiRequestURL: strUrl)
    }
}
extension MonthlyAttendanceVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_Monthly_Attendance.getEndpoints {
            let status = response["status"] as! Bool
            if status == true {
                if let monthlyAttendanceDictData = Mapper<MonthlyAttendanceModel>().map(JSONObject: response) {
                    monthlyAttendanceObj = monthlyAttendanceDictData
                    print(monthlyAttendanceDictData)
                    DispatchQueue.main.async {
                        self.monthlyAttendanceTblView.reloadData()
                    }
                }
                CommonObjects.shared.stopProgress()
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.stopProgress()
                }
            }
        }
    }
    
    func failure() {
        DispatchQueue.main.async {
            CommonObjects.shared.showToast(message: AppMessages.MSG_FAILURE_ERROR, controller: self)
            CommonObjects.shared.stopProgress()
        }
    }
}
