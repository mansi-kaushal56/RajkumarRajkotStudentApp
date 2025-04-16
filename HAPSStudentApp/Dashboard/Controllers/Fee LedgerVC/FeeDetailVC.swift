//
//  FeeDetailVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 19/07/23.
//

import UIKit
import ObjectMapper

class FeeDetailVC: UIViewController {
    
    var feeDetailObj: FeeDetailModel?
    var receiptId: String?
    
    @IBOutlet weak var feeDetailTblView: UITableView!
    @IBOutlet weak var receiptNoLbl: UILabel!
    @IBOutlet weak var studentnameLbl: UILabel!
    @IBOutlet weak var fathernameLbl: UILabel!
    
    @IBOutlet weak var paydateLbl: UILabel!
    @IBOutlet weak var classLbl: UILabel!
    @IBOutlet weak var rollnoLbl: UILabel!
    
    @IBOutlet weak var monthLbl: UILabel!
    @IBOutlet weak var branchAddressLbl: UILabel!
    @IBOutlet weak var branchPhoneLbl: UILabel!
    
    @IBOutlet weak var branchMobileLbl: UILabel!
    @IBOutlet weak var branchWebSiteLbl: UILabel!
    @IBOutlet weak var branchEmailLbl: UILabel!
    @IBOutlet weak var enrollNoLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feeDetailAPI()
        backBtn(title: "Fee Receipt")
        downloadBtn()
        // Do any additional setup after loading the view.
    }
    func downloadBtn() {
        let downloadBtn = UIBarButtonItem(image: UIImage(named: "downloadImg2"), style: .plain, target: self, action: #selector(downloadBtnTapped))
        
        navigationItem.rightBarButtonItem = downloadBtn
        
    }
    @objc func downloadBtnTapped(){
        let url = "\(feeDetailObj?.response?[0].url ?? "")"
        openWebView(urlSting: url, viewController: self)
    }
    func setLblData() {
        receiptNoLbl.text = feeDetailObj?.response?[0].receiptNo
        studentnameLbl.text = feeDetailObj?.response?[0].studentname
        fathernameLbl.text = feeDetailObj?.response?[0].fathername
        
        paydateLbl.text = feeDetailObj?.response?[0].paydate
        classLbl.text = feeDetailObj?.response?[0].className
        rollnoLbl.text = feeDetailObj?.response?[0].rollno
        
        monthLbl.text = feeDetailObj?.response?[0].month
        branchAddressLbl.text = feeDetailObj?.response?[0].branchAddress
        branchPhoneLbl.text = "Phone - \(feeDetailObj?.response?[0].branchPhone ?? "")"
        
       // branchMobileLbl.text = feeDetailObj?.response?[0].branchMobile
        branchWebSiteLbl.text = "Website - \(feeDetailObj?.response?[0].branchWebSite ?? "")"
        branchEmailLbl.text = "Email - \(feeDetailObj?.response?[0].branchEmail ?? "")"
        enrollNoLbl.text = feeDetailObj?.response?[0].enrollNo
        
    }
}
extension FeeDetailVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .TblCellBg
        let titleLbl  = UILabel()
        titleLbl.layer.borderWidth = 1
        titleLbl.backgroundColor = .TblCellBg
        titleLbl.textAlignment = .center
        titleLbl.font = UIFont(name: AppFonts.Roboto_Medium, size: 13)
        if section == 0 {
            titleLbl.text = "Fee Detail"
        } else if section == 1 {
            titleLbl.text = "Payment Detail"
        } else {
            titleLbl.text = "Total Amount"
        }
        
        headerView.addSubview(titleLbl)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
           titleLbl.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
           titleLbl.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10),
           titleLbl.topAnchor.constraint(equalTo: headerView.topAnchor,constant: 5),
           titleLbl.bottomAnchor.constraint(equalTo: headerView.bottomAnchor,constant: -5)

        ])
     
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Fee Detail"
        } else {
            return "Payment Detail"
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            print(feeDetailObj?.response?[0].details?.count ?? 0)
            return feeDetailObj?.response?[0].details?.count ?? 0
        } else {
            print(feeDetailObj?.response?[0].paymentdetails?.count ?? 0)
            return feeDetailObj?.response?[0].paymentdetails?.count ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let feeDetailCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.feeDetailCell.getIdentifier, for: indexPath) as! FeeDetailTblVCell
            let feeDetailData = feeDetailObj?.response?[0].details?[indexPath.row]
            feeDetailCell.particularLbl.text = feeDetailData?.particular
            feeDetailCell.payableAmtLbl.text = feeDetailData?.payableAmount
            feeDetailCell.preAmtLbl.text = "0.0"
            feeDetailCell.paidAmtLbl.text = feeDetailData?.payableAmount
            feeDetailCell.currAmtLbl.text = feeDetailData?.currentAmount
            // feeDetailCell.outstndAmtLbl.text = feeDetailData?.outstanding
            if feeDetailData?.outstanding == nil {
                feeDetailCell.outstndAmtLbl.text = "0"
            } else {
                feeDetailCell.outstndAmtLbl.text = feeDetailData?.outstanding
            }
            
            return feeDetailCell
        } else {
            let paymentDetailCell = tableView.dequeueReusableCell(withIdentifier:AppTblCells.paymentDetailCell.getIdentifier,for: indexPath) as! PaymentDetailTblVCell
            let paymentDetailData = feeDetailObj?.response?[0].paymentdetails?[indexPath.row]
            paymentDetailCell.paymentModeLbl.text = paymentDetailData?.paymode
            
            if paymentDetailData?.bankName == "" || paymentDetailData?.bankName == "" {
                paymentDetailCell.bankNameLbl.text = " \(paymentDetailData?.bankName ?? "")"
            } else {
                paymentDetailCell.bankNameLbl.text = paymentDetailData?.bankName
            }
            
            if paymentDetailData?.chequeno == "" || paymentDetailData?.chequeno == nil {
                paymentDetailCell.chequeNoLbl.text = " \(paymentDetailData?.chequeno ?? "")"
            } else {
                paymentDetailCell.chequeNoLbl.text = paymentDetailData?.chequeno
            }
            
            if paymentDetailData?.chequedate == "" || paymentDetailData?.chequedate == nil  {
                paymentDetailCell.chequeDateLbl.text = " \(paymentDetailData?.chequedate ?? "")"
            } else {
                paymentDetailCell.chequeDateLbl.text = paymentDetailData?.chequedate
            }
            
            paymentDetailCell.amountLbl.text = "\(paymentDetailData?.totalPaidAmount ?? 0)"
            paymentDetailCell.totalPayableAmtLbl.text = "\(paymentDetailData?.totalPayableAmount ?? 0)"
            paymentDetailCell.totalPaidAmtLbl.text = "\(paymentDetailData?.totalPaidAmount ?? 0)"
            paymentDetailCell.totalOutstandingLbl.text = "\(paymentDetailData?.totalOutstanding ?? 0)"
            return paymentDetailCell
        }
    }
}

extension FeeDetailVC {
    
    func feeDetailAPI() {
        let strUrl = "\(Base_Url)\(End_Points.Api_FeeDetail.getEndpoints).php?Enrollno=\(UserDefaults.getUserDetail()?.enrollNo ?? "")&ReceiptId=\(receiptId ?? "")&BranchId=\(UserDefaults.getUserDetail()?.branch_id ?? "")&Session=\(UserDefaults.getUserDetail()?.session_id ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_FeeDetail.getEndpoints, apiRequestURL: strUrl)
    }
}
extension FeeDetailVC : RequestApiDelegate {
    
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_FeeDetail.getEndpoints {
            let status = response["status"] as! Bool
            if status == true {
                if let feeDetailDictData = Mapper<FeeDetailModel>().map(JSONObject: response) {
                    feeDetailObj = feeDetailDictData
                    print(feeDetailDictData)
                    DispatchQueue.main.async {
                        self.setLblData()
                        self.feeDetailTblView.reloadData()
                    }
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
    
    func failure() {
        DispatchQueue.main.async {
            CommonObjects.shared.showToast(message: AppMessages.MSG_FAILURE_ERROR, controller: self)
        }
    }
}
