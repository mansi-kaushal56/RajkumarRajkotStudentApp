//
//  DayAttendanceTblVCell.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 29/06/23.
//

import UIKit

class DayAttendanceTblVCell: UITableViewCell {
    @IBOutlet weak var dateLbl : UILabel!
    @IBOutlet weak var dayLbl : UILabel!
    @IBOutlet weak var attendLbl : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
