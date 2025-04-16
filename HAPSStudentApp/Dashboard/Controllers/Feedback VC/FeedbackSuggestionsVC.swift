//
//  FeedbackSuggestionsVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 06/07/23.
//

import UIKit
import ObjectMapper
import AVFoundation

class FeedbackSuggestionsVC: UIViewController {
    var feedbackImg = UIImage()
    
    @IBOutlet weak var studentNameLbl: UILabel!
    @IBOutlet weak var guardianNameTxtFld: UITextField!
    @IBOutlet weak var emailIDTxtFld: UITextField!
    @IBOutlet weak var contactNoTxtFld: UITextField!
    @IBOutlet weak var schoolNameLbl: UILabel!
    @IBOutlet weak var enrollNoLbl: UILabel!
    @IBOutlet weak var feedBackTxtView: UITextView!
    @IBOutlet weak var feedbackImgView: UIImageView!
    @IBOutlet weak var relationLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLblData()
        barBtns()
        backBtn(title: "Feedback/Suggestions")
        
        let relationGestureRecognizer = UITapGestureRecognizer()
        relationLbl.addGestureRecognizer(relationGestureRecognizer)
        relationGestureRecognizer.addTarget(self, action: #selector(relationTapped))
        
        let imgTapGestureRecognizer = UITapGestureRecognizer()
        feedbackImgView.addGestureRecognizer(imgTapGestureRecognizer)
        imgTapGestureRecognizer.addTarget(self, action: #selector(imgViewTapped))
        
    }
    
    @IBAction func submitBtn(_ sender: UIButton) {
        feedbackSuggestionsApi()
    }
    @objc func imgViewTapped( _ sender: UITapGestureRecognizer){
        checkCameraPermission()
    }
    func barBtns() {
        
        let feedbackListBtn = UIButton(frame:CGRect(x: 0, y: 0, width: 24, height: 24))
        feedbackListBtn.addTarget(self, action: #selector(feedbackListTapped), for: .touchUpInside)
        feedbackListBtn.setImage(UIImage(named: "documentsfiletext"), for: .normal)
        feedbackListBtn.contentMode = .center
        feedbackListBtn.imageView?.contentMode = .scaleAspectFit
        feedbackListBtn.contentVerticalAlignment = .fill
        feedbackListBtn.contentHorizontalAlignment = .fill
        feedbackListBtn.imageEdgeInsets = UIEdgeInsets(top: 5, left: 40, bottom: 5, right: 0)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: feedbackListBtn)
    }
    @objc func feedbackListTapped() {
        performSegue(withIdentifier: AppSegue.feedbackListSegue.getDescription, sender: nil)
    }
    
    func setupLblData() {
        studentNameLbl.text = UserDefaults.getUserDetail()?.studentName
        schoolNameLbl.text = "Raj Kumar college, \(UserDefaults.getUserDetail()?.branch_name ?? "")"
        enrollNoLbl.text = UserDefaults.getUserDetail()?.enrollNo
        
    }
    @objc func relationTapped(_ sender:UIGestureRecognizer) {
        let ac = UIAlertController(title: "Choose Relation", message: "", preferredStyle: .actionSheet)
        //        ac.addAction(UIAlertAction(title: "Relation", style: .default,handler: { [self] (UIAlertAction) in
        //            relationLbl.text = "Relation"
        //        }))
        ac.addAction(UIAlertAction(title: "Mother", style: .default,handler: { [self] (UIAlertAction) in
            relationLbl.text = "Mother"
            //            showAlert(title: AppMessages.MSG_FEEDBACK_SUCCESS, messsage: "")
        }))
        ac.addAction(UIAlertAction(title: "Father", style: .default,handler: { [self] (UIAlertAction) in
            relationLbl.text = "Father"
        }))
        ac.addAction(UIAlertAction(title: "Guardian", style: .default,handler: { [self] (UIAlertAction) in
            relationLbl.text = "Guardian"
        }))
        present(ac, animated: true)
        //        "Relation", "Mother", "Father", "Guardian"
        
    }
}
extension FeedbackSuggestionsVC {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let img = info[.originalImage] as? UIImage {
            feedbackImg = img
            feedbackImgView.image = img
        } else if let img = info[.editedImage] as? UIImage {
            feedbackImg = img
            feedbackImgView.image = img
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
extension FeedbackSuggestionsVC {
    func feedbackSuggestionsApi() {
        let gurdianName = guardianNameTxtFld.text ?? ""
        if gurdianName.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_GURDIAN_NAME_EMPTY, controller: self)
            return
        }
        let emailId = emailIDTxtFld.text ?? ""
        if emailId.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_EMAIL_ADDRESS_EMPTY, controller: self)
            return
        }
        let contactNo = contactNoTxtFld.text ?? ""
        if contactNo.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_PHONE_NUMBER_EMPTY, controller: self)
            return
        }
        let feedback = feedBackTxtView.text ?? ""
        if feedback.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_FEED_EMPTY, controller: self)
            return
        }
        let parameters = ["Enrolno": UserDefaults.getUserDetail()?.enrollNo ?? "",
                          "gurdianname" : gurdianName,
                          "relation" : relationLbl.text ?? "",
                          "email" : emailId,
                          "phone" : contactNo,
                          "feedback" : feedback,
                          "BranchId" : UserDefaults.getUserDetail()?.branch_id ?? "",
                          "Session" : UserDefaults.getUserDetail()?.session_id ?? ""]
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestNativeImageUpload(apiName: End_Points.Api_Feedback_Submit.getEndpoints, image: feedbackImg, parameters: parameters)
    }
}


extension FeedbackSuggestionsVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_Feedback_Submit.getEndpoints {
            let status = response["status"] as! Bool
            if status == true {
                DispatchQueue.main.async {
                    self.showAlert(title: AppMessages.MSG_FEEDBACK_SUCCESS, messsage: "")
                }
            } else {
            }
        }
    }
    
    func failure() {
        DispatchQueue.main.async {
            CommonObjects.shared.showToast(message: AppMessages.MSG_FAILURE_ERROR, controller: self)
        }
    }
}
extension FeedbackSuggestionsVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == contactNoTxtFld {
            let maxLength = 10
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            newString.rangeOfCharacter(from: CharacterSet.decimalDigits)
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return newString.length <= maxLength && allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}
