//
//  NewsVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 07/07/23.
//

import UIKit
import ObjectMapper
import Kingfisher

class NewsVC: UIViewController {
    @IBOutlet weak var newsTblView : UITableView!
    var newsObj : NewsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsAPI()
        backBtn(title:"News")
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppSegue.newsDetailSegue.getDescription {
            if let destinationVC = segue.destination as? NewsDetailVC {
                destinationVC.detailData = newsObj?.newsArr?[sender as! Int] //Sending the detaildata to NewsDetailVC
                
            }
        }
    }
}
extension NewsVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: AppSegue.newsDetailSegue.getDescription, sender: indexPath.row)
    }
}
extension NewsVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsObj?.newsArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.newsCell.getIdentifier, for: indexPath) as! NewsTblVCell
        newsCell.headingLbl.text = newsObj?.newsArr?[indexPath.row].heading
        //newsCell.descriptionLbl.text = newsObj?.newsArr?[indexPath.row].description
        newsCell.dateLbl.text = newsObj?.newsArr?[indexPath.row].date
        let img = (newsObj?.newsArr?[indexPath.row].file ?? "")
        let imgUrl = URL(string: img)
        newsCell.newsImgView.kf.setImage(with: imgUrl) // Load the image with kingfisher
        return newsCell
    }
}
extension NewsVC {
    func newsAPI() {
        let strUrl = "\(Base_Url)\(End_Points.Api_News.getEndpoints).php?branch_id=\(UserDefaults.getUserDetail()?.branch_id ?? "")&session_id=\(UserDefaults.getUserDetail()?.session_id ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_News.getEndpoints, apiRequestURL: strUrl)
    }
}
extension NewsVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_News.getEndpoints {
            //let status = response["status"] as! Bool
            //if status == true {
            let apiResponse = "\(response)"
            if apiResponse.isEmpty {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: AppMessages.MSG_NO_DATA_FOUND, controller: self)
                }
            } else {
                if let newsDictData = Mapper<NewsModel>().map(JSONObject: response) {
                    newsObj = newsDictData
                    print(newsDictData)
                    DispatchQueue.main.async {
                        self.newsTblView.reloadData()
                    }
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
