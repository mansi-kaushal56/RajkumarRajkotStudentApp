//
//  StudentAppointmentTblVCell.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 11/07/23.
//

import UIKit

class StudentAppointmentTblVCell: UITableViewCell {
    
    @IBOutlet weak var apppointmentSView: UIStackView!
    @IBOutlet weak var lblstudentName: UILabel!
    @IBOutlet weak var admissionNoLbl: UILabel!
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var desLbl: UILabel!
    @IBOutlet weak var postLbl: UILabel!
    @IBOutlet weak var studentImgView: UIImageView!
    @IBOutlet weak var lblAndImageView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
