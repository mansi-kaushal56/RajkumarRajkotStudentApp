//
//  ReturnedBooksVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 10/07/23.
//

import UIKit
import ObjectMapper

class ReturnedBooksVC: UIViewController {
    var returnedBookObj : BooksModel?
    @IBOutlet weak var returnedBooksTblView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        returnBooksAPI()
        backBtn(title: "Return Books")
        // Do any additional setup after loading the view.
    }
}
extension ReturnedBooksVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return returnedBookObj?.booksModelArr?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let headerCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.libraryheaderCell.getIdentifier, for: indexPath)
            return headerCell
        } else {
            let returnedBooksCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.issuedBooksCell.getIdentifier, for: indexPath) as! IssuedBooksTblVCell
            returnedBooksCell.accessnoLbl.text = returnedBookObj?.booksModelArr?[indexPath.row].accessno
            returnedBooksCell.booktitleLbl.text = returnedBookObj?.booksModelArr?[indexPath.row].booktitle
            returnedBooksCell.issueDateLbl.text = returnedBookObj?.booksModelArr?[indexPath.row].issuedate
            returnedBooksCell.returndate.text = returnedBookObj?.booksModelArr?[indexPath.row].returndate
            return returnedBooksCell
        }
    }
    
}
extension ReturnedBooksVC {
    func  returnBooksAPI() {
        let strUrl = "\(Base_Url)\(End_Points.Api_Returned_Books.getEndpoints).php?branchid=\(UserDefaults.getUserDetail()?.branch_id ?? "")&enrollno=\(UserDefaults.getUserDetail()?.enrollNo ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Returned_Books.getEndpoints, apiRequestURL: strUrl)
    }
}
extension ReturnedBooksVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_Returned_Books.getEndpoints {
            let status = response["status"] as! Bool
            if status == true {
                if let newsDictData = Mapper<BooksModel>().map(JSONObject: response) {
                    returnedBookObj = newsDictData
                    print(newsDictData)
                    DispatchQueue.main.async {
                        self.returnedBooksTblView.reloadData()
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
