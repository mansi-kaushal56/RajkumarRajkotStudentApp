//
//  ActivityDetailsVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 03/07/23.
//

import UIKit
import ObjectMapper
import DZNEmptyDataSet

class ActivityDetailsVC: UIViewController {
    @IBOutlet weak var activityDetailTblView : UITableView!
    
    var activityDetailObj: ActivityDetailsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        studentActivityAPI()
        backBtn(title: "Activity Details")
        
        activityDetailTblView.emptyDataSetSource = self
        activityDetailTblView.emptyDataSetDelegate = self
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppSegue.showImgSegue.getDescription {
            if let destinationVc =  segue.destination as? ShowImgVC {
                destinationVc.image = activityDetailObj?.activityDetailsArr?[sender as! Int].file
            }
        }
        
    }
    @objc func showLargeImg(sender : UITapGestureRecognizer) {
        if activityDetailObj?.activityDetailsArr?[sender.view?.tag ?? 0].file == "" {
        } else {
            let storyboard = UIStoryboard(name: AppStoryboards.dashboard.getDescription, bundle: .main)
            if let showImgVc = storyboard.instantiateViewController(identifier: AppViewControllerID.showImgVC.getIdentifier) as? ShowImgVC {
                showImgVc.image = activityDetailObj?.activityDetailsArr?[sender.view?.tag ?? 0].file
                present(showImgVc, animated: true)
            }
        }
        //        performSegue(withIdentifier: AppSegue.showImgSegue.getDescription, sender: sender.view?.tag)
    }
}
extension ActivityDetailsVC : UITableViewDelegate {
    
}
extension ActivityDetailsVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityDetailObj?.activityDetailsArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let activityDetailCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.activityDetailCell.getIdentifier, for: indexPath) as! ActivityDetailTblVCell
        activityDetailCell.categoryLbl.text = activityDetailObj?.activityDetailsArr?[indexPath.row].category
        activityDetailCell.admissionNoLbl.text = activityDetailObj?.activityDetailsArr?[indexPath.row].adminno
        activityDetailCell.yearLbl.text = activityDetailObj?.activityDetailsArr?[indexPath.row].year
        activityDetailCell.levelLbl.text = activityDetailObj?.activityDetailsArr?[indexPath.row].level
        activityDetailCell.nameLbl.text = activityDetailObj?.activityDetailsArr?[indexPath.row].stname
        activityDetailCell.descriptionLbl.text = activityDetailObj?.activityDetailsArr?[indexPath.row].des
        activityDetailCell.activityLbl.text = activityDetailObj?.activityDetailsArr?[indexPath.row].activity
        
        if activityDetailObj?.activityDetailsArr?[indexPath.row].file == "" {
//            activityDetailCell.activityImgView.isHidden = true
            //activityDetailCell.actStackView.isHidden = true
            activityDetailCell.imgLblAndImgView.isHidden = true
        } else {
            //activityDetailCell.activityImgView.isHidden = false
            //activityDetailCell.actStackView.isHidden = false
            activityDetailCell.imgLblAndImgView.isHidden = false
        }
        let img = (activityDetailObj?.activityDetailsArr?[indexPath.row].file ?? "")
        let imgUrl = URL(string: img)
        activityDetailCell.activityImgView.kf.setImage(with: imgUrl)
        
        activityDetailCell.activityImgView.addGestureRecognizer(UITapGestureRecognizer(target: self,action: #selector(showLargeImg)))
        activityDetailCell.activityImgView.tag = indexPath.row
        return activityDetailCell
    }
}
extension ActivityDetailsVC : DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        emptySetMessage()
    }
}
extension ActivityDetailsVC {
    
    func studentActivityAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(Base_Url)\(End_Points.APi_Student_Activity_Entry.getEndpoints).php?branch_id=\(UserDefaults.getUserDetail()?.branch_id ?? "")&session_id=\(UserDefaults.getUserDetail()?.session_id ?? "")&enroll_no=\(UserDefaults.getUserDetail()?.enrollNo ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.APi_Student_Activity_Entry.getEndpoints, apiRequestURL: strUrl)
    }
}
extension ActivityDetailsVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.APi_Student_Activity_Entry.getEndpoints {
            //let apiResponse = "\(response)"
            let status = response["status"] as! Int
            //let stname = response["stname"] as? String
            if status == 1 {
                if let activityDetailDictData = Mapper<ActivityDetailsModel>().map(JSONObject: response) {
                    activityDetailObj = activityDetailDictData
                    print(activityDetailDictData)
                    DispatchQueue.main.async {
                        self.activityDetailTblView.reloadData()
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

