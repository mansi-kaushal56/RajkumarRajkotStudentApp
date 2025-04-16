//
//  ConversationVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 15/07/23.
//

import UIKit
import ObjectMapper
import AVFoundation


class ConversationVC: UIViewController {
    
    var feedbackChatObj: FeedbackChatModel?
    var feedbackid: String?
    var emailID: String?
    var phoneNo: String?
    var sendBy: String?
    var feedbackImg = UIImage()
    
    @IBOutlet weak var messageTxtFld: UITextField!
    @IBOutlet weak var feedbackChatListTblView: UITableView!
    @IBOutlet weak var stnameLbl: UILabel!
    @IBOutlet weak var classNameLbl: UILabel!
    @IBOutlet weak var admissionNoLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var nameAndDateLbl: UILabel!
    @IBOutlet weak var feedbackLbl: UILabel!
    @IBOutlet weak var ibfileAttachmentBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Conversation" )
        feedbackchatAPI()
        setLblData()
    }
    
    @IBAction func imgPIckerBtn(_ sender: UIButton) {
        checkCameraPermission()
    }
    
    @IBAction func sendBtn(_ sender: UIButton) {
        savefeedbackchatAPI()
    }
    
    @IBAction func openfileAttachment( _ sender: UIButton) {
        let storyBoard = UIStoryboard(name: AppStoryboards.dashboard.getDescription, bundle: .main)
        if let showfileImgVC = storyBoard.instantiateViewController(withIdentifier: AppViewControllerID.showImgVC.getIdentifier) as? ShowImgVC {
            showfileImgVC.image = feedbackChatObj?.file?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            present(showfileImgVC, animated: true)
        }
    }
    @objc func openFile(sender:UIButton) {
        let storyBoard = UIStoryboard(name: AppStoryboards.dashboard.getDescription, bundle: .main)
        if let showImgVC = storyBoard.instantiateViewController(withIdentifier: AppViewControllerID.showImgVC.getIdentifier) as? ShowImgVC {
            showImgVC.image = feedbackChatObj?.response?[sender.tag].file
            present(showImgVC, animated: true)
        }
    }
    
    func setLblData() {
        if feedbackChatObj?.file == "" {
            ibfileAttachmentBtn.isHidden = true
        } else {
            ibfileAttachmentBtn.isHidden = false
        }
        stnameLbl.text = UserDefaults.getUserDetail()?.studentName
        classNameLbl.text = "\(UserDefaults.getUserDetail()?.className ?? "") \(UserDefaults.getUserDetail()?.sectionName ?? "")"
        admissionNoLbl.text = "Admission No. \(UserDefaults.getUserDetail()?.enrollNo ?? "")"
        emailLbl.text = emailID
        phoneLbl.text = phoneNo
        nameAndDateLbl.text = "\(feedbackChatObj?.name ?? "")\(feedbackChatObj?.feedbackdate ?? "")"
        feedbackLbl.text = feedbackChatObj?.feedback
    }
}
extension ConversationVC {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let img = info[.originalImage] as? UIImage {
            //userImg = img
            feedbackImg = img
        } else if let img = info[.editedImage] as? UIImage {
            //userImg = img
            feedbackImg = img
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

extension ConversationVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedbackChatObj?.response?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let feedbackChatCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.feedbackChatCell.getIdentifier, for: indexPath) as! FeedbackChatTblVCell
        feedbackChatCell.feedbackLbl.text = feedbackChatObj?.response?[indexPath.row].msg
        feedbackChatCell.nameAndDateLbl.text = "\(feedbackChatObj?.response?[indexPath.row].sentby ?? "") \(feedbackChatObj?.response?[indexPath.row].date ?? "")"
        feedbackChatCell.attachmentBtn.tag = indexPath.row
        feedbackChatCell.attachmentBtn.addTarget(self, action: #selector(openFile(sender: )), for: .touchUpInside)
        if feedbackChatObj?.response?[indexPath.row].file == "" {
            feedbackChatCell.attachmentBtn.isHidden = true
        } else {
            feedbackChatCell.attachmentBtn.isHidden = false
        }
        return feedbackChatCell
    }
}

extension ConversationVC {
    func savefeedbackchatAPI() {
        
        let feedbackMsg = messageTxtFld.text ?? ""
        if feedbackMsg.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_MESSAGE_EMPTY, controller: self)
            return
        }
        CommonObjects.shared.showProgress()
        let parameters = ["feedbackid":feedbackid ?? "",
                          "enrollno":UserDefaults.getUserDetail()?.enrollNo ?? "",
                          "msg":feedbackMsg,
                          "sendername":sendBy ?? ""]
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestNativeImageUpload(apiName: End_Points.Api_Savefeedback_Chat.getEndpoints, image: feedbackImg, parameters: parameters)
        //            let strUrl = "\(Base_Url)\(End_Points.Api_Savefeedback_Chat.getEndpoints).php?feedbackid=\(feedbackid ?? "")&enrollno=\(UserDefaults.getUserDetail()?.enrollNo ?? "")&msg=\(feedbackMsg)&sendername=\(feedbackChatObj?.name ?? "")&file="
        //            let obj = ApiRequest()
        //            obj.delegate = self
        //            obj.requestAPI(apiName: End_Points.Api_Savefeedback_Chat.getEndpoints, apiRequestURL: strUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }
    func feedbackchatAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(Base_Url)\(End_Points.Api_Feedbackchat.getEndpoints).php?session_id=\(UserDefaults.getUserDetail()?.session_id ?? "")&branch_id=\(UserDefaults.getUserDetail()?.branch_id ?? "")&feedbackid=\(feedbackid ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Feedbackchat.getEndpoints, apiRequestURL: strUrl)
    }
}

extension ConversationVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_Feedbackchat.getEndpoints {
            let status = response["status"] as! Int
            let name = response["name"] as! String
            if status == 1 {
                if let feedbackDictData = Mapper<FeedbackChatModel>().map(JSONObject: response) {
                    feedbackChatObj = feedbackDictData
                    print(feedbackDictData)
                    DispatchQueue.main.async {
                        self.setLblData()
                        print("\(name)")
                        self.feedbackChatListTblView.reloadData()
                    }
                }
            } else {
                if let feedbackDictData = Mapper<FeedbackChatModel>().map(JSONObject: response) {
                    feedbackChatObj = feedbackDictData
                    print(feedbackDictData)
                    DispatchQueue.main.async {
                        self.setLblData()
                        print("\(name)")
                        self.feedbackChatListTblView.reloadData()
                    }
                }
                DispatchQueue.main.async {
                    print("\(name)")
                    CommonObjects.shared.showToast(message: AppMessages.MSG_NO_DATA_FOUND, controller: self)
                }
            }
        }
        if api == End_Points.Api_Savefeedback_Chat.getEndpoints {
            let msg = response["msg"] as? String
            let status = response["status"] as? Int
            if status == 1 {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: msg ?? "", controller: self)
                    self.messageTxtFld.text = ""
                    self.feedbackImg = UIImage()
                    self.feedbackchatAPI()
                    self.feedbackChatListTblView.reloadData()
                }
            } else{
                print("hello")
            }
        }
        
    }
    
    func failure() {
        DispatchQueue.main.async {
            CommonObjects.shared.showToast(message: AppMessages.MSG_FAILURE_ERROR, controller: self)
        }
    }
}
