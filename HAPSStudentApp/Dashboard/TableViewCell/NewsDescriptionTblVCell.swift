//
//  NewsDescriptionTblVCell.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 10/07/23.
//

import UIKit

class NewsDescriptionTblVCell: UITableViewCell {
    @IBOutlet weak var descriptionLbl : UILabel!
    @IBOutlet weak var newsImgView : UIImageView!
    @IBOutlet weak var newsHeadingLbl : UILabel!
    @IBOutlet weak var dateLbl : UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
