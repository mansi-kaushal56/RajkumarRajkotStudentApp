//
//  NewsFeedTblCell.swift
//  HAPSStudentApp
//
//  Created by Raj Mohan on 25/06/24.
//

import UIKit
import Kingfisher

class NewsFeedTblCell: UITableViewCell {
    var newsfeedDataInfo: NewsFeedResponse?

    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var sahreBtn: UIButton!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var sahreBtnTapped: UIButton!
    @IBOutlet weak var likeBtnTapped: UIButton!
    @IBOutlet weak var totalShareLabel: UILabel!
    @IBOutlet weak var totalLikesLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
//    var imagesCount = Int()
    var images = [String]()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
extension NewsFeedTblCell : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(newsfeedDataInfo?.totalImages ?? "") ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: AppCVCells.newsFeedImageCell.getIdentifier, for: indexPath) as! NewsFeedImageCollectionCell
        if indexPath.row == 0 {
            let imgURL =  URL(string:"\(newsfeedDataInfo?.image1 ?? "")")
            imageCell.newsfeedImg.kf.setImage(with: imgURL)
        } else if indexPath.row == 1 {
            let imgURL =  URL(string:"\(newsfeedDataInfo?.image2 ?? "")")
            imageCell.newsfeedImg.kf.setImage(with: imgURL)
        } else if indexPath.row == 2 {
            let imgURL =  URL(string:"\(newsfeedDataInfo?.image3 ?? "")")
            imageCell.newsfeedImg.kf.setImage(with: imgURL)
        } else {
            let imgURL =  URL(string:"\(newsfeedDataInfo?.image4 ?? "")")
            imageCell.newsfeedImg.kf.setImage(with: imgURL)
        }
        return imageCell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if newsfeedDataInfo?.totalImages == "1" {
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
        } else if newsfeedDataInfo?.totalImages == "2" {
            return CGSize(width: (collectionView.frame.size.width - 10)/2, height: collectionView.frame.size.height)
        } else if newsfeedDataInfo?.totalImages == "3" {
            switch indexPath.item {
            case 0:
                return CGSize(width: (collectionView.frame.size.width - 10)/2, height: collectionView.frame.size.height)
            default:
                return CGSize(width: (collectionView.frame.size.width - 10)/2, height: (collectionView.frame.size.height - 10)/2)
            }
        } else {
            return CGSize(width: (collectionView.frame.size.width - 10)/2, height: (collectionView.frame.size.height - 10)/2)
        }
    }
}
