//
//  AssignmentsVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 29/06/23.
//

import UIKit
import ObjectMapper

class AssignmentsVC: UIViewController {
    @IBOutlet weak var  assignmentsTblView : UITableView!
    
    var assignmentObj : AssignmentsModel?

    override func viewDidLoad() {
        super.viewDidLoad()
      backBtn(title: "Assignments")
        assignmentsApi()
        // Do any additional setup after loading the view.
    }
    
    @objc func showLargeImg(sender : UITapGestureRecognizer) {
        
        let storyboard = UIStoryboard(name: AppStoryboards.dashboard.getDescription, bundle: .main)
        if let showImgvc = storyboard.instantiateViewController(withIdentifier: AppViewControllerID.showImgVC.getIdentifier) as? ShowImgVC
        {
            showImgvc.image = assignmentObj?.assignmentsArr?[sender.view?.tag ?? 0 ].imgpath
            present(showImgvc, animated: true)
        }
    }

}
extension AssignmentsVC : UITableViewDelegate {
    
}
extension AssignmentsVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assignmentObj?.assignmentsArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let assignmentsCell  = tableView.dequeueReusableCell(withIdentifier: AppTblCells.assignmantsCell.getIdentifier, for: indexPath) as! AssignmentsTblVCell
        let assignmentData = assignmentObj?.assignmentsArr?[indexPath.row]
        assignmentsCell.dueDateLbl.layer.cornerRadius = 7
        assignmentsCell.dueDateLbl.clipsToBounds = true
        assignmentsCell.assignedByLbl.text = assignmentData?.teacher
        assignmentsCell.assignedDateLbl.text = assignmentData?.assignDate
        assignmentsCell.dueDateLbl.text = "Due Date: \(assignmentData?.dueDate ?? "")"
        assignmentsCell.subjectLbl.text = assignmentData?.subject
        assignmentsCell.descriptionLbl.text = assignmentData?.Description
    
        
        let img = (assignmentObj?.assignmentsArr?[indexPath.row].imgpath ?? "")
        let imgUrl = URL(string: img)
        assignmentsCell.assignmentImgView.kf.setImage(with: imgUrl)
        assignmentsCell.assignmentImgView.tag = indexPath.row
        assignmentsCell.assignmentImgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showLargeImg)))
        
        return assignmentsCell
    }
}

extension AssignmentsVC {
    func assignmentsApi(){
        CommonObjects.shared.showProgress()
        let strUrl = "\(Base_Url)\(End_Points.Api_Assignments.getEndpoints).php?ClassId=\(UserDefaults.getUserDetail()?.class_id ?? "")&SectionId=\(UserDefaults.getUserDetail()?.section_id ?? "")&BranchId=\(UserDefaults.getUserDetail()?.branch_id ?? "")&Session=\(UserDefaults.getUserDetail()?.session_id ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Assignments.getEndpoints, apiRequestURL: strUrl)
    }
}
extension AssignmentsVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_Assignments.getEndpoints {
            let status = response["status"] as! Bool
            if status == true {
                if let assignmentsDictData = Mapper<AssignmentsModel>().map(JSONObject: response) {
                    assignmentObj = assignmentsDictData
                    print(assignmentsDictData)
                    DispatchQueue.main.async {
                        self.assignmentsTblView.reloadData()
                    }
                }
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
