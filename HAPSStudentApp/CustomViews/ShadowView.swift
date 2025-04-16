//
//  ShadowView.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 22/06/23.
//

import Foundation
import UIKit


class ShadowView: UIImageView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 4, height: 4)
        layer.shadowRadius = 4
        layer.cornerRadius = 12
    }
}
class ShadowForView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0.25, height: 4)
        layer.shadowRadius = 5
        layer.cornerRadius = 12
        layer.masksToBounds = false
    }
}
class ShadowForUserView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.shadowOpacity = 0.9
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowColor = UIColor.AppCyan?.cgColor
        layer.shadowRadius = 1
        layer.borderWidth = 1
        layer.borderColor = UIColor.borderColor.cgColor
        layer.cornerRadius = 8
    }
}

@IBDesignable class PaddingLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 0
    @IBInspectable var bottomInset: CGFloat = 0
    @IBInspectable var leftInset: CGFloat = 16.0
    @IBInspectable var rightInset: CGFloat = 16.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}
