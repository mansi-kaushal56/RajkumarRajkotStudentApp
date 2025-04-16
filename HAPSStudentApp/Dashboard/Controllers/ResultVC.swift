//
//  ResultVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 30/06/23.
//

import UIKit
import ObjectMapper

class ResultVC: UIViewController {
    var resultObj : ResultModel?
    @IBOutlet weak var resultTblView: UITableView!
    var headerCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Result")
        resultApi()
    }
    //EnrollNo:112089
    //SessionId:26
}
extension ResultVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.clear
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: resultTblView.bounds.width, height: 50))
        //headerView.backgroundColor = .AppPurple
        let titleLbl = UILabel()
        titleLbl.text = resultObj?.result?[section].dated
        titleLbl.font = UIFont(name: AppFonts.Roboto_Medium, size: 16)
        titleLbl.textColor = .AppCyan
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(titleLbl)
        
        NSLayoutConstraint.activate([
            titleLbl.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            //titleLbl.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        containerView.addSubview(headerView)
        return containerView
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return resultObj?.result?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (resultObj?.result?[section].res?.count ?? 0)+2
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var sectionNumber = indexPath.section
        let rowNumber = indexPath.row
        let count = resultObj?.result?[sectionNumber].res?.count ?? 0
        let sectionData = resultObj?.result?[sectionNumber]
        
        if rowNumber == 0 {
            let resultHeaderCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.resultHeaderCell.getIdentifier, for: indexPath)
            return resultHeaderCell
        } else if rowNumber > count{
            let totalResultCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.totalResultCell.getIdentifier, for: indexPath) as! TotalResultTblVCell
            totalResultCell.totalmaxMarksLbl.text = sectionData?.totmax
            totalResultCell.totalMaxObtainedLbl.text = sectionData?.totmm
            totalResultCell.totalClassMaxLbl.text = "\(sectionData?.classTot ?? 0)"
            
            return totalResultCell
        } else {
            let data = resultObj?.result?[sectionNumber].res?[rowNumber - 1]
            let resultCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.resultCell.getIdentifier, for: indexPath) as! ResultsTblVCell
            resultCell.classMaxLbl.text = data?.high
            resultCell.maxMarksLbl.text = data?.max
            resultCell.maxObtainedLbl.text = data?.marks
            resultCell.subjectLbl.text = data?.subjectName
            return resultCell
        }
        
    }
}
extension ResultVC {
    func resultApi(){
        CommonObjects.shared.showProgress()
        let strUrl = "\(Base_Url)\(End_Points.Api_View_Marks.getEndpoints).php?EnrollNo=\(UserDefaults.getUserDetail()?.enrollNo ?? "")&SessionId=\(UserDefaults.getUserDetail()?.session_id ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_View_Marks.getEndpoints, apiRequestURL: strUrl)
    }
}
extension ResultVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_View_Marks.getEndpoints {
            let status = response["status"] as! Int
            if status == 1 {
                if let circularModelDictData = Mapper<ResultModel>().map(JSONObject: response) {
                    resultObj = circularModelDictData
                    //print(circularModelDictData)
                    DispatchQueue.main.async {
                        self.resultTblView.reloadData()
                    }
                }
                CommonObjects.shared.stopProgress()
            } else {
                DispatchQueue.main.async {
                    DispatchQueue.main.async {
                        CommonObjects.shared.stopProgress()
                    }
                    //CommonObjects.shared.showToast(message: msg, controller: self)
                }
                
            }
        }
    }
    func failure() {
        
    }
    
}
