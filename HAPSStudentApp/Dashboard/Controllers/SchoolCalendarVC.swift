//
//  SchoolCalendarVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 07/07/23.
//

import UIKit
import ObjectMapper

class SchoolCalendarVC: UIViewController {
    @IBOutlet weak var schoolCalendarTblView : UITableView!
    var eventsListObj : SchoolCalendarModel?
    var holidaysListObj : SchoolCalendarModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        holidaysListAPI()
        eventsListAPI()
        backBtn(title: "School Calendar")
    }
    
}
extension SchoolCalendarVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let containerView = UIView()
        containerView.backgroundColor = UIColor.clear
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width:  self.schoolCalendarTblView.frame.width, height: 40))
        // headerView.backgroundColor = .AppGreen
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(headerView)
        
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            headerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            headerView.topAnchor.constraint(equalTo: containerView.topAnchor),
            headerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        let titleLbl = UILabel()
        titleLbl.text = "Holidays"
        titleLbl.font = UIFont(name: AppFonts.Roboto_Medium, size: 16)
        titleLbl.textColor = .white
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLbl)
        
        NSLayoutConstraint.activate([
            titleLbl.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            titleLbl.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        if section == 0 {
            titleLbl.text = "Holidays"
            headerView.backgroundColor = .HeaderBGColor
        } else {
            titleLbl.text = "Events"
            headerView.backgroundColor = .AppCyan
        }
        
        return containerView
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return holidaysListObj?.schoolCalendarArr?.count ?? 0
        } else {
            return eventsListObj?.schoolCalendarArr?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let holidaysCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.schoolCalendarCell.getIdentifier, for: indexPath) as! SchoolCalendarTblVCell
            holidaysCell.holidayEndDateLbl.text = holidaysListObj?.schoolCalendarArr?[indexPath.row].end
            holidaysCell.holidayNameLbl.text = holidaysListObj?.schoolCalendarArr?[indexPath.row].holidayName
            
            return holidaysCell
        } else {
            let eventsCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.eventsCell.getIdentifier, for: indexPath) as! EventsTblVCell
            eventsCell.holidayEndDateLbl.text = eventsListObj?.schoolCalendarArr?[indexPath.row].end
            eventsCell.holidayNameLbl.text = eventsListObj?.schoolCalendarArr?[indexPath.row].holidayName
            return eventsCell
        }
    }
}
extension SchoolCalendarVC {
    func holidaysListAPI() {
        let strUrl = "\(Base_Url)\(End_Points.Api_calendar.getEndpoints).php?BranchId=\(UserDefaults.getUserDetail()?.branch_id ?? "")&Session=\(UserDefaults.getUserDetail()?.session_id ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_calendar.getEndpoints, apiRequestURL: strUrl)
    }
    func eventsListAPI() {
        let strUrl = "\(Base_Url)\(End_Points.Api_Events.getEndpoints).php?BranchId=\(UserDefaults.getUserDetail()?.branch_id ?? "")&Session=\(UserDefaults.getUserDetail()?.session_id ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Events.getEndpoints, apiRequestURL: strUrl)
    }
}
extension SchoolCalendarVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_calendar.getEndpoints {
            //let status = response["status"] as! Bool
            //if status == true {
            let apiResponse = "\(response)"
            if apiResponse.isEmpty {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: AppMessages.MSG_NO_DATA_FOUND, controller: self)
                }
            } else {
                if let hoilyDaysDictData = Mapper<SchoolCalendarModel>().map(JSONObject: response) {
                    holidaysListObj = hoilyDaysDictData
                    print(hoilyDaysDictData)
                    DispatchQueue.main.async {
                        self.schoolCalendarTblView.reloadData()
                    }
                }
                
            }
        }
        if api == End_Points.Api_Events.getEndpoints {
            let status = response["status"] as! Bool
            if status == true {
                if let eventsDictData = Mapper<SchoolCalendarModel>().map(JSONObject: response) {
                    eventsListObj = eventsDictData
                    print(eventsDictData)
                    DispatchQueue.main.async {
                        self.schoolCalendarTblView.reloadData()
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
