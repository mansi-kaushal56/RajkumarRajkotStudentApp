//
//  LibraryCategoriesVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 10/07/23.
//

import UIKit

class LibraryCategoriesVC: UIViewController {
    @IBOutlet weak var availableBooksImgView: UIImageView!
    @IBOutlet weak var issuedBooksImgView: UIImageView!
    @IBOutlet weak var returnedBooksImgView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Library Categories")
        // Do any additional setup after loading the view.
        let availableBooksTap = UITapGestureRecognizer()
        availableBooksImgView.addGestureRecognizer(availableBooksTap)
        availableBooksTap.addTarget(self, action: #selector(availableBooksTappped))
        
        let issuedBooksTap = UITapGestureRecognizer()
        issuedBooksImgView.addGestureRecognizer(issuedBooksTap)
        issuedBooksTap.addTarget(self, action: #selector(issuedBooksTappped))
        
        let returnedBooksTap = UITapGestureRecognizer()
        returnedBooksImgView.addGestureRecognizer(returnedBooksTap)
        returnedBooksTap.addTarget(self, action: #selector(returnedBooksTappped))
    }
    @objc func availableBooksTappped(sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: AppSegue.libBooksSegue.getDescription, sender: nil)
    }
    @objc func issuedBooksTappped(sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: AppSegue.issuedBooksSegue.getDescription, sender: nil)
    }
    @objc func returnedBooksTappped(sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: AppSegue.returnedBooksSegue.getDescription, sender: nil)
    }
}
