//
//  SwitchUserTblVCell.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 12/07/23.
//

import UIKit

class SwitchUserTblVCell: UITableViewCell {
    @IBOutlet weak var studentNameLbl: UILabel!
    @IBOutlet weak var classNameLbl: UILabel!
    @IBOutlet weak var admnNoLbl: UILabel!
    @IBOutlet weak var rollnoLbl: UILabel!
    @IBOutlet weak var relationLbl: UILabel!
    @IBOutlet weak var stImgView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
