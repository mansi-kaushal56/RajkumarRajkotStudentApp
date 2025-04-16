//
//  IssuedBooksTblVCell.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 10/07/23.
//

import UIKit

class IssuedBooksTblVCell: UITableViewCell {
    @IBOutlet weak var accessnoLbl: UILabel!
    @IBOutlet weak var booktitleLbl: UILabel!
    @IBOutlet weak var issueDateLbl: UILabel!
    @IBOutlet weak var returndate: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
