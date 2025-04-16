//
//  NewsfeedImageTblCell.swift
//  HAPSStudentApp
//
//  Created by Raj Mohan on 27/06/24.
//

import UIKit
import Kingfisher

class NewsfeedImageTblCell: UITableViewCell {

    var newsfeedImgInfo : NewsFeedResponse? {
        didSet {
            imageTblView.reloadData()
            self.updateTableContentInset()
            let rows = self.imageTblView.numberOfRows(inSection: 0)
            self.imageTblHeightConstrain.constant = CGFloat(250 * CGFloat(rows))
           
        }
    }
 
    @IBOutlet weak var imageTblHeightConstrain: NSLayoutConstraint!
    @IBOutlet weak var imageTblView: UITableView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageTblView.delegate = self
        self.imageTblView.dataSource = self
      
        // Initialization code
    }
    func updateTableContentInset() {
        let numRows = self.imageTblView.numberOfRows(inSection: 0)
        var contentInsetTop = self.imageTblView.bounds.size.height
        for i in 0..<numRows {
            let rowRect = self.imageTblView.rectForRow(at: IndexPath(item: i, section: 0))
            contentInsetTop -= rowRect.size.height
            if contentInsetTop <= 0 {
                contentInsetTop = 0
                break
            }
        }
        self.imageTblView.contentInset = UIEdgeInsets(top: contentInsetTop,left: 0,bottom: 0,right: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension NewsfeedImageTblCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(newsfeedImgInfo?.totalImages ?? "") ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newsFeedImgCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.newsFeedDetailImgCell.getIdentifier, for: indexPath) as! NewsFeedDetailImgTblCell

        if indexPath.row == 0 {
            let imgURL =  URL(string:"\(newsfeedImgInfo?.image1 ?? "")")
            newsFeedImgCell.feedDetailImage.kf.setImage(with: imgURL)
        } else if indexPath.row == 1 {
            let imgURL =  URL(string:"\(newsfeedImgInfo?.image2 ?? "")")
            newsFeedImgCell.feedDetailImage.kf.setImage(with: imgURL)
        } else if indexPath.row == 2 {
            let imgURL =  URL(string:"\(newsfeedImgInfo?.image3 ?? "")")
            newsFeedImgCell.feedDetailImage.kf.setImage(with: imgURL)
        } else {
            let imgURL =  URL(string:"\(newsfeedImgInfo?.image4 ?? "")")
            newsFeedImgCell.feedDetailImage.kf.setImage(with: imgURL)
        }
        return newsFeedImgCell
    }
    
    
}
