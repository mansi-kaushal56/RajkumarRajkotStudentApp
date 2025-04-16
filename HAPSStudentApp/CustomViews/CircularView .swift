//
//  CircularView .swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 23/06/23.
//

import Foundation
import UIKit

class CircularView: UIImageView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.masksToBounds = true
        layer.cornerRadius = self.frame.size.height / 2
        layer.borderColor = UIColor.white.cgColor
        //clipsToBounds = true
    }
}

class BoarderView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.borderWidth = 1
        layer.borderColor = UIColor.borderColor.cgColor
        layer.cornerRadius = 5
        //clipsToBounds = true
    }
}

class BoarderImgView: UIImageView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.borderWidth = 1
        layer.borderColor = UIColor.borderColor.cgColor
        layer.cornerRadius = 4
        //clipsToBounds = true
    }
}
class LblBoarder: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.borderWidth = 1
        layer.borderColor = UIColor.borderColor.cgColor
        //layer.cornerRadius = 4
        //clipsToBounds = true
    }
}
