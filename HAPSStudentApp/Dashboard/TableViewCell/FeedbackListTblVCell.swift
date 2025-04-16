//
//  FeedbackListTblVCell.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 07/07/23.
//

import UIKit

class FeedbackListTblVCell: UITableViewCell {
    @IBOutlet weak var datelbl : UILabel!
    @IBOutlet weak var feedbackLbl : UILabel!
    @IBOutlet weak var feedbackFromLbl : UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
