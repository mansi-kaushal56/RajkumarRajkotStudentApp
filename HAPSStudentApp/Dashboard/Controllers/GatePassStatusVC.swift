//
//  GatePassStatusVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 27/12/23.
//

import UIKit
import DZNEmptyDataSet
import ObjectMapper

class GatePassStatusVC: UIViewController {

    var gatePassStatusObj: GatePassStatusModel?
    
    @IBOutlet weak var gatePassStatusTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Gate Pass Status")
        // Do any additional setup after loading the view.
        gatePassStatusTblView.emptyDataSetSource = self
        gatePassStatusTblView.emptyDataSetDelegate = self
        gatepassStatusApi()
    }
    
}
extension GatePassStatusVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gatePassStatusObj?.response?.rest?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let gatePassStatusCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.gatePassStatusCell.getIdentifier, for: indexPath) as! GatePassStatusTblCell
        gatePassStatusCell.gatePassStatusDetail = gatePassStatusObj?.response?.rest?[indexPath.row]
        return gatePassStatusCell
        
    }
}
extension GatePassStatusVC : DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        emptySetMessage()
    }
}
//Vijay 03, Jan 2024 - Implemented the Api_Gate_Pass_Status api
extension GatePassStatusVC {
    func gatepassStatusApi() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(Base_Url)\(End_Points.Api_Gate_Pass_Status.getEndpoints).php?enrollno=\(UserDefaults.getUserDetail()?.enrollNo ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Gate_Pass_Status.getEndpoints, apiRequestURL: strUrl)
    }
}
extension GatePassStatusVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_Gate_Pass_Status.getEndpoints {
            let responseStatus = response["status"] as! Bool
            if responseStatus == true {
                if let gatePassStatusDictData = Mapper<GatePassStatusModel>().map(JSONObject: response) {
                    gatePassStatusObj = gatePassStatusDictData
                    DispatchQueue.main.async {
                        self.gatePassStatusTblView.reloadData()
                    }
                }
            }
        }
    }
    
    func failure() {
        DispatchQueue.main.async {
            CommonObjects.shared.showToast(message: AppMessages.MSG_FAILURE_ERROR)
        }
    }
}
//End Vijay
