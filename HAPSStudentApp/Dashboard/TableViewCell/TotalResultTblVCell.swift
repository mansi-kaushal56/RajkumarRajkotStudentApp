//
//  TotalResultTblVCell.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 12/07/23.
//

import UIKit

class TotalResultTblVCell: UITableViewCell {
    @IBOutlet weak var totalmaxMarksLbl : UILabel!
    @IBOutlet weak var totalMaxObtainedLbl : UILabel!
    @IBOutlet weak var totalClassMaxLbl : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
