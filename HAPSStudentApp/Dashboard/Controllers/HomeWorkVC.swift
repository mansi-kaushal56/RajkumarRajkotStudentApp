//
//  HomeWorkVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 30/06/23.
//

import UIKit
import FSCalendar
import ObjectMapper
import DZNEmptyDataSet

class HomeWorkVC: UIViewController {
    
    @IBOutlet weak var weekView: FSCalendar!
    @IBOutlet weak var homeWorkTblView: UITableView!
    @IBOutlet weak var calanderViewHeight: NSLayoutConstraint!
    @IBOutlet weak var homeWorkAssignedDate: UILabel!
    
    var selectedDate: String?
    var homeWorkListObj : HomeWorkListModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //homeWorkAPI()
        dateFormatter()
        homeWorkAPI()
        backBtn(title: "Home Work")
        homeWorkTblView.emptyDataSetSource = self
        homeWorkTblView.emptyDataSetDelegate = self
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppSegue.homeWorkDetailSegue.getDescription {
            if let destinationVC = segue.destination as? HomeWorkDetailVC {
                destinationVC.homeworkId = homeWorkListObj?.response?[sender as! Int].id
            }
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        weekView.scope = .week
        weekView.appearance.calendar.weekdayHeight = 20
        weekView.headerHeight = 18
        //weekView.contentView
        weekView.rowHeight = 30
        //weekView.
        weekView.appearance.todayColor = UIColor.AppCyanBlue
        
        //calanderViewHeight = weekView.heightAnchor.constraint(equalToConstant: 280)
        
        //calanderViewHeight?.isActive = true
    }
    func dateFormatter() {
        var date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        selectedDate = dateFormatter.string(from: date)
        homeWorkAssignedDate.text = selectedDate
    }
}
extension HomeWorkVC : FSCalendarDelegate,FSCalendarDataSource, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderRadiusFor date: Date) -> CGFloat {
        // Set the corner radius to 0 for all cells
        return 0
    }
    private func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, subtitleFor date: Date) -> String? {
        // Get the week day name for the date
        let weekdayFormatter = DateFormatter()
        weekdayFormatter.dateFormat = "EEEE"
        let weekdayName = weekdayFormatter.string(from: date)
        return weekdayName
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        selectedDate = dateFormatter.string(from: date)
        homeWorkAssignedDate.text = selectedDate
        homeWorkAPI()
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calanderViewHeight.constant = bounds.height
        weekView.layoutIfNeeded()
    }
    
}
extension HomeWorkVC : DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        emptySetMessage()
    }
}
extension HomeWorkVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: AppSegue.homeWorkDetailSegue.getDescription, sender: indexPath.row)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeWorkListObj?.response?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let homeWorkCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.homeWorkCell.getIdentifier, for: indexPath) as! HomeWorkListTblVCell
        
        homeWorkCell.dueDateLbl.layer.cornerRadius = 7
        homeWorkCell.dueDateLbl.clipsToBounds = true
        homeWorkCell.assignedByLbl.text = homeWorkListObj?.response?[indexPath.row].teacher
        homeWorkCell.assignedDateLbl.text = homeWorkListObj?.response?[indexPath.row].due_date
        homeWorkCell.dueDateLbl.text = "Due Date: \(homeWorkListObj?.response?[indexPath.row].due_date ?? "")"
        homeWorkCell.subjectLbl.text = homeWorkListObj?.response?[indexPath.row].subject
        
        return homeWorkCell
    }
}

extension HomeWorkVC {
    func homeWorkAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(Base_Url)\(End_Points.Api_Homework_List.getEndpoints).php?BranchId=\(UserDefaults.getUserDetail()?.branch_id ?? "")&ClassId=\(UserDefaults.getUserDetail()?.class_id ?? "")&Session=\(UserDefaults.getUserDetail()?.session_id ?? "")&SectionId=\(UserDefaults.getUserDetail()?.section_id ?? "")&Date=\(selectedDate ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Homework_List.getEndpoints, apiRequestURL: strUrl)
    }
}
extension HomeWorkVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_Homework_List.getEndpoints {
            let status = response["status"] as! Int
            if status == 1 {
                if let homeWorkListDictData = Mapper<HomeWorkListModel>().map(JSONObject: response) {
                    homeWorkListObj = homeWorkListDictData
                    print(homeWorkListDictData)
                    DispatchQueue.main.async {
                        self.homeWorkTblView.reloadData()
                    }
                }
                CommonObjects.shared.stopProgress()
            } else {
                
                DispatchQueue.main.async {
                    CommonObjects.shared.stopProgress()
                    self.homeWorkListObj = nil
                    self.homeWorkTblView.reloadData()
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

