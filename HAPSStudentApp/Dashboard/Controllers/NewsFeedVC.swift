//
//  NewsFeedVC.swift
//  HAPSStudentApp
//
//  Created by Raj Mohan on 25/06/24.
//

import UIKit
import ObjectMapper

class NewsFeedVC: UIViewController {
    
    @IBOutlet weak var newsFeedTblView: UITableView!
    
    var newsFeedListObj : NewsFeedListModel?
    var shareNewsfeedModel : ShareNewsfeedModel?
    var shareURL : String?
    var shareSenderButton: UIButton?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsFeedApi()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppSegue.newsFeedCellSegue.getDescription {
            if let destinationVC = segue.destination as? NewsFeedDetailVC {
                destinationVC.detailData = newsFeedListObj?.response?[sender as! Int] //Sending the detaildata to NewsDetailVC
            }
        }
    }
    
    
    @objc func likeBtnList(sender: UIButton) {
        let storyboard = UIStoryboard.init(name: AppStoryboards.dashboard.getDescription, bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: AppViewControllerID.likeListvc.getIdentifier) as! LikeListViewController
        vc.modalPresentationStyle = .overFullScreen
        let rowIndex = sender.tag
        let likeListId = newsFeedListObj?.response?[rowIndex].id
        vc.id = likeListId
        present(vc, animated: false)
    }
    @objc func shareBtn(sender: UIButton) {
        let rowIndex = sender.tag
        let newsFeed = newsFeedListObj?.response?[rowIndex]

        // Save sender for use after API response
        self.shareSenderButton = sender

        // Call API
        newsShareApi(newsFeedId: newsFeed?.id ?? "")
    }

    
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        let rowIndex = sender.tag
        var newsFeed = newsFeedListObj?.response?[rowIndex]
        
        sender.isSelected = !sender.isSelected
        newsFeed?.like = sender.isSelected ? "Yes" : "No"
        
        if sender.isSelected {
            sender.setImage(UIImage(named: "ic_likePostSelection"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "ic_like"), for: .normal)
        }
        newsLikeApi(newsFeedId: "\(newsFeedListObj?.response?[rowIndex].id ?? "")")
        
    }
   
    private func makeApiRequest(endpoint: String, parameters: [String: String]) {
        CommonObjects.shared.showProgress()
        
        let urlString = buildUrlWithParameters(base: Base_Url, endpoint: endpoint, parameters: parameters)
        
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: endpoint, apiRequestURL: urlString)
    }
    
    //Api Calls
    private func newsFeedApi() {
        let getUserDetail = UserDefaults.getUserDetail()
        
        let parameters: [String: String] = [
            "BranchId": "\(getUserDetail?.branch_id ?? "")",
            "Session": "\(getUserDetail?.session_id ?? "")",
            "enrollno": "\(getUserDetail?.enrollNo ?? "")"
        ]
        
        makeApiRequest(endpoint: End_Points.Api_News_Feed.getEndpoints, parameters: parameters)
    }
    private func newsLikeApi(newsFeedId: String) {
        let getUserDetail = UserDefaults.getUserDetail()
        let parameters: [String: String] = [
            "newsfeedid": "\(newsFeedId)",
            "enrollno": "\(getUserDetail?.enrollNo ?? "")"
        ]
        
        makeApiRequest(endpoint: End_Points.Api_News_Feed_Like.getEndpoints, parameters: parameters)
    }
    private func newsShareApi(newsFeedId: String) {
        let getUserDetail = UserDefaults.getUserDetail()
        
        let parameters: [String: String] = [
            "newsfeedid": "\(newsFeedId)",
            "enrollno": "\(getUserDetail?.enrollNo ?? "")"
        ]
        
        makeApiRequest(endpoint: End_Points.Api_News_Feed_Share.getEndpoints, parameters: parameters)
    }
    
}
extension NewsFeedVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: AppSegue.newsFeedCellSegue.getDescription, sender: indexPath.row)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsFeedListObj?.response?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsFeedCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.newsFeedCell.getIdentifier, for: indexPath) as! NewsFeedTblCell
        
        let newsFeed = newsFeedListObj?.response?[indexPath.row]
        //newsFeedCell.images = newsFeed?.image1
        
        let htmlString = newsFeed?.newsDescription ?? ""
        let processedText = processHTMLString(htmlString)
        
        newsFeedCell.descriptionLabel.attributedText = processedText
        newsFeedCell.imageCollectionView.reloadData()
        newsFeedCell.newsfeedDataInfo = newsFeed
        newsFeedCell.totalLikesLabel.text = "\(newsFeed?.totalLikes ?? "") Likes"
        newsFeedCell.totalShareLabel.text = "\(newsFeed?.totalShare ?? "") Share"
        
        newsFeedCell.dateLabel.text = newsFeed?.newsFeedDate
        if let likeStatus = newsFeed?.like {
            if likeStatus == "Yes" {
                newsFeedCell.likeBtnTapped.setImage(UIImage(named: "ic_likePostSelection"), for: .normal)
            } else {
                newsFeedCell.likeBtnTapped.setImage(UIImage(named: "ic_like"), for: .normal)
            }
        } else {
            // Handle default case if necessary
        }
        
        newsFeedCell.likeBtnTapped.addTarget(self, action: #selector(likeButtonTapped(_:)), for: .touchUpInside)
        //newsFeedCell.imageCollectionView.reloadData()
        newsFeedCell.likeBtn.tag = indexPath.row
        newsFeedCell.sahreBtnTapped.tag = indexPath.row
        //        newsFeedCell.likeBtn.addTarget(self, action: #selector(likeBtnList), for: .touchUpInside)
        newsFeedCell.likeBtn.addTarget(self, action: #selector(likeBtnList(sender:)), for: .touchUpInside)
        newsFeedCell.sahreBtnTapped.addTarget(self, action: #selector(shareBtn(sender:)), for: .touchUpInside)
        
        return newsFeedCell
    }
    
    
}
extension NewsFeedVC: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_News_Feed.getEndpoints {
            
            let status = response["status"] as? Int
            if status == 1 {
                if let newsFeedModelDictData = Mapper<NewsFeedListModel>().map(JSONObject: response) {
                    newsFeedListObj = newsFeedModelDictData
                    DispatchQueue.main.async {
                        self.newsFeedTblView.reloadData()
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
        if api == End_Points.Api_News_Feed_Share.getEndpoints {
            let status = response["status"] as? Int
            CommonObjects.shared.stopProgress()

            if status == 1 {
                if let newsFeedModelDictData = Mapper<ShareNewsfeedModel>().map(JSONObject: response) {
                    shareNewsfeedModel = newsFeedModelDictData
                    shareURL = shareNewsfeedModel?.weburl

                    DispatchQueue.main.async {
                        if let urlString = self.shareURL, let url = URL(string: urlString) {
                            let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)

                            if let sender = self.shareSenderButton {
                                activityVC.popoverPresentationController?.sourceView = sender
                            }

                            self.present(activityVC, animated: true)
                            print("weburl: \(urlString)")
                        }

                    }
                    // Reset sender after use
                    self.shareSenderButton = nil
                }
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.showToast(message: AppMessages.MSG_NO_DATA_FOUND, controller: self)
                }
            }
        }

        
        if api == End_Points.Api_News_Feed_Like.getEndpoints {
            let status = response["status"] as? Int
            if status == 1 {
                newsFeedApi()
               
                CommonObjects.shared.stopProgress()
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
