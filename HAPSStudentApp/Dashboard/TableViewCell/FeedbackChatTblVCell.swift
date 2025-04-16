//
//  FeedbackChatTblVCell.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 27/07/23.
//

import UIKit

class FeedbackChatTblVCell: UITableViewCell {
    @IBOutlet weak var nameAndDateLbl: UILabel!
    @IBOutlet weak var feedbackLbl: UILabel!
    @IBOutlet weak var attachmentBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
