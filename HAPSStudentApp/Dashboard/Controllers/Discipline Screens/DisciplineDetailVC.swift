//
//  DisciplineDetailVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 05/07/23.
//

import UIKit
import ObjectMapper
import DZNEmptyDataSet

class DisciplineDetailVC: UIViewController {
    @IBOutlet weak var emojiImgView : UIImageView!
    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var disciplineDetailTblView: UITableView!
    @IBOutlet weak var disciplineDetailView : UIView!
    
    var disciplineDetailObj : DisciplineDetailModel?
    var type : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disciplineDetailApi()
        backBtn(title: "Discipline")
        if type == "Smiley" {
            titleLbl.text = "Smiley"
            emojiImgView.image = UIImage(named:"smiley" )
        } else {
            titleLbl.text = "Frowney"
            emojiImgView.image = UIImage(named:"frowneyIcon" )
        }
        
        disciplineDetailTblView.emptyDataSetSource = self
        disciplineDetailTblView.emptyDataSetDelegate = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        disciplineDetailView.layer.borderColor = UIColor.borderColor.cgColor
    }
}

extension DisciplineDetailVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return disciplineDetailObj?.disciplineDetailArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  disciplineDetailCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.disciplineDetailCell.getIdentifier, for: indexPath) as! DisciplineDetailTblVCell
        disciplineDetailCell.dateLbl.text = disciplineDetailObj?.disciplineDetailArr?[indexPath.row].created_Date
        //disciplineDetailCell.parameterLbl.text = disciplineDetailObj?.disciplineDetailArr?[indexPath.row].parameter
        disciplineDetailCell.givenByLbl.text = disciplineDetailObj?.disciplineDetailArr?[indexPath.row].empCode
        //Date:: 10, Apr 2024 - parameter empty check
        
        if disciplineDetailObj?.disciplineDetailArr?[indexPath.row].parameter == "" || disciplineDetailObj?.disciplineDetailArr?[indexPath.row].parameter == nil {
            disciplineDetailCell.parameterLbl.text = ""
        } else {
            disciplineDetailCell.parameterLbl.text = disciplineDetailObj?.disciplineDetailArr?[indexPath.row].parameter
        }
        return disciplineDetailCell
    }
}
extension DisciplineDetailVC : DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        emptySetMessage()
    }
}

extension DisciplineDetailVC {
    func disciplineDetailApi(){
        let strUrl = "\(Base_Url)\(End_Points.Api_Discipline_Detail.getEndpoints).php?EnrollNo=\(UserDefaults.getUserDetail()?.enrollNo ?? "")&Session=\(UserDefaults.getUserDetail()?.session_id  ?? "")&BranchId=\(UserDefaults.getUserDetail()?.branch_id ?? "")&Type=\(type ?? "")"
        //test with data
        //let strUrl = "\(Base_Url)\(End_Points.Api_Discipline_Detail.getEndpoints).php?EnrollNo=\("9887")&Session=\("26")&BranchId=\("2")&Type=\(type ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Discipline_Detail.getEndpoints, apiRequestURL: strUrl)
    }
}
extension DisciplineDetailVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_Discipline_Detail.getEndpoints {
//            let apiResponse = "\(response)"
            let status = response["status"] as? String
            if status == "true" {
                if let diciplineCountDictData = Mapper<DisciplineDetailModel>().map(JSONObject: response) {
                    disciplineDetailObj = diciplineCountDictData
                    //print(circularModelDictData)
                    DispatchQueue.main.async {
                        //self.showData()
                        self.disciplineDetailTblView.reloadData()
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
