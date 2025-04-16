//
//  NotificationsListVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 13/07/23.
//

import UIKit
import ObjectMapper
import DZNEmptyDataSet

class NotificationsListVC: UIViewController {
    var notificationsListObj: NotificationsListModel?
    @IBOutlet weak var notificationsTblView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationsAPI()
        notificationsTblView.emptyDataSetSource = self
        notificationsTblView.emptyDataSetDelegate = self
        backBtn(title: "Notifications")
    }
}
extension NotificationsListVC: DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        emptySetMessage()
    }
}
extension NotificationsListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: AppSegue.notificationsDetailSegue.getDescription, sender: nil)
    }
}
extension NotificationsListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationsListObj?.notificationsListArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let notificationsCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.notificationsListCell.getIdentifier, for: indexPath) as! NotificationsTblVCell
        let notificationsListData = notificationsListObj?.notificationsListArr?[indexPath.row]
        notificationsCell.dateLbl.text = notificationsListData?.createdate
        notificationsCell.messagesLbl.text = notificationsListData?.messages
        return notificationsCell
    }
}
extension NotificationsListVC {
    func notificationsAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(Base_Url)\(End_Points.Api_Notifications_Stu.getEndpoints).php?enrollno=\(UserDefaults.getUserDetail()?.enrollNo ?? "")&branchid=\(UserDefaults.getUserDetail()?.branch_id ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Notifications_Stu.getEndpoints, apiRequestURL: strUrl)
    }
}
extension NotificationsListVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_Notifications_Stu.getEndpoints {
            let status = response["status"] as! Int
            if status == 1 {
                if let notificationsListDictData = Mapper<NotificationsListModel>().map(JSONObject: response) {
                    notificationsListObj = notificationsListDictData
                    print(notificationsListDictData)
                    DispatchQueue.main.async {
                        self.notificationsTblView.reloadData()
                    }
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
