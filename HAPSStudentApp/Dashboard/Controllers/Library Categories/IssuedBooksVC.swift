//
//  IssuedBooksVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 10/07/23.
//

import UIKit
import ObjectMapper

class IssuedBooksVC: UIViewController {
    @IBOutlet weak var issuedBooksTblView: UITableView!
    
    var booksObj: BooksModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        IssuedBooksAPI()
        backBtn(title: "Issued Books")
        // Do any additional setup after loading the view.
    }
    
    
}
extension IssuedBooksVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return booksObj?.booksModelArr?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let headerCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.libraryheaderCell.getIdentifier, for: indexPath)
            return headerCell
        } else {
            let issuedBooksCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.issuedBooksCell.getIdentifier, for: indexPath) as! IssuedBooksTblVCell
            issuedBooksCell.accessnoLbl.text = booksObj?.booksModelArr?[indexPath.row].accessno
            issuedBooksCell.booktitleLbl.text = booksObj?.booksModelArr?[indexPath.row].booktitle
            issuedBooksCell.issueDateLbl.text = booksObj?.booksModelArr?[indexPath.row].issuedate
            issuedBooksCell.returndate.text = booksObj?.booksModelArr?[indexPath.row].returndate
            return issuedBooksCell
        }
    }
    
}
extension IssuedBooksVC {
    func  IssuedBooksAPI() {
        let strUrl = "\(Base_Url)\(End_Points.Api_Issued_Books.getEndpoints).php?branchid=\(UserDefaults.getUserDetail()?.branch_id ?? "")&enrollno=\(UserDefaults.getUserDetail()?.enrollNo ?? "")"
        //test with data
       // let strUrl = "\(Base_Url)\(End_Points.Api_Issued_Books.getEndpoints).php?branchid=\("2")&enrollno=\("8122")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Issued_Books.getEndpoints, apiRequestURL: strUrl)
    }
}
extension IssuedBooksVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_Issued_Books.getEndpoints {
            let status = response["status"] as! Bool
            if status == true {
                if let newsDictData = Mapper<BooksModel>().map(JSONObject: response) {
                    booksObj = newsDictData
                    print(newsDictData)
                    DispatchQueue.main.async {
                        self.issuedBooksTblView.reloadData()
                    }
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
