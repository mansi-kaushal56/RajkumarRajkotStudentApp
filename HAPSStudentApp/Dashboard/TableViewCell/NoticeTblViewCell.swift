//
//  NoticeTblViewCell.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 24/06/23.
//

import UIKit
import WebKit

class NoticeTblViewCell: UITableViewCell {
    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var dateLbl : UILabel!
    @IBOutlet weak var attachmentsStackView: UIStackView!
    @IBOutlet weak var viewCircularView: UIView!
    @IBOutlet weak var viewAttachmentView: UIView!
    
   // viewCircularView
    

    override func awakeFromNib() {
        super.awakeFromNib()
        //webView?.navigationDelegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
//extension NoticeTblViewCell: WKNavigationDelegate {
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        self.webViewHeightConstraint.constant = webView.scrollView.contentSize.height
//
//    }
//}
