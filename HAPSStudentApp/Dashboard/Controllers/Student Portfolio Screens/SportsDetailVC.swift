//
//  SportsDetailVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 01/07/23.
//

import UIKit
import ObjectMapper
import Kingfisher
import DZNEmptyDataSet

class SportsDetailVC: UIViewController {
    
    @IBOutlet weak var sportsDetailTblView : UITableView!
    var sportsDetailObj : SportsDetailModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sportsDetailAPI()
        backBtn(title: "Sports Detail")
        sportsDetailTblView.emptyDataSetSource = self
        sportsDetailTblView.emptyDataSetDelegate = self
    }
    @objc func showLargeImg(sender : UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: AppStoryboards.dashboard.getDescription, bundle: .main)
        if let showImgVc = storyboard.instantiateViewController(identifier: AppViewControllerID.showImgVC.getIdentifier) as? ShowImgVC {
            showImgVc.image = sportsDetailObj?.response?[sender.view?.tag ?? 0].file
            present(showImgVc, animated: true)
        }
            
    }
}
extension SportsDetailVC : DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        emptySetMessage()
    }
}
extension SportsDetailVC : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sportsDetailObj?.response?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sportsDetailCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.sportsDetailCell.getIdentifier, for: indexPath) as! SportsDetailTblVCell
        sportsDetailCell.nameLbl.text = sportsDetailObj?.response?[indexPath.row].stname
        sportsDetailCell.admissionNoLbl.text = sportsDetailObj?.response?[indexPath.row].adminno
        sportsDetailCell.awardLbl.text = sportsDetailObj?.response?[indexPath.row].prize_zone
        sportsDetailCell.levelLbl.text = sportsDetailObj?.response?[indexPath.row].level
        sportsDetailCell.nameLbl.text = sportsDetailObj?.response?[indexPath.row].stname
        sportsDetailCell.descriptionLbl.text = sportsDetailObj?.response?[indexPath.row].des
        sportsDetailCell.activityLbl.text = sportsDetailObj?.response?[indexPath.row].sports_name
        sportsDetailCell.yearLbl.text = sportsDetailObj?.response?[indexPath.row].year
        sportsDetailCell.categoryLbl.text = sportsDetailObj?.response?[indexPath.row].category
        let img = (sportsDetailObj?.response?[indexPath.row].file ?? "")
        let imgUrl = URL(string: img)
        sportsDetailCell.sportsImgView.kf.setImage(with: imgUrl)
        if sportsDetailObj?.response?[indexPath.row].file == ""{
            //sportsDetailCell.imageSView.isHidden = true
            //sportsDetailCell.sportsImgView.isHidden = true
            sportsDetailCell.imgLblView.isHidden = true
        } else {
            //sportsDetailCell.imageSView.isHidden = false
            //sportsDetailCell.sportsImgView.isHidden = false
            sportsDetailCell.imgLblView.isHidden = false
        }
        sportsDetailCell.sportsImgView.addGestureRecognizer(UITapGestureRecognizer(target: self,action: #selector(showLargeImg)))
        sportsDetailCell.sportsImgView.tag = indexPath.row
        print(sportsDetailCell.sportsImgView.tag)
        return sportsDetailCell
    }
}

extension SportsDetailVC {
    func sportsDetailAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(Base_Url)\(End_Points.Api_Student_Sports_Entry.getEndpoints).php?branch_id=\(UserDefaults.getUserDetail()?.branch_id ?? "")&session_id=\(UserDefaults.getUserDetail()?.session_id ?? "")&enroll_no=\(UserDefaults.getUserDetail()?.enrollNo ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Student_Sports_Entry.getEndpoints, apiRequestURL: strUrl)
    }
}
extension SportsDetailVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_Student_Sports_Entry.getEndpoints {
            let status = response["status"] as! Bool
            if status == true {
                if let sportsDetailDictData = Mapper<SportsDetailModel>().map(JSONObject: response) {
                    sportsDetailObj = sportsDetailDictData
                    print(sportsDetailDictData)
                    DispatchQueue.main.async {
                        self.sportsDetailTblView.reloadData()
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
