//
//  MonthlyAttendanceDetailVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 29/06/23.
//

import UIKit
import ObjectMapper

class MonthlyAttendanceDetailVC: UIViewController {
    
    var months : String?
    var presents : String?
    var leaves : String?
    var absents : String?
    var totalClasses : String?
    var monthlyAttendanceDetailsObj: DetailAttendanceModel?
    @IBOutlet weak var detailAtnTblView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dayAttendanceAPI()
        backBtn(title: "Monthly Attendance Detail")
    }
    @objc func nextBtbTapped(sender : UIButton) {
       
    }
}
extension MonthlyAttendanceDetailVC : UITableViewDelegate {
    
}
extension MonthlyAttendanceDetailVC : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if section == 1 {
            return 1
        } else {
            return monthlyAttendanceDetailsObj?.detailAtendanceArr?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let monthlyAttendanceDetailCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.monthlyAttendanceDetailCell.getIdentifier, for: indexPath) as! MonthlyAttendanceDetailTblVCell
            monthlyAttendanceDetailCell.monthLbl.text = months
            monthlyAttendanceDetailCell.absentLbl.text = absents
            monthlyAttendanceDetailCell.presentLbl.text = presents
            monthlyAttendanceDetailCell.totalClassesLbl.text = totalClasses
            monthlyAttendanceDetailCell.leaveLbl.text = leaves
            //monthlyAttendanceDetailCell.
            return monthlyAttendanceDetailCell
        
        }
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.headerCell.getIdentifier, for: indexPath)
            
            return cell
        } else {
            let dayAttendanceCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.dayAttendanceCell.getIdentifier, for: indexPath) as! DayAttendanceTblVCell
            let monthlyAtnDetailData = monthlyAttendanceDetailsObj?.detailAtendanceArr?[indexPath.row]
            dayAttendanceCell.attendLbl.text = monthlyAtnDetailData?.attend
            dayAttendanceCell.dateLbl.text = monthlyAtnDetailData?.date
            dayAttendanceCell.dayLbl.text = monthlyAtnDetailData?.day
            //Date:: 10, Apr 2024 - change colours on L - Green on A - Red L - Yellow
            switch monthlyAtnDetailData?.attend  {
            case "P":
                dayAttendanceCell.attendLbl.textColor = .AppGreen
            case "A":
                dayAttendanceCell.attendLbl.textColor = .AppRed
            case "L":
                dayAttendanceCell.attendLbl.textColor = .AppYellow
            default:
                dayAttendanceCell.attendLbl.textColor = .black
                break
            
            }
            return dayAttendanceCell
        }
    }
}
extension MonthlyAttendanceDetailVC {
    
    func dayAttendanceAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(Base_Url)\(End_Points.Api_Day_Attendance.getEndpoints).php?stcode=\(UserDefaults.getUserDetail()?.enrollNo ?? "")&branch_id=\(UserDefaults.getUserDetail()?.branch_id ?? "")&session_id=\(UserDefaults.getUserDetail()?.session_id ?? "")&mnth=\(months ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Day_Attendance.getEndpoints, apiRequestURL: strUrl)
    }
}

extension MonthlyAttendanceDetailVC :RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_Day_Attendance.getEndpoints {
            let status = response["status"] as? Int
            if status == 1 {
                if let monthlyAttendanceDetailDictData = Mapper<DetailAttendanceModel>().map(JSONObject: response) {
                    monthlyAttendanceDetailsObj = monthlyAttendanceDetailDictData
                    print(monthlyAttendanceDetailDictData)
                    DispatchQueue.main.async {
                        self.detailAtnTblView.reloadData()
                    }
                }
               
            } else {
                DispatchQueue.main.async { [weak self] in
                    CommonObjects.shared.stopProgress()
                    CommonObjects.shared.showToast(message: AppMessages.MSG_NO_DATA_FOUND, controller: self!)
                }
            }
        }
    }
    
    func failure() {
        DispatchQueue.main.async { [weak self] in
            CommonObjects.shared.stopProgress()
            CommonObjects.shared.showToast(message: AppMessages.MSG_NO_DATA_FOUND, controller: self!)
        }
    }
    
    
}
