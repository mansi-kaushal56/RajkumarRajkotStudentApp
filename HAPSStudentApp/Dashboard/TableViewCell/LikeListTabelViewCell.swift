//
//  LikeListTabelViewCell.swift
//  HAPSStudentApp
//
//  Created by Raj Mohan on 28/06/24.
//

import UIKit

class LikeListTabelViewCell: UITableViewCell {

    @IBOutlet weak var studentClassRollNo: UILabel!
    @IBOutlet weak var studentName: UILabel!
    @IBOutlet weak var studentImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
