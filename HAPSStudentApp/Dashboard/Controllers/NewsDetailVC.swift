//
//  NewsDetailVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 07/07/23.
//

import UIKit
import Kingfisher
import ObjectMapper

class NewsDetailVC: UIViewController {
    var detailData: NewsModelData?
    var newsDetailObj : NewsModel?
    @IBOutlet weak var newsDetailTblView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsDetailAPI()
        backBtn(title: "News")
    }
}
extension NewsDetailVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            
        } else {
            detailData = nil
            detailData = newsDetailObj?.newsArr?[indexPath.row] // Reload the DetailData with list of news
            newsDetailTblView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 40
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        } else {
            let containerView = UIView()
            containerView.backgroundColor = UIColor.clear
            
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width:  self.newsDetailTblView.frame.width, height: 40))
            headerView.backgroundColor = .clear
            
            headerView.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(headerView)
            
            NSLayoutConstraint.activate([
                headerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
                headerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
                headerView.topAnchor.constraint(equalTo: containerView.topAnchor),
                headerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])
            let titleLbl = UILabel()
            //titleLbl.text = "Hoildays"
            titleLbl.font = UIFont(name: AppFonts.Roboto_Medium, size: 16)
            titleLbl.textColor = .black
            titleLbl.translatesAutoresizingMaskIntoConstraints = false
            titleLbl.text = "More News"
            headerView.backgroundColor = .clear
            headerView.addSubview(titleLbl)
            return containerView
        }
        
        
    }
}
extension NewsDetailVC : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return newsDetailObj?.newsArr?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            //News detail cell
            let descriptionCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.newsDetailCell.getIdentifier, for: indexPath) as! NewsDescriptionTblVCell
            
            descriptionCell.newsHeadingLbl.text = detailData?.heading
            //Date:: 10, Apr 2024 - change description data into HTNl to string
            //let htmlStr = detailData?.description
            //descriptionCell.descriptionLbl.attributedText = htmlStr?.htmlAttributedString()
            descriptionCell.descriptionLbl.text = detailData?.description
            descriptionCell.dateLbl.text = detailData?.date
            let img = (detailData?.file ?? "")
            let imgUrl = URL(string: img)
            descriptionCell.newsImgView.kf.setImage(with: imgUrl)
            return descriptionCell
        } else {
            //News list cell
            let newsCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.moreNewsCell.getIdentifier, for: indexPath) as! MoreNewsTblVCell
            newsCell.headingLbl.text = newsDetailObj?.newsArr?[indexPath.row].heading
            //newsCell.descriptionLbl.text = newsObj?.newsArr?[indexPath.row].description
            newsCell.dateLbl.text = newsDetailObj?.newsArr?[indexPath.row].date
            let img = (newsDetailObj?.newsArr?[indexPath.row].file ?? "")
            let imgUrl = URL(string: img)
            newsCell.newsImgView.kf.setImage(with: imgUrl)
            return newsCell
            
        }
    }
    
}

extension NewsDetailVC {
    func newsDetailAPI() {
        let strUrl = "\(Base_Url)\(End_Points.Api_News.getEndpoints).php?branch_id=\(UserDefaults.getUserDetail()?.branch_id ?? "")&session_id=\(UserDefaults.getUserDetail()?.session_id ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_News.getEndpoints, apiRequestURL: strUrl)
    }
}
extension NewsDetailVC : RequestApiDelegate {
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
                    newsDetailObj = newsDictData
                    print(newsDictData)
                    DispatchQueue.main.async {
                        self.newsDetailTblView.reloadData()
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
