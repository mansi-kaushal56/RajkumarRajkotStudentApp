//
//  ApplyGatePassVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 27/12/23.
//

import UIKit
import ObjectMapper

class ApplyGatePassVC: UIViewController {
    //Date :: 29, Dec 2023
    var reasonOfLeaveObj: LeaveReasonsModel?
    var accompanyWithObj: LeaveReasonsModel?
    var selReasonOfLeave: LeaveReasonsRest?
    var selAccompany: LeaveReasonsRest?
    var authLetterImg  = UIImage()

    @IBOutlet weak var studentClassLbl: UILabel!
    @IBOutlet weak var studentImgView: UIImageView!
    @IBOutlet weak var studentNameLbl: UILabel!
    @IBOutlet weak var dateOfOutpassTxtFld: UITextField!
    @IBOutlet weak var dateOfReturnTxtFld: UITextField!
    @IBOutlet weak var dateOfOutpassView: UIView!
    @IBOutlet weak var dateOfReturnView: UIView!
    @IBOutlet weak var reasonForLeaveTxtView: UITextView!
    @IBOutlet weak var accompaniedwithTxtView: UITextView!
    @IBOutlet weak var reasonOfLeaveView: UIView!
    @IBOutlet weak var accompaniedwithView: UIView!
    @IBOutlet weak var uploadAuthorityLetterView: UIView!
    @IBOutlet weak var uploadAuthLetterImgView: UIImageView!
    
