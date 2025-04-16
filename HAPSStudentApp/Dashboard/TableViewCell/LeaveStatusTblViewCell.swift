//
//  LeaveStatusTblViewCell.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 27/06/23.
//

import UIKit

class LeaveStatusTblViewCell: UITableViewCell {
    @IBOutlet weak var statusLbl : UILabel!
    @IBOutlet weak var statusView : UIView!
    @IBOutlet weak var leaveStatusView : UIView!
    @IBOutlet weak var leaveStatusDateFromLbl : UILabel!
    @IBOutlet weak var leaveStatusDateToLbl : UILabel!
    @IBOutlet weak var leaveStatusReasonLbl : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
