//
//  TimeTableVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 12/07/23.
//

import UIKit
import ObjectMapper

class TimeTableVC: UIViewController {
    var periodObj: PeriodModel?
    var timeTableObj: TimeTableModel?
    var daysListObj: DayListModel?
    var dayList: String?
    
    @IBOutlet weak var periodTblView: UITableView!
    @IBOutlet weak var timeTableTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        periodsAPI()
        timeTableApi()
        backBtn(title: "Time Table")
        //dayListAPI()
    }
}
extension TimeTableVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == timeTableTblView {
            if indexPath.row == 0  {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message:"\(self.timeTableObj?.timeTableArr?[indexPath.row].teacher1 ?? "")" , controller: self)
                }
            }
            if indexPath.row == 1  {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message:"\(self.timeTableObj?.timeTableArr?[indexPath.row].teacher2 ?? "")" , controller: self)
                }
            }
            if indexPath.row == 2  {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message:"\(self.timeTableObj?.timeTableArr?[indexPath.row].teacher3 ?? "")" , controller: self)
                }
            }
            if indexPath.row == 3  {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message:"\(self.timeTableObj?.timeTableArr?[indexPath.row].teacher4 ?? "")" , controller: self)
                }
            }
            if indexPath.row == 4  {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message:"\(self.timeTableObj?.timeTableArr?[indexPath.row].teacher5 ?? "")" , controller: self)
                }
            }
            if indexPath.row == 5  {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message:"\(self.timeTableObj?.timeTableArr?[indexPath.row].teacher6 ?? "")" , controller: self)
                }
            }
//            if indexPath.row == 6  {
//                DispatchQueue.main.async {
//                    CommonObjects.shared.showToast(message:"\(self.timeTableObj?.timeTableArr?[indexPath.row].teacher3 ?? "")" , controller: self)
//                }
//            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == periodTblView {
            let containerView = UIView()
            containerView.backgroundColor = UIColor.clear
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: periodTblView.bounds.width, height: 40))
            headerView.backgroundColor = .TimeTableBg
            if #available(iOS 15.0, *) {
                periodTblView.sectionHeaderTopPadding = 0
            } else {
                // Fallback on earlier versions
            }
            let titleLbl = UILabel()
            titleLbl.text = "Period"
            titleLbl.font = UIFont(name: AppFonts.Roboto_Medium, size: 12)
            titleLbl.textColor = .black
            titleLbl.translatesAutoresizingMaskIntoConstraints = false
            headerView.addSubview(titleLbl)
            
            NSLayoutConstraint.activate([
                titleLbl.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
                titleLbl.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
            ])
            containerView.addSubview(headerView)
            return containerView
        } else {
            if #available(iOS 15.0, *) {
                timeTableTblView.sectionHeaderTopPadding = 0
            } else {
                // Fallback on earlier versions
            }
            let labelsStackView = UIStackView()
            labelsStackView.axis = .horizontal
            labelsStackView.distribution = .fillEqually
            labelsStackView.alignment = .fill
            labelsStackView.spacing = 0
            labelsStackView.backgroundColor = UIColor.TimeTableBg
            
            for n in 1...6 { // Header Days list label
                let label = UILabel()
                label.translatesAutoresizingMaskIntoConstraints = false
                label.widthAnchor.constraint(equalToConstant: 75).isActive = true
                label.font = UIFont(name: AppFonts.Roboto_Medium, size: 12)
                label.text = "Day\(n)"
                label.textAlignment = .center
                labelsStackView.addArrangedSubview(label)
            }
            
            view.addSubview(labelsStackView)
            labelsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            labelsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            labelsStackView.topAnchor.constraint(equalTo: view.topAnchor,constant: 0).isActive = true
            return labelsStackView
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == periodTblView {
            return periodObj?.periodArr?.count ?? 0
        } else {
            print(timeTableObj?.timeTableArr?.count)
            return timeTableObj?.timeTableArr?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == periodTblView {
            
            let periodCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.periodsCell.getIdentifier, for: indexPath) as! PeriodsTblVCell
            
            if periodObj?.periodArr?[indexPath.row].isBreakPeriod == "Yes" {
                periodCell.contentView.backgroundColor = .AppGreen
                periodCell.periodsNameLbl.textColor = .white
                periodCell.periodsTimeLbl.textColor = .white
                
            } else {
                periodCell.contentView.backgroundColor = .TblCellBg
                
            }
            let periodData = periodObj?.periodArr?[indexPath.row]
            periodCell.periodsNameLbl.text = periodData?.periodName
            periodCell.periodsTimeLbl.text = periodData?.time
            return periodCell
        } else {
            let timeTableCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.timeTableCell.getIdentifier, for: indexPath) as! TimeTableSubjectsTblVCell
            let timeTableData = timeTableObj?.timeTableArr?[indexPath.row]
            timeTableCell.sub1Lbl.text = timeTableData?.sub1
            timeTableCell.sub2Lbl.text = timeTableData?.sub2
            timeTableCell.sub3Lbl.text = timeTableData?.sub3
            timeTableCell.sub4Lbl.text = timeTableData?.sub4
            timeTableCell.sub5Lbl.text = timeTableData?.sub5
            timeTableCell.sub6Lbl.text = timeTableData?.sub6
            
