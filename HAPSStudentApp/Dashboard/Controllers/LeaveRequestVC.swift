//
//  LeaveRequestVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 26/06/23.
//

import UIKit
import Kingfisher

class LeaveRequestVC: UIViewController {
    @IBOutlet weak var fromDateView : UIView!
    @IBOutlet weak var toDateView : UIView!
    @IBOutlet weak var totalDaysView : UIView!
    @IBOutlet weak var subjectView : UIView!
    @IBOutlet weak var reasonView : UIView!
    
    @IBOutlet weak var fromDateTxtFld : UITextField!
    @IBOutlet weak var totalDaysLbl : UILabel!
    @IBOutlet weak var toDateTxtFld : UITextField!
    @IBOutlet weak var subjectTxtView : UITextView!
    @IBOutlet weak var reasonTxtView : UITextView!
    @IBOutlet weak var stImgView: UIImageView!
    @IBOutlet weak var stnameLbl: UILabel!
    @IBOutlet weak var stclassnameLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Navigation bar Buttons func
        backBtn(title: "Leave Request")
        self.fromDateTxtFld.setDatePickerAsInputViewFor(target: self, selector: #selector(fromDatePicker))
        self.toDateTxtFld.setDatePickerAsInputViewFor(target: self, selector: #selector(toDatePicker))
//        subjectTxtView.text = "Testing subject"
//        reasonTxtView.text = "Testing reason"
        setLblData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        fromDateView.layer.borderColor = UIColor.borderColor.cgColor
        toDateView.layer.borderColor = UIColor.borderColor.cgColor
        totalDaysView.layer.borderColor = UIColor.borderColor.cgColor
        subjectView.layer.borderColor = UIColor.borderColor.cgColor
        reasonView.layer.borderColor = UIColor.borderColor.cgColor
    }
    private func setLblData(){
        stnameLbl.text = UserDefaults.getUserDetail()?.studentName
        stclassnameLbl.text = "Class - \(UserDefaults.getUserDetail()?.className ?? "") , \(UserDefaults.getUserDetail()?.sectionName ?? "")"
        let img = (UserDefaults.getUserDetail()?.studentImage ?? "")
        let imgUrl = URL(string: img)
        stImgView.kf.setImage(with: imgUrl)
    }
    @IBAction func submitBtn(_ sender:UIButton) {
        applyLeaveApi()
    }
    @objc func fromDatePicker(_ sender : UIGestureRecognizer) {
        if let datepicker = self.fromDateTxtFld.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "dd-MM-yyyy"
            
            self.fromDateTxtFld.text = dateformatter.string(from: datepicker.date)
        }
        self.fromDateTxtFld.resignFirstResponder()
    }
    @objc func toDatePicker(_ sender : UIGestureRecognizer) {
        if let datePicker = self.toDateTxtFld.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "dd-MM-yyyy"
            
            self.toDateTxtFld.text = dateformatter.string(from: datePicker.date)
        }
        self.toDateTxtFld.resignFirstResponder()
    }
    func countDaysBetween(startDate: Date, endDate: Date) -> Int {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: startDate)
        let end = calendar.startOfDay(for: endDate)
        let components = calendar.dateComponents([.day], from: start, to: end)
        return (components.day ?? 0) + 1
    }
    
}
extension LeaveRequestVC : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == toDateTxtFld {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            
            if let startDateString = fromDateTxtFld.text,
               let endDateString = toDateTxtFld.text,
               let startDate = dateFormatter.date(from: startDateString),
               let endDate = dateFormatter.date(from: endDateString) {
                let numberOfDays = countDaysBetween(startDate: startDate, endDate: endDate)
                let numberOfDaysString = "\(numberOfDays)"
                totalDaysLbl.text = numberOfDaysString
                print(startDateString)
                print(endDateString)
            } else {
                totalDaysLbl.text = "0"
            }
        }
    }
}
extension LeaveRequestVC  {
    func applyLeaveApi() {
        let fromDate = fromDateTxtFld.text ?? ""
        if fromDate.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_FROMDATE_EMPTY, controller: self)
            return
        }
        let toDate = toDateTxtFld.text ?? ""
        if toDate.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_TODATE_EMPTY, controller: self)
            return
        }
        let subject = subjectTxtView.text ?? ""
        if subject.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_SUBJECT_EMPTY, controller: self)
            return
        }
        let reason = reasonTxtView.text ?? ""
        if reason.isEmpty {
            CommonObjects.shared.showToast(message: AppMessages.MSG_SUBJECT_EMPTY, controller: self)
            return
        }
        let strUrl = "\(Base_Url)\(End_Points.Api_Applyleave.getEndpoints).php?Enrolno=\(UserDefaults.getUserDetail()?.enrollNo ?? "")&Session=\(UserDefaults.getUserDetail()?.session_id ?? "")&BranchId=\(UserDefaults.getUserDetail()?.branch_id ?? "")&dateto=\(toDate)&datefrom=\(fromDate)&days=\(totalDaysLbl.text ?? "")&subject=\(subject)&reason=\(reason)"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Applyleave.getEndpoints, apiRequestURL: strUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }
}
extension LeaveRequestVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_Applyleave.getEndpoints {
            let status = response["status"] as! Bool
            let msg = response["msg"] as! String
            
            if status == true {
                DispatchQueue.main.async {
                    self.fromDateTxtFld.text = nil
                    self.totalDaysLbl.text = "Total Days"
                    self.toDateTxtFld.text = nil
                    self.subjectTxtView.text = nil
                    self.reasonTxtView.text = nil
                    self.showAlert(title: "", messsage: AppMessages.MSG_LEAVE_REQUEST_SUCCESS)
                    CommonObjects.shared.showToast(message: msg, controller: self)
                }
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: msg, controller: self)
                }
            }
            
        }
    }
    
    func failure() {
        
    }
}
