//
//  PocketMoneyTblCell.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 21/07/23.
//

import UIKit

class PocketMoneyTblCell: UITableViewCell {
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var billNoRecLbl: UILabel!
    @IBOutlet weak var particularLbl: UILabel!
    @IBOutlet weak var receivedLbl: UILabel!
    @IBOutlet weak var expensesLbl: UILabel!
    @IBOutlet weak var balanceLbl: UILabel!
    @IBOutlet weak var remarksLbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
