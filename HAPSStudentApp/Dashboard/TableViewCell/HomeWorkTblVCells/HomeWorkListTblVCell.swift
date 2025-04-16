//
//  HomeWorkListTblVCell.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 18/07/23.
//

import UIKit

class HomeWorkListTblVCell: UITableViewCell {

    @IBOutlet weak var assignedDateLbl: UILabel!
    @IBOutlet weak var assignedByLbl: UILabel!
    @IBOutlet weak var dueDateLbl: UILabel!
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
