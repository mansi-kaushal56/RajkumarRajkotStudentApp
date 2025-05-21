//
//  NewsFeedDetailVC.swift
//  HAPSStudentApp
//
//  Created by Raj Mohan on 27/06/24.
//

import UIKit
import Kingfisher
import ObjectMapper

class NewsFeedDetailVC: UIViewController {

    @IBOutlet weak var newsFeedDescription: UILabel!
    @IBOutlet weak var newsFeedDate: UILabel!
    @IBOutlet weak var imageTableView: UITableView!
    var detailData: NewsFeedResponse?
    var newsFeedDetailObj: NewsFeedDetailModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Newsfeed")
        newsFeedDetailApi(newsFeedId: detailData?.id ?? "")
        
        
        // Do any additional setup after loading the view.
    }
    private func makeApiRequest(endpoint: String, parameters: [String: String]) {
        CommonObjects.shared.showProgress()
        
        let urlString = buildUrlWithParameters(base: Base_Url, endpoint: endpoint, parameters: parameters)
        
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: endpoint, apiRequestURL: urlString)
    }
    private func newsFeedDetailApi(newsFeedId: String) {
        let parameters: [String: String] = [
            "newsfeedid": "\(newsFeedId)"
        ]
        
        makeApiRequest(endpoint: End_Points.Api_News_Feed_Detail.getEndpoints, parameters: parameters)
    }

   
}
extension NewsFeedDetailVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: AppStoryboards.dashboard.getDescription, bundle: .main)
        if let showImgVc = storyboard.instantiateViewController(withIdentifier: AppViewControllerID.showImgVC.getIdentifier) as? ShowImgVC {
            showImgVc.image = newsFeedDetailObj?.images?[indexPath.row].image
            present(showImgVc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsFeedDetailObj?.images?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsfeedCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.newsFeedImgCell.getIdentifier, for: indexPath) as! NewsfeedImageTblCell
        if let imageUrlString = newsFeedDetailObj?.images?[indexPath.row].image,
           let encodedString = imageUrlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let imgURL = URL(string: encodedString) {
            
            newsfeedCell.newsFeedImg.kf.setImage(with: imgURL,placeholder: UIImage(named: "placeholderStImg"))
        }
       
        return newsfeedCell
    }
    
    
}
extension NewsFeedDetailVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_News_Feed_Detail.getEndpoints {
            let status = response["status"] as? Int
            if status == 1 {
                if let cNewsFeedDetailDictData = Mapper<NewsFeedDetailModel>().map(JSONObject: response) {
                 newsFeedDetailObj = cNewsFeedDetailDictData
                    DispatchQueue.main.async {
                        let htmlString = self.detailData?.newsDescription ?? ""
                        let processedText = self.processHTMLString(htmlString)
                        self.newsFeedDescription.attributedText = processedText
                        self.newsFeedDescription.font = UIFont(name: AppFonts.Roboto_Regular, size: 13)
                        self.newsFeedDate.text = self.detailData?.newsFeedDate
                       
                        self.imageTableView.reloadData()
                        
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
    }
    
    func failure() {
        DispatchQueue.main.async {
            CommonObjects.shared.stopProgress()
            CommonObjects.shared.showToast(message: AppMessages.MSG_FAILURE_ERROR, controller: self)
        }
    }
}

