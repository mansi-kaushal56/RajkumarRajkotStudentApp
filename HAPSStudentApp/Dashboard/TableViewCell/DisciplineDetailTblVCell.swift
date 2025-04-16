//
//  DisciplineDetailTblVCell.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 05/07/23.
//

import UIKit

class DisciplineDetailTblVCell: UITableViewCell {
    @IBOutlet weak var dateLbl : UILabel!
    @IBOutlet weak var parameterLbl : UILabel!
    @IBOutlet weak var givenByLbl : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
