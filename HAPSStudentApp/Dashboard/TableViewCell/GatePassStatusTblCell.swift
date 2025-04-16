//
//  GatePassStatusTblCell.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 27/12/23.
//

import UIKit

class GatePassStatusTblCell: UITableViewCell {

    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var dateFromLbl: UILabel!
    @IBOutlet weak var dateToLbl: UILabel!
    @IBOutlet weak var reasonLbl: UILabel!
    @IBOutlet weak var accompanyWithLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    //Vijay 03 Jan 2024 - populate the cell with didSet
    var gatePassStatusDetail: GatePassStatusRest? {
        didSet {
            statusLbl.layer.cornerRadius = 7
            statusLbl.clipsToBounds = true
            if gatePassStatusDetail?.status == "Pending" {
                statusLbl.backgroundColor = .AppYellow
            } else {
                statusLbl.backgroundColor = .AppGreen
            }
            statusLbl.text = gatePassStatusDetail?.status
            dateFromLbl.text = gatePassStatusDetail?.dateFrom
            dateToLbl.text = gatePassStatusDetail?.dateTo
            reasonLbl.text = gatePassStatusDetail?.reason
            accompanyWithLbl.text = gatePassStatusDetail?.accompany
        }
    }
    //Vijay End______
}
