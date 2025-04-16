//
//  AssignmentsTblVCell.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 30/06/23.
//

import UIKit

class AssignmentsTblVCell: UITableViewCell {
    @IBOutlet weak var subjectLbl : UILabel!
    @IBOutlet weak var dueDateLbl : UILabel!
    @IBOutlet weak var assignedDateLbl : UILabel!
    @IBOutlet weak var assignedByLbl : UILabel!
    @IBOutlet weak var descriptionLbl : UILabel!
    @IBOutlet weak var assignmentImgView : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
