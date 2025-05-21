//
//  LikeListViewController.swift
//  HAPSStudentApp
//
//  Created by Raj Mohan on 28/06/24.
//

import UIKit
import ObjectMapper

class LikeListViewController: UIViewController {
    var likeListObj: LikeListModel?
    var id: String?

    @IBOutlet weak var tblLikeListHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var fullScreenView: UIView!
    @IBOutlet weak var likeListTblView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        likeListAPI()
        // Do any additional setup after loading the view.
        addGestures()
        
    }
    
    
    private func addGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleFullScreenViewTapGestue))
        self.fullScreenView.addGestureRecognizer(tapGesture)
    }
    @objc func backBtnTap(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    
    @objc private func handleFullScreenViewTapGestue() {
        self.dismiss(animated: false)
    }

}
extension LikeListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likeListObj?.response?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let likeListCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.likeListCell.getIdentifier, for: indexPath) as! LikeListTabelViewCell
        let obj = self.likeListObj?.response?[indexPath.row]
        likeListCell.studentName.text = obj?.StudentName ?? ""
        likeListCell.studentClassRollNo.text = "Enroll No. \(obj?.EntrollNo ?? "") || Class: \(obj?.ClassName ?? "")-\(obj?.SectionName ?? "")"
        return likeListCell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30)

        // Create a UIButton instead of UIBarButtonItem
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 16, y: 15, width: 30, height: 30)
        backButton.setImage(UIImage(named: "cross_icon"), for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(self, action: #selector(backBtnTap), for: .touchUpInside)

        headerView.addSubview(backButton)
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }

    
    
}
extension LikeListViewController {
    func likeListAPI() {
        let strUrl = "\(Base_Url)\(End_Points.Api_News_Feed_Like_List.getEndpoints).php?newsfeedid=\(id ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_News_Feed_Like_List.getEndpoints, apiRequestURL: strUrl)
    }
}
extension LikeListViewController: RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_News_Feed_Like_List.getEndpoints {
            if let responseStatus = response["status"] as? Bool {
                if responseStatus == true {
                    if let likeListDictData = Mapper<LikeListModel>().map(JSONObject: response) {
                        likeListObj = likeListDictData
                        
                        DispatchQueue.main.async {
                            self.likeListTblView.reloadData()
                            self.updateTableContentInset()
                            let rows = self.likeListTblView.numberOfRows(inSection: 0)
                            self.tblLikeListHeightConstraint.constant = CGFloat(72 * CGFloat(rows) + 72)
                            self.view.layoutIfNeeded()
                        }
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.dismiss(animated: true)
                }
            }
        }
    }
    
    
    func updateTableContentInset() {
        let numRows = self.likeListTblView.numberOfRows(inSection: 0)
        var contentInsetTop = self.likeListTblView.bounds.size.height
        for i in 0..<numRows {
            let rowRect = self.likeListTblView.rectForRow(at: IndexPath(item: i, section: 0))
            contentInsetTop -= rowRect.size.height
            if contentInsetTop <= 0 {
                contentInsetTop = 0
                break
            }
        }
        self.likeListTblView.contentInset = UIEdgeInsets(top: contentInsetTop,left: 0,bottom: 0,right: 0)
    }
    
    
    func failure() {
        DispatchQueue.main.async {
            CommonObjects.shared.showToast(message: AppMessages.MSG_FAILURE_ERROR)
        }
    }
}
extension LikeListViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view != self.fullScreenView {
            self.dismiss(animated: false, completion: nil)
        }
    }
}
