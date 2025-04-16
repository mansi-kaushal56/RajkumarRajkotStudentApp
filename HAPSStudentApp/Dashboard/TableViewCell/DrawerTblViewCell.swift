//
//  DrawerTblViewCell.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 26/06/23.
//

import UIKit

class DrawerTblViewCell: UITableViewCell {
    @IBOutlet weak var drawerImgView : UIImageView!
    @IBOutlet weak var drawerTitleLbl : UILabel!
    @IBOutlet weak var nextBtn : UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
