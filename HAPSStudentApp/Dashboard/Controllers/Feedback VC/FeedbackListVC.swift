//
//  FeedbackListVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 06/07/23.
//

import UIKit
import ObjectMapper

class FeedbackListVC: UIViewController {
    
    @IBOutlet weak var feedbackListTblView: UITableView!
    
    var feedbackListObj : FeedbackListModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedbackListAPI()
        backBtn(title: "Feedback/Suggestion Report")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == AppSegue.conversationSegue.getDescription {
            if let conversationVC = segue.destination as? ConversationVC {
                let feedbackData = feedbackListObj?.feedbackListArr?[sender as! Int]
                conversationVC.feedbackid = feedbackData?.id
                conversationVC.emailID = feedbackData?.email
                conversationVC.phoneNo = feedbackData?.phone
                conversationVC.sendBy = feedbackData?.gurdianname
            }
        }
    }
}

extension FeedbackListVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: AppSegue.conversationSegue.getDescription, sender: indexPath.row)
    }
    
}
extension FeedbackListVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedbackListObj?.feedbackListArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let feedbackListCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.feedbackListCell.getIdentifier, for: indexPath) as! FeedbackListTblVCell
        feedbackListCell.datelbl.text = feedbackListObj?.feedbackListArr?[indexPath.row].date
        feedbackListCell.feedbackLbl.text = feedbackListObj?.feedbackListArr?[indexPath.row].feedback
        feedbackListCell.feedbackFromLbl.text = "\(feedbackListObj?.feedbackListArr?[indexPath.row].gurdianname ?? "")(\( feedbackListObj?.feedbackListArr?[indexPath.row].relation ?? ""))"
        return feedbackListCell
    }
}

extension FeedbackListVC {
    func feedbackListAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(Base_Url)\(End_Points.Api_Feedback_List.getEndpoints).php?branch_id=\(UserDefaults.getUserDetail()?.branch_id ?? "")&session_id=\(UserDefaults.getUserDetail()?.session_id ?? "")&enrolno=\(UserDefaults.getUserDetail()?.enrollNo ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Feedback_List.getEndpoints, apiRequestURL: strUrl)
    }
}

extension FeedbackListVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_Feedback_List.getEndpoints {
            let status = response["status"] as! Bool
            if status == true {
                if let feedbackDictData = Mapper<FeedbackListModel>().map(JSONObject: response) {
                    feedbackListObj = feedbackDictData
                    print(feedbackDictData)
                    DispatchQueue.main.async {
                        self.feedbackListTblView.reloadData()
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
