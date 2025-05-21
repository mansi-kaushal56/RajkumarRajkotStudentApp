//
//  StudentInboxDetailTblVCell.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 04/07/23.
//

import UIKit

class StudentInboxDetailTblVCell: UITableViewCell {
    @IBOutlet weak var attachmentView: UIView!
    @IBOutlet weak var despLbl : UILabel!
    @IBOutlet weak var dateLbl : UILabel!
    @IBOutlet weak var schoolLbl : UILabel!
    @IBOutlet weak var msgImg : UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
