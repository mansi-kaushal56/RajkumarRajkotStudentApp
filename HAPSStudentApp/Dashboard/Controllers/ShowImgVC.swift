//
//  ShowImgVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 03/07/23.
//

import UIKit
import Kingfisher

class ShowImgVC: UIViewController {
    
    @IBOutlet weak var sportsImgView : UIImageView!
    @IBOutlet weak var imgScrollView : UIScrollView!
    var image : String?
    private var imageView: UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        backBtn(title: "")
        let img = image ?? ""
        let imgurl = URL(string: img)
        sportsImgView.kf.setImage(with: imgurl)
        
    }
    @IBAction func backBtn(_ sender : UIButton) {
        dismiss(animated: true)
    }
    func setupScrollView() {
        imgScrollView.delegate = self
    }

}
extension ShowImgVC : UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return sportsImgView
    }
}
