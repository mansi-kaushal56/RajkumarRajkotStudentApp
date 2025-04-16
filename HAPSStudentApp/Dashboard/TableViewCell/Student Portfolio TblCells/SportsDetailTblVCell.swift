//
//  SportsDetailTblVCell.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 01/07/23.
//

import UIKit

class SportsDetailTblVCell: UITableViewCell {
    
    @IBOutlet weak var imgLblView: UIView!
    @IBOutlet weak var imageSView: UIStackView!
    @IBOutlet weak var nameLbl : UILabel!
    @IBOutlet weak var admissionNoLbl : UILabel!
    @IBOutlet weak var yearLbl : UILabel!
    @IBOutlet weak var awardLbl : UILabel!
    @IBOutlet weak var levelLbl : UILabel!
    @IBOutlet weak var descriptionLbl : UILabel!
    @IBOutlet weak var activityLbl : UILabel!
    @IBOutlet weak var sportsImgView : UIImageView!
    @IBOutlet weak var categoryLbl : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
}
