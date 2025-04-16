//
//  SplashVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 21/06/23.
//

import UIKit

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        perform(#selector(nextVc), with: nil, afterDelay: 1.5)
       
    }
    @objc func nextVc(){
        performSegue(withIdentifier: AppSegue.loginSegue.getDescription, sender: nil)
    }
}
