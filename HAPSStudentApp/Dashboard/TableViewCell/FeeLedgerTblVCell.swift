//
//  FeeLedgerTblVCell.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 07/07/23.
//

import UIKit

class FeeLedgerTblVCell: UITableViewCell {
    @IBOutlet weak var receiptNoLbl : UILabel!
    @IBOutlet weak var paydateLbl : UILabel!
    @IBOutlet weak var amountLbl : UILabel!
    @IBOutlet weak var payModeLbl : UILabel!
    @IBOutlet weak var receiptView: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
