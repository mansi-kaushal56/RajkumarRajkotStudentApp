//
//  PeriodsTblVCell.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 12/07/23.
//

import UIKit

class PeriodsTblVCell: UITableViewCell {
    @IBOutlet weak var periodsNameLbl: UILabel!
    @IBOutlet weak var periodsTimeLbl: UILabel!
    @IBOutlet weak var periodsview: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
