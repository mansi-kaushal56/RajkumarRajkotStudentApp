//
//  WebViewVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 29/11/23.
//

import UIKit
import WebKit

class WebViewVC: UIViewController {
    var desStr = ""
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "")
        webView?.loadHTMLString(desStr, baseURL: nil)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
