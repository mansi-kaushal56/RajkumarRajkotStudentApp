//
//  HomeWorkDetailTblVCell.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 18/07/23.
//

import UIKit

class HomeWorkDetailTblVCell: UITableViewCell {
    @IBOutlet weak var subjectLbl: UILabel!
    @IBOutlet weak var dueDateLbl: UILabel!
    @IBOutlet weak var assignedDateLbl: UILabel!
    @IBOutlet weak var assignedByLbl: UILabel!
    @IBOutlet weak var despLbl: UILabel!
    @IBOutlet weak var homeworkImgView: UIImageView!
    @IBOutlet weak var homeworkImageCont: NSLayoutConstraint!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
