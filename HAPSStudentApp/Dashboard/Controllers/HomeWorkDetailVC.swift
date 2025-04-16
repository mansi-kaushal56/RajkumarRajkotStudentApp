//
//  HomeWorkDetailVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 18/07/23.
//

import UIKit
import ObjectMapper

class HomeWorkDetailVC: UIViewController {
    @IBOutlet weak var homeWorkDetailTblView: UITableView!
    
    var homeworkId: String?
    var homeWorkDetailObj: HomeWorkDetailModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Home Work Detail")
        homeWorkDetailAPI()
        
        // Do any additional setup after loading the view.
    }
}

extension HomeWorkDetailVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeWorkDetailObj?.response?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let homeWorkDetailCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.homeWorkDetailCell.getIdentifier, for: indexPath) as! HomeWorkDetailTblVCell
        let homeWorkData = homeWorkDetailObj?.response?[indexPath.row]
        homeWorkDetailCell.dueDateLbl.layer.cornerRadius = 7
        homeWorkDetailCell.dueDateLbl.clipsToBounds = true
        homeWorkDetailCell.assignedByLbl.text = homeWorkData?.teacher
        homeWorkDetailCell.assignedDateLbl.text = homeWorkData?.assigned_date
        homeWorkDetailCell.dueDateLbl.text = "Due Date:\(homeWorkData?.due_date ?? "")"
        homeWorkDetailCell.despLbl.text = homeWorkData?.desp
        homeWorkDetailCell.subjectLbl.text = homeWorkData?.subject
        
//        switch homeWorkData?.fileType {
//        case "pdf":
//            break
//        case "png":
//            break
//        case "":
//            break
//        default:
//            print("Wrong FileType")
//            break
//        }

        if homeWorkData?.file == "" {
            homeWorkDetailCell.homeworkImgView.isHidden = true
            //homeWorkDetailCell.homeworkImageCont.constant = 0
        } else {
            setUpImage(image: homeWorkData?.file ?? "", imageView: homeWorkDetailCell.homeworkImgView)
        }
        
        
        return homeWorkDetailCell
    }
}

extension HomeWorkDetailVC {
    func homeWorkDetailAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(Base_Url)\(End_Points.Api_Homework_Detail.getEndpoints).php?homeworkId=\(homeworkId ?? "")&SectionId=\(UserDefaults.getUserDetail()?.session_id ?? "")&BranchId=\(UserDefaults.getUserDetail()?.enrollNo ?? "")&Session=\(UserDefaults.getUserDetail()?.enrollNo ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Homework_Detail.getEndpoints, apiRequestURL: strUrl)
    }
}
extension HomeWorkDetailVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        
        if api == End_Points.Api_Homework_Detail.getEndpoints {
            let apiResponse = "\(response)"
            if apiResponse.isEmpty {
                DispatchQueue.main.async {
                    CommonObjects.shared.stopProgress()
                    CommonObjects.shared.showToast(message: AppMessages.MSG_NO_DATA_FOUND, controller: self)
                }
                
            } else {
                if let homeWorkListDictData = Mapper<HomeWorkDetailModel>().map(JSONObject: response) {
                    homeWorkDetailObj = homeWorkListDictData
                    print(homeWorkListDictData)
                    DispatchQueue.main.async {
                        self.homeWorkDetailTblView.reloadData()
                    }
                }
                CommonObjects.shared.stopProgress()
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
