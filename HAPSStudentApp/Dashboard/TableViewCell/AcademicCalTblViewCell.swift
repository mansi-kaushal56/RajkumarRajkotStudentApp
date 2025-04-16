//
//  AcademicCalTblViewCell.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 31/01/24.
//

import UIKit

class AcademicCalTblViewCell: UITableViewCell {

    @IBOutlet weak var createdDateLbl: UILabel!
    @IBOutlet weak var descriptionLbl : UILabel!
    @IBOutlet weak var academicCalendarView: UIView!
    @IBOutlet weak var academicCalendarImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var academicCalendarDetail: AcademicCalendarModelData? {
        didSet {
            createdDateLbl.text = "Updated on: \(academicCalendarDetail?.createdDate ?? "")"
            descriptionLbl.text = "\(academicCalendarDetail?.description ?? "")\nRKC Rajkot"
        }
    }

}