    let dateformatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leaveReasonsApi()
        accompanyApi()
        backBtn(title: "Apply Gate Pass")
        setLblData()
        tapGestures()
        dateformatter.dateFormat = "dd-MM-yyyy"
        uploadAuthorityLetterView.isHidden = true
        self.dateOfOutpassTxtFld.setDatePickerAsInputViewFor(target: self, selector: #selector(dateOfOutpassPicker))
        self.dateOfReturnTxtFld.setDatePickerAsInputViewFor(target: self, selector: #selector(dateOfReturnPicker))
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dateOfOutpassView.layer.borderColor = UIColor.borderColor.cgColor
        dateOfReturnView.layer.borderColor = UIColor.borderColor.cgColor
        
    }

    @IBAction func actionSubmitBtn(_ sender: UIButton) {
        gatePassRequestApi()
    }
    
    //MARK: @objc Functions
    
    @objc func uploadImg(sender:UITapGestureRecognizer) {
        checkCameraPermission()
    }
    @objc func dateOfOutpassPicker(_ sender : UIGestureRecognizer) {
        if let datepicker = self.dateOfOutpassTxtFld.inputView as? UIDatePicker {
            self.dateOfOutpassTxtFld.text = dateformatter.string(from: datepicker.date)
        }
        self.dateOfOutpassTxtFld.resignFirstResponder()
    }
    @objc func dateOfReturnPicker(_ sender : UIGestureRecognizer) {
        if let datePicker = self.dateOfReturnTxtFld.inputView as? UIDatePicker {
            self.dateOfReturnTxtFld.text = dateformatter.string(from: datePicker.date)
        }
        self.dateOfReturnTxtFld.resignFirstResponder()
    }
    //Date :: 29, Dec 2023
    //MARK: Functions
    func listAppear(type: ScreenType) {
        let storyboard = UIStoryboard.init(name: AppStoryboards.dashboard.getDescription, bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: AppViewControllerID.listAppearvc.getIdentifier) as! ListAppearVC
        vc.modalPresentationStyle = .overFullScreen
        switch type {
        case .LeaveReasons:
            vc.type = .LeaveReasons
            vc.reasonOfLeaveListObj = reasonOfLeaveObj
            vc.delegate = self
        case .Accompany:
            vc.type = .Accompany
            vc.accompanyWithListObj = accompanyWithObj
            vc.delegate = self
            
        default :
            return
        }
        
        self.present(vc, animated: true)
    }
    private func setLblData(){
        studentNameLbl.text = UserDefaults.getUserDetail()?.studentName
        studentClassLbl.text = "Class - \(UserDefaults.getUserDetail()?.className ?? "") , \(UserDefaults.getUserDetail()?.sectionName ?? "")"
        let img = (UserDefaults.getUserDetail()?.studentImage ?? "")
        let imgUrl = URL(string: img)
        studentImgView.kf.setImage(with: imgUrl)
    }
    func tapGestures() {
        reasonOfLeaveView.addTapGestureRecognizer {
            self.listAppear(type: .LeaveReasons)
        }
        accompaniedwithView.addTapGestureRecognizer {
            self.listAppear(type: .Accompany)
        }
        let uploadImgTap = UITapGestureRecognizer()
        uploadAuthLetterImgView.addGestureRecognizer(uploadImgTap)
        uploadImgTap.addTarget(self, action: #selector(uploadImg))
    }
}
extension ApplyGatePassVC:SenderVCDelegate {
    func messageData(data: AnyObject?, type: ScreenType?) {
        switch type {
        case .LeaveReasons:
            selReasonOfLeave = data as? LeaveReasonsRest
            reasonForLeaveTxtView.text = selReasonOfLeave?.reason
        case .Accompany:
            selAccompany = data as? LeaveReasonsRest
            accompaniedwithTxtView.text = selAccompany?.name
            
            if selAccompany?.name == "Driver" {
                uploadAuthorityLetterView.isHidden = false
            } else {
                uploadAuthorityLetterView.isHidden = true
            }
        default:
            break
        }
    }
}
extension ApplyGatePassVC {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let img = info[.originalImage] as? UIImage {
            authLetterImg = img
            uploadAuthLetterImgView.image = img
        } else if let img = info[.editedImage] as? UIImage {
            authLetterImg = img
            uploadAuthLetterImgView.image = img
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
extension ApplyGatePassVC {
    func leaveReasonsApi() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(Base_Url)\(End_Points.Api_Leave_Reasons.getEndpoints).php?"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Leave_Reasons.getEndpoints, apiRequestURL: strUrl)
    }
    func accompanyApi() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(Base_Url)\(End_Points.Api_Accompanied_With.getEndpoints).php?"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Accompanied_With.getEndpoints, apiRequestURL: strUrl)
    }
    func gatePassRequestApi() {
        
        let dateOfReturn = dateOfReturnTxtFld.text ?? ""
        if dateOfReturn.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_DateOfReturnEmpty)
            return
        }
        let dateOfOutpass  = dateOfOutpassTxtFld.text ?? ""
        if dateOfOutpass.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_DateOfOutpassEmpty)
            return
        }
        let reasonForLeave = reasonForLeaveTxtView.text ?? ""
        if reasonForLeave.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_ReasonForLeaveEmpty)
            return
        }
        
        let accompanyWith = accompaniedwithTxtView.text ?? ""
        if accompanyWith.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_AccompaniedEmpty)
            return
        }
        
        let parameters = ["BranchId": UserDefaults.getUserDetail()?.branch_id ?? "",
                          "adminno" : UserDefaults.getUserDetail()?.enrollNo ?? "",
                          "todate" : dateOfReturn,
                          "outdate" : dateOfOutpass,
                          "leavereason" : selReasonOfLeave?.id ?? "",
                          "accompany" : selAccompany?.id ?? ""] as [String : String]
        print(parameters)
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestNativeImageUpload(apiName: End_Points.Api_Gate_Pass_Request.getEndpoints, image: authLetterImg, parameters: parameters)
        
    }
}
//Date :: 29, Dec 2023
extension ApplyGatePassVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_Leave_Reasons.getEndpoints {
            let status = response["status"] as! Bool
            if status == true {
                if let leaveReasonsDictData = Mapper<LeaveReasonsModel>().map(JSONObject: response) {
                    reasonOfLeaveObj = leaveReasonsDictData
                }
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: AppMessages.MSG_NO_DATA_FOUND, controller: self)
                }
            }
        }
        if api == End_Points.Api_Accompanied_With.getEndpoints {
            let status = response["status"] as! Bool
            if status == true {
                if let accompanyWithDictData = Mapper<LeaveReasonsModel>().map(JSONObject: response) {
                    accompanyWithObj = accompanyWithDictData
                }
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: AppMessages.MSG_NO_DATA_FOUND, controller: self)
                }
            }
        }
        if api == End_Points.Api_Gate_Pass_Request.getEndpoints {
            let status = response["status"] as! Int
            if status == 1 {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: AppMessages.MSG_Gate_Pass_Request)
                    self.navigationController?.popViewController(animated: true)
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
