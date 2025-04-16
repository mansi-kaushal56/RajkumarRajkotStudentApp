//
//  MonthlyAttendanceTblVCell.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 28/06/23.
//

import UIKit

class MonthlyAttendanceTblVCell: UITableViewCell {
    @IBOutlet weak var monthLbl : UILabel!
    @IBOutlet weak var absentLbl : UILabel!
    @IBOutlet weak var totalClassesLbl : UILabel!
    @IBOutlet weak var presentLbl : UILabel!
    @IBOutlet weak var leaveLbl : UILabel!
    @IBOutlet weak var nextBtn : UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
