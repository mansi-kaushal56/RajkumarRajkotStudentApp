//
//  LibBooksTblVCell.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 14/07/23.
//

import UIKit

class LibBooksTblVCell: UITableViewCell {
    @IBOutlet weak var accNoLbl: UILabel!
    @IBOutlet weak var bookNameLbl: UILabel!
    @IBOutlet weak var authNameLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
