//
//  ActivityDetailTblVCell.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 03/07/23.
//

import UIKit

class ActivityDetailTblVCell: UITableViewCell {
    @IBOutlet weak var imgLblAndImgView: UIView!
    @IBOutlet weak var actStackView: UIStackView!
    @IBOutlet weak var nameLbl : UILabel!
    @IBOutlet weak var admissionNoLbl : UILabel!
    @IBOutlet weak var yearLbl : UILabel!
    @IBOutlet weak var levelLbl : UILabel!
    @IBOutlet weak var descriptionLbl : UILabel!
    @IBOutlet weak var activityLbl : UILabel!
    @IBOutlet weak var activityImgView : UIImageView!
    @IBOutlet weak var categoryLbl : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
