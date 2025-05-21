//
//  NoticeVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 23/06/23.
//

import UIKit
import ObjectMapper
import WebKit

class NoticeVC: UIViewController {
    @IBOutlet weak var noticeTblView : UITableView!
    var strText = String()
    
    var circularObj : CircularModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Notice")
        noticeApi()
        noticeTblView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppSegue.webViewSegue.getDescription {
            if let destinationVc = segue.destination as? WebViewVC {
                destinationVc.desStr = circularObj?.circularArr?[sender as! Int].description ?? ""
            }
        }
    }
    //    @objc func openPdf(sender:UITapGestureRecognizer) {
    //        openWebView(urlSting: circularObj?.circularArr?[sender.view?.tag ?? 0].file ?? "", viewController: self)
    //    }
    @objc func viewCircular(sender:UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: AppStoryboards.dashboard.getDescription, bundle: .main)
        if let showImgVc = storyboard.instantiateViewController(withIdentifier: AppViewControllerID.showImgVC.getIdentifier) as? ShowImgVC {
            showImgVc.image = circularObj?.circularArr?[sender.view?.tag ?? 0].file
            present(showImgVc, animated: true)
        }
    }
    @objc func viewAttachment(sender:UITapGestureRecognizer) {
        openWebView(urlSting: circularObj?.circularArr?[sender.view?.tag ?? 0].file ?? "", viewController: self)
    }
}

extension NoticeVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return circularObj?.circularArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let noticeCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.noticeCell.getIdentifier, for: indexPath) as! NoticeTblViewCell
        noticeCell.dateLbl.text = circularObj?.circularArr?[indexPath.row].date
        noticeCell.titleLbl.text = circularObj?.circularArr?[indexPath.row].title
        let htmlString = circularObj?.circularArr?[indexPath.row].description ?? ""
        let processedText = processHTMLString(htmlString)
        
        noticeCell.descriptionLbl.attributedText = processedText
        switch circularObj?.circularArr?[indexPath.row].filetype {
        case ImageType.pdf:
            noticeCell.attachmentsStackView.isHidden = false
            noticeCell.circularStackView.isHidden = true
        case ImageType.jpeg:
            noticeCell.circularStackView.isHidden = false
            noticeCell.attachmentsStackView.isHidden = true
        default:
            noticeCell.attachmentsStackView.isHidden = true
            noticeCell.circularStackView.isHidden = true
            break
        }
        noticeCell.viewCircularView.tag = indexPath.row
        noticeCell.viewAttachmentView.tag = indexPath.row
        let viewCirculatTap = UITapGestureRecognizer(target: self, action: #selector(viewCircular(sender: )))
        noticeCell.viewCircularView.addGestureRecognizer(viewCirculatTap)
        
        let viewAttachmentTap = UITapGestureRecognizer(target: self, action: #selector(viewAttachment(sender: )))
        noticeCell.viewAttachmentView.addGestureRecognizer(viewAttachmentTap)
        return noticeCell
    }
}
extension NoticeVC {
    func noticeApi(){
        CommonObjects.shared.showProgress()
        let strUrl = "\(Base_Url)\(End_Points.Api_circular.getEndpoints).php?class_id=\(UserDefaults.getUserDetail()?.class_id ?? "")&section_id=\(UserDefaults.getUserDetail()?.section_id  ?? "")&branch_id=\(UserDefaults.getUserDetail()?.branch_id ?? "")&session_id=\(UserDefaults.getUserDetail()?.session_id ?? "")&student_id=\(UserDefaults.getUserDetail()?.studentId ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_circular.getEndpoints, apiRequestURL: strUrl)
    }
}
extension NoticeVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_circular.getEndpoints {
            let status = response["status"] as? Int
            if status == 1 {
                if let circularModelDictData = Mapper<CircularModel>().map(JSONObject: response) {
                    circularObj = circularModelDictData
                    DispatchQueue.main.async {
                        self.noticeTblView.reloadData()
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
