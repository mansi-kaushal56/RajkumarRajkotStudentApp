//
//  EventsTblVCell.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 07/07/23.
//

import UIKit

class EventsTblVCell: UITableViewCell {
    @IBOutlet weak var holidayNameLbl : UILabel!
    @IBOutlet weak var holidayEndDateLbl : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
