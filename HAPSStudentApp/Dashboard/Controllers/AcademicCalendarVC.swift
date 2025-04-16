//
//  AcademicCalendarVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 30/06/23.
//

import UIKit
import ObjectMapper

class AcademicCalendarVC: UIViewController {
    var academicCalendarObj: AcademicCalendarModel?
    @IBOutlet weak var academicCalTblView: UITableView!
   
    
    var type : ScreenType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if type == .AcademicCalendar {
            academicCalendarAPI()
            backBtn(title: "Academic Calendar")
        } else {
            bookListAPI()
            backBtn(title: "Book List")
        }
    }
}
//Vijay :: 31, Jan 2024 - Here We add the table view and replace the view
extension AcademicCalendarVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let file = academicCalendarObj?.academicCalendarArr?[indexPath.row].file ?? ""
        print(file)
        openWebView(urlSting: file , viewController: self)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return academicCalendarObj?.academicCalendarArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let academicCalendarCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.academicCalendarCell.getIdentifier, for: indexPath) as! AcademicCalTblViewCell
        academicCalendarCell.academicCalendarDetail = academicCalendarObj?.academicCalendarArr?[indexPath.row]
        switch type {
        case .AcademicCalendar:
            academicCalendarCell.academicCalendarImgView.image = .downloadAcademicCalendar
        case .BooksList:
            academicCalendarCell.academicCalendarImgView.image = .downloadbooklistIcon
        default:
            break
        }
        return academicCalendarCell
    }
    //Vijay End
}

extension AcademicCalendarVC {
    func academicCalendarAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(Base_Url)\(End_Points.Api_Academic_Calendar_list.getEndpoints).php?SessionId=\(UserDefaults.getUserDetail()?.session_id ?? "")&BranchId=\(UserDefaults.getUserDetail()?.branch_id ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Academic_Calendar_list.getEndpoints, apiRequestURL: strUrl)
    }
    func bookListAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(Base_Url)\(End_Points.Api_Books_List.getEndpoints).php?SessionId=\(UserDefaults.getUserDetail()?.session_id ?? "")&BranchId=\(UserDefaults.getUserDetail()?.branch_id ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Books_List.getEndpoints, apiRequestURL: strUrl)
    }
}
extension AcademicCalendarVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_Academic_Calendar_list.getEndpoints {
            let status = response["status"] as! String
            if status == "true" {
                if let academicCalendarDictData = Mapper<AcademicCalendarModel>().map(JSONObject: response) {
                    academicCalendarObj = academicCalendarDictData
                    print(academicCalendarDictData)
                    DispatchQueue.main.async {
                        self.academicCalTblView.reloadData()
                    }
                }
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: AppMessages.MSG_NO_DATA_FOUND, controller: self)
                }
                
            }
        }
        if api == End_Points.Api_Books_List.getEndpoints {
            let status = response["status"] as! String
            if status == "true" {
                if let bookListDictData = Mapper<AcademicCalendarModel>().map(JSONObject: response) {
                    academicCalendarObj = bookListDictData
                    print(bookListDictData)
                    DispatchQueue.main.async {
                        self.academicCalTblView.reloadData()
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
            CommonObjects.shared.stopProgress()
            CommonObjects.shared.showToast(message: AppMessages.MSG_FAILURE_ERROR, controller: self)
        }
    }
}
