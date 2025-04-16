//
//  LeaveStatusVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 27/06/23.
//

import UIKit
import ObjectMapper
import DZNEmptyDataSet

class LeaveStatusVC: UIViewController {
    @IBOutlet weak var leaveStatusTblView : UITableView!
    
    var leaveStatusObj : LeaveStatusModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        leaveStatusApi()
        backBtn(title: "Leave Status")
        
        leaveStatusTblView.emptyDataSetSource = self
        leaveStatusTblView.emptyDataSetDelegate = self
        // Do any additional setup after loading the view.
    }
    
}
extension LeaveStatusVC : UITableViewDelegate {
    
}
extension LeaveStatusVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaveStatusObj?.leaveStatusArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let leaveStatusCell = tableView.dequeueReusableCell(withIdentifier:AppTblCells.leaveStatusCell.getIdentifier , for: indexPath) as! LeaveStatusTblViewCell
        if leaveStatusObj?.leaveStatusArr?[indexPath.row].status == "Pending" {
            leaveStatusCell.statusLbl.backgroundColor = .AppYellow
        } else if leaveStatusObj?.leaveStatusArr?[indexPath.row].status == "Deny"  {
            leaveStatusCell.statusLbl.backgroundColor = .AppRed
        } else {
            leaveStatusCell.statusLbl.backgroundColor = .AppGreen
        }
        leaveStatusCell.statusLbl.layer.cornerRadius = 7
        leaveStatusCell.leaveStatusView.layer.borderColor = UIColor(named: "AppBorderColor")?.cgColor
        leaveStatusCell.statusView.layer.borderColor = UIColor(named: "AppBorderColor")?.cgColor
        leaveStatusCell.statusLbl.clipsToBounds = true
        leaveStatusCell.leaveStatusDateFromLbl.text = leaveStatusObj?.leaveStatusArr?[indexPath.row].datefrom
        leaveStatusCell.leaveStatusDateToLbl.text = leaveStatusObj?.leaveStatusArr?[indexPath.row].dateto
        leaveStatusCell.leaveStatusReasonLbl.text = leaveStatusObj?.leaveStatusArr?[indexPath.row].reason
        leaveStatusCell.statusLbl.text = leaveStatusObj?.leaveStatusArr?[indexPath.row].status
        return leaveStatusCell
    }
}
extension LeaveStatusVC : DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        emptySetMessage()
    }
}
extension LeaveStatusVC {
    
    func leaveStatusApi(){
        CommonObjects.shared.showProgress()
        let strUrl = "\(Base_Url)\(End_Points.Api_LeaveStatus.getEndpoints).php?enrollno=\(UserDefaults.getUserDetail()?.enrollNo ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_LeaveStatus.getEndpoints, apiRequestURL: strUrl)
    }
}
extension LeaveStatusVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
       
        if api == End_Points.Api_LeaveStatus.getEndpoints {
            let status = response["status"] as! Int
            if status == 1 {
                if let circularModelDictData = Mapper<LeaveStatusModel>().map(JSONObject: response) {
                    leaveStatusObj = circularModelDictData
                    //print(circularModelDictData)
                    DispatchQueue.main.async {
                        self.leaveStatusTblView.reloadData()
                    }
                }
                CommonObjects.shared.stopProgress()
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.stopProgress()
                    //CommonObjects.shared.showToast(message: msg, controller: self)
                }
                
            }
        }
    }
    func failure() {
        DispatchQueue.main.async {
            CommonObjects.shared.stopProgress()
        }
    }
    
}
