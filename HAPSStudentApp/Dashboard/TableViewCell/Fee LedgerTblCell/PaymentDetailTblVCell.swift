//
//  PaymentDetailTblVCell.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 29/07/23.
//

import UIKit

class PaymentDetailTblVCell: UITableViewCell {
    @IBOutlet weak var paymentModeLbl: UILabel!
    @IBOutlet weak var bankNameLbl: UILabel!
    @IBOutlet weak var chequeNoLbl: UILabel!
    @IBOutlet weak var chequeDateLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var totalPayableAmtLbl: UILabel!
    @IBOutlet weak var totalPaidAmtLbl: UILabel!
    @IBOutlet weak var totalOutstandingLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
