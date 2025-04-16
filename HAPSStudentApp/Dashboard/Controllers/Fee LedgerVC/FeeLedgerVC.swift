//
//  FeeLedgerVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 07/07/23.
//

import UIKit
import ObjectMapper
import DZNEmptyDataSet

class FeeLedgerVC: UIViewController {
    @IBOutlet weak var feeLedgerTblView: UITableView!

    
    var feeLedgerObj : FeeLedgerModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        feeLedgerAPI()
        backBtn(title: "Fee Ledger")
        feeLedgerTblView.emptyDataSetSource = self
        feeLedgerTblView.emptyDataSetDelegate = self
        
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppSegue.feeDetailSegue.getDescription {
            if let destinationVC = segue.destination as? FeeDetailVC {
                destinationVC.receiptId = feeLedgerObj?.feeLedgerArr?[sender as! Int].id
                
            }
        }
    }
    @objc func receiptGestureTapped(sender:UITapGestureRecognizer) {
        performSegue(withIdentifier: AppSegue.feeDetailSegue.getDescription, sender: sender.view?.tag)
    }
}
extension FeeLedgerVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: AppSegue.feeDetailSegue.getDescription, sender: indexPath.row)
    }
}
extension FeeLedgerVC:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeLedgerObj?.feeLedgerArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let feeLedgerCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.feeLedgerCell.getIdentifier, for: indexPath) as! FeeLedgerTblVCell
        
        feeLedgerCell.amountLbl.text = feeLedgerObj?.feeLedgerArr?[indexPath.row].amount
        feeLedgerCell.paydateLbl.text = feeLedgerObj?.feeLedgerArr?[indexPath.row].paydate
        feeLedgerCell.payModeLbl.text = feeLedgerObj?.feeLedgerArr?[indexPath.row].pay_mode
        feeLedgerCell.receiptNoLbl.text = "Receipt No: \(feeLedgerObj?.feeLedgerArr?[indexPath.row].receiptNo ?? "")"
        feeLedgerCell.receiptView.tag = indexPath.row
        feeLedgerCell.receiptView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(receiptGestureTapped(sender: ))))
        return feeLedgerCell
    }
}
extension FeeLedgerVC : DZNEmptyDataSetDelegate, DZNEmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        emptySetMessage()
    }
}
extension FeeLedgerVC {
    func feeLedgerAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(Base_Url)\(End_Points.Api_feeleadger.getEndpoints).php?Enrollno=\(UserDefaults.getUserDetail()?.enrollNo ?? "")&BranchId=\(UserDefaults.getUserDetail()?.branch_id ?? "")&Session=\(UserDefaults.getUserDetail()?.session_id ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_feeleadger.getEndpoints, apiRequestURL: strUrl)
    }
}
extension FeeLedgerVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_feeleadger.getEndpoints {
            let status = response["status"] as! Bool
            if status == true {
                if let feeLedgerDictData = Mapper<FeeLedgerModel>().map(JSONObject: response) {
                    feeLedgerObj = feeLedgerDictData
                    print(feeLedgerDictData)
                    DispatchQueue.main.async {
                        self.feeLedgerTblView.reloadData()
                    }
                }
            }
            //CommonObjects.shared.stopProgress()
        } else {
            DispatchQueue.main.async {
                //CommonObjects.shared.stopProgress()
                CommonObjects.shared.showToast(message: AppMessages.MSG_NO_DATA_FOUND, controller: self)
            }
        }
        
    }
    
    func failure() {
        DispatchQueue.main.async {
            CommonObjects.shared.showToast(message: AppMessages.MSG_FAILURE_ERROR, controller: self)
        }
    }
}
