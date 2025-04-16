//
//  PocketMoneyVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 17/07/23.
//

import UIKit
import ObjectMapper

class PocketMoneyVC: UIViewController {
    var pocketledgerObj: PocketMoneyModel?
    @IBOutlet weak var pocketMoneyTblView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Pocket Money")
        pocketMoneyAPI()
    }
}
extension PocketMoneyVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pocketledgerObj?.response?.count ?? 0
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pocketMoneyTVCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.pocketMoneyTVCell.getIdentifier, for: indexPath) as! PocketMoneyTblCell
        let pocketMoneyData = pocketledgerObj?.response?[indexPath.row]
        pocketMoneyTVCell.dateLbl.text = pocketMoneyData?.date
        pocketMoneyTVCell.billNoRecLbl.text = pocketMoneyData?.receipt_no
        pocketMoneyTVCell.particularLbl.text = pocketMoneyData?.trasactionName
        pocketMoneyTVCell.receivedLbl.text = pocketMoneyData?.dr
        pocketMoneyTVCell.expensesLbl.text = pocketMoneyData?.cr
        pocketMoneyTVCell.balanceLbl.text = pocketMoneyData?.bal
        pocketMoneyTVCell.remarksLbl.text = "\(pocketMoneyData?.remarks ?? "")"
        
        return pocketMoneyTVCell
        }
    }

extension PocketMoneyVC {
    func pocketMoneyAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(Base_Url)\(End_Points.Api_Pocketledger.getEndpoints).php?id=\(UserDefaults.getUserDetail()?.studentId ?? "")&EnrollNo=\(UserDefaults.getUserDetail()?.enrollNo ?? "")&BranchId=\(UserDefaults.getUserDetail()?.branch_id ?? "")&sessionid=\(UserDefaults.getUserDetail()?.session_id ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Pocketledger.getEndpoints, apiRequestURL: strUrl)
    }
}
extension PocketMoneyVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_Pocketledger.getEndpoints {
            let status = response["status"] as! Int
            if status == 1 {
                if let anotificationsListDictData = Mapper<PocketMoneyModel>().map(JSONObject: response) {
                    pocketledgerObj = anotificationsListDictData
                    print(anotificationsListDictData)
                    DispatchQueue.main.async {
                        CommonObjects.shared.stopProgress()
                        self.pocketMoneyTblView.reloadData()
                    }
                }
                CommonObjects.shared.stopProgress()
            } else {
                //CommonObjects.shared.showProgress()
//                DispatchQueue.main.async {
//                    CommonObjects.shared.showToast(message: AppMessages.MSG_NO_DATA_FOUND, controller: self)
//                }

            }
        }

    }

    func failure() {
        DispatchQueue.main.async {
            CommonObjects.shared.showProgress()
            CommonObjects.shared.showToast(message: AppMessages.MSG_FAILURE_ERROR, controller: self)
        }
    }
}
