//
//  StudentPostfolioTblVCell.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 01/07/23.
//

import UIKit

class StudentPostfolioTblVCell: UITableViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var imgView : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
