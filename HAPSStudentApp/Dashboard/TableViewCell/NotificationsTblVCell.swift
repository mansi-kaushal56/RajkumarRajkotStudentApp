//
//  NotificationsTblVCell.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 13/07/23.
//

import UIKit

class NotificationsTblVCell: UITableViewCell {
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var messagesLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
