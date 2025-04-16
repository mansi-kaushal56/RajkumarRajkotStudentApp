//
//  FeeDetailTblVCell.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 28/07/23.
//

import UIKit

class FeeDetailTblVCell: UITableViewCell {
    
    @IBOutlet weak var particularLbl: UILabel!
    @IBOutlet weak var payableAmtLbl: UILabel!
    @IBOutlet weak var preAmtLbl: UILabel!
    @IBOutlet weak var currAmtLbl: UILabel!
    @IBOutlet weak var paidAmtLbl: UILabel!
    @IBOutlet weak var outstndAmtLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