//            timeTableCell.teacher1Lbl.text = timeTableData?.teacher1
//            timeTableCell.teacher2Lbl.text = timeTableData?.teacher1
//            timeTableCell.teacher3Lbl.text = timeTableData?.teacher1
//            timeTableCell.teacher4Lbl.text = timeTableData?.teacher1
//            timeTableCell.teacher5Lbl.text = timeTableData?.teacher1
//            timeTableCell.teacher6Lbl.text = timeTableData?.teacher1
            
            return timeTableCell
            
        }
    }
}

extension TimeTableVC {
    func  periodsAPI() {
        CommonObjects.shared.stopProgress()
        let strUrl = "\(Base_Url)\(End_Points.Api_Periods.getEndpoints).php?section=\(UserDefaults.getUserDetail()?.section_id ?? "")&BranchId=\(UserDefaults.getUserDetail()?.branch_id ?? "")&session=\(UserDefaults.getUserDetail()?.session_id ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Periods.getEndpoints, apiRequestURL: strUrl)
    }
    func  timeTableApi() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(Base_Url)\(End_Points.Api_Time_Table.getEndpoints).php?section=\(UserDefaults.getUserDetail()?.section_id ?? "")&BranchId=\(UserDefaults.getUserDetail()?.branch_id ?? "")&session=\(UserDefaults.getUserDetail()?.session_id ?? "")&class=\(UserDefaults.getUserDetail()?.class_id ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Time_Table.getEndpoints, apiRequestURL: strUrl)
    }
    func dayListAPI() {
        let strUrl = "\(Base_Url)\(End_Points.Api_Days_Master.getEndpoints).php?"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Days_Master.getEndpoints, apiRequestURL: strUrl)
    }
}
extension TimeTableVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_Periods.getEndpoints {
            let status = response["status"] as! Bool
            if status == true {
                if let periodDictData = Mapper<PeriodModel>().map(JSONObject: response) {
                    periodObj = periodDictData
                    print(periodDictData)
                    DispatchQueue.main.async {
                        self.periodTblView.reloadData()
                    }
                }
                CommonObjects.shared.stopProgress()
            } else {
                
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: AppMessages.MSG_NO_DATA_FOUND, controller: self)
                }
                
            }
        }
        if api == End_Points.Api_Time_Table.getEndpoints {
            let apiResponse = "\(response)"
            if apiResponse.isEmpty {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: AppMessages.MSG_NO_DATA_FOUND, controller: self)
                }
                
            } else {
                if let periodDictData = Mapper<TimeTableModel>().map(JSONObject: response) {
                    timeTableObj = periodDictData
                    print(periodDictData)
                    DispatchQueue.main.async {
                        self.timeTableTblView.reloadData()
                    }
                }
                
            }
            CommonObjects.shared.stopProgress()
        }
        /*
         //        if api == End_Points.Api_Time_Table.getEndpoints {
         //            let status = response["status"] as! Int
         //            if status == true {
         //                if let periodDictData = Mapper<TimeTableModel>().map(JSONObject: response) {
         //                    timeTableObj = periodDictData
         //                    print(periodDictData)
         //                    DispatchQueue.main.async {
         //                        self.timeTableTblView.reloadData()
         //                    }
         //                }
         //            } else {
         //
         //                DispatchQueue.main.async {
         //                    CommonObjects.shared.showToast(message: AppMessages.MSG_NO_DATA_FOUND, controller: self)
         //                }
         //
         //            }
         //        }
         */
        if api == End_Points.Api_Days_Master.getEndpoints {
            let status = response["status"] as! Bool
            if status == true {
                //let apiResponse = "\(response)"
                //if apiResponse.isEmpty {
                if let dayListDictData = Mapper<DayListModel>().map(JSONObject: response) {
                    daysListObj = dayListDictData
                    print(dayListDictData)
                    DispatchQueue.main.async {
                        //self.timeTableCView.reloadData()
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

