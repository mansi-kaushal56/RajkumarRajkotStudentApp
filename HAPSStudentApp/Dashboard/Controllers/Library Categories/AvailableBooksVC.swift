//
//  AvailableBooksVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 14/07/23.
//

import UIKit
import ObjectMapper

class AvailableBooksVC: UIViewController {
    var libBooksListObj: AvailableBooksListModel?
    @IBOutlet weak var libBooksTblView: UITableView!
    @IBOutlet weak var searchTxtFld: UITextField!
    @IBOutlet weak var searchCountLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        availableBooksListApi()
        backBtn(title: "Available Books")
    }
}
extension AvailableBooksVC: UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return libBooksListObj?.availableBooksListArr?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let headerCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.libraryheaderCell.getIdentifier, for: indexPath)
            return headerCell
        } else {
            let libBookListCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.libBookListCell.getIdentifier, for: indexPath) as! LibBooksTblVCell
            let libBookData = libBooksListObj?.availableBooksListArr?[indexPath.row]
            libBookListCell.accNoLbl.text = libBookData?.accessno
            libBookListCell.bookNameLbl.text = libBookData?.book_title
            libBookListCell.authNameLbl.text = libBookData?.autname
            libBookListCell.statusLbl.text = libBookData?.status
            if libBookData?.status == "ISSUED" {
                libBookListCell.statusLbl.textColor = UIColor.AppYellow
            } else {
                libBookListCell.statusLbl.textColor = UIColor.AppGreen
            }
            return libBookListCell
        }
    }
}
extension AvailableBooksVC {
    func  availableBooksListApi() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(Base_Url)\(End_Points.Api_Lib_Books.getEndpoints).php?branch_id=\(UserDefaults.getUserDetail()?.branch_id ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Lib_Books.getEndpoints, apiRequestURL: strUrl)
    }
    func  searchBooksListApi() {
        CommonObjects.shared.showProgress()
        let searchText = searchTxtFld.text ?? ""
        let strUrl = "\(Base_Url)\(End_Points.Api_Search_Books.getEndpoints).php?keyword=\(searchText)&branch_id=\(UserDefaults.getUserDetail()?.branch_id ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Search_Books.getEndpoints, apiRequestURL: strUrl)
    }
}
extension AvailableBooksVC : RequestApiDelegate {
    
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_Lib_Books.getEndpoints {
            let status = response["status"] as! Bool
            //            let apiResponse = "\(response)"
            if status == true {
                if let  studentGalleryDetailDictData = Mapper<AvailableBooksListModel>().map(JSONObject: response) {
                    libBooksListObj = studentGalleryDetailDictData
                    print(studentGalleryDetailDictData)
                    DispatchQueue.main.async {
                        self.libBooksTblView.reloadData()
                    }
                }
                CommonObjects.shared.stopProgress()
            }else {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: AppMessages.MSG_NO_DATA_FOUND, controller: self)
                }
            }
        }
        
        if api == End_Points.Api_Search_Books.getEndpoints {
            let status = response["status"] as! Int
            if status == 1 {
                if let  studentGalleryDetailDictData = Mapper<AvailableBooksListModel>().map(JSONObject: response) {
                    libBooksListObj = studentGalleryDetailDictData
                    print(studentGalleryDetailDictData)
                    DispatchQueue.main.async {
                        self.searchCountLbl.text = "\(self.libBooksListObj?.availableBooksListArr?.count ?? 0) Results"
                        self.libBooksTblView.reloadData()
                    }
                    CommonObjects.shared.stopProgress()
                }
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: AppMessages.MSG_NO_DATA_FOUND, controller: self)
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


extension AvailableBooksVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == searchTxtFld {
            searchBooksListApi()
        }
    }
}
