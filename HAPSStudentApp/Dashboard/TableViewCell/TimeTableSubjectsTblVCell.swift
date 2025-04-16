//
//  TimeTableSubjectsTblVCell.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 19/07/23.
//

import UIKit

class TimeTableSubjectsTblVCell: UITableViewCell {
    
//    @IBOutlet weak var teacher1Lbl: UILabel!
//    @IBOutlet weak var teacher2Lbl: UILabel!
//    @IBOutlet weak var teacher3Lbl: UILabel!
//    @IBOutlet weak var teacher4Lbl: UILabel!
//    @IBOutlet weak var teacher5Lbl: UILabel!
//    @IBOutlet weak var teacher6Lbl: UILabel!
    @IBOutlet weak var sub1Lbl: UILabel!
    @IBOutlet weak var sub2Lbl: UILabel!
    @IBOutlet weak var sub3Lbl: UILabel!
    @IBOutlet weak var sub4Lbl: UILabel!
    @IBOutlet weak var sub5Lbl: UILabel!
    @IBOutlet weak var sub6Lbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
