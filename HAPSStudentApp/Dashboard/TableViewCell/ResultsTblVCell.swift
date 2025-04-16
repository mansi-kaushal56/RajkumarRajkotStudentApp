//
//  ResultsTblVCell.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 12/07/23.
//

import UIKit

class ResultsTblVCell: UITableViewCell {
    @IBOutlet weak var maxMarksLbl : UILabel!
    @IBOutlet weak var maxObtainedLbl : UILabel!
    @IBOutlet weak var classMaxLbl : UILabel!
    @IBOutlet weak var subjectLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
