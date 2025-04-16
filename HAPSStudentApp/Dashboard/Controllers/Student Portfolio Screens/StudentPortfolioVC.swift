//
//  StudentPortfolioVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 01/07/23.
//

import UIKit
import Kingfisher

class StudentPortfolioVC: UIViewController {
    @IBOutlet weak var studentNameLbl: UILabel!
    @IBOutlet weak var studentClassName : UILabel!
    @IBOutlet weak var studentImgView : UIImageView!
    var imgArr = ["sportsDetailIcon","activityDetailIcon","studentCouncilIcon"]
    var titleArr = ["Sports Detail","Activity Detail","Student Council"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setLblData()
        backBtn(title: "Student Portfolio")
        // Do any additional setup after loading the view.
    }
    func setLblData() {
        let img = (UserDefaults.getUserDetail()?.studentImage ?? "")
        let imgUrl = URL(string: img)
        studentImgView.kf.setImage(with: imgUrl,placeholder: UIImage.studentImg)
        studentNameLbl.text = UserDefaults.getUserDetail()?.studentName
        studentClassName.text = "Class - \(UserDefaults.getUserDetail()?.className ?? "") \(UserDefaults.getUserDetail()?.sectionName ?? "")"
        
    }
    
}
extension StudentPortfolioVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row  == 0 {
            performSegue(withIdentifier: AppSegue.sportsDetailSegue.getDescription, sender: nil)
        }
        else if indexPath.row == 1 {
            performSegue(withIdentifier: AppSegue.activityDetailsSegue.getDescription, sender: nil)
        } else {
            performSegue(withIdentifier: AppSegue.appointmentEntrySegue.getDescription, sender: nil)
        }
    }
}
extension StudentPortfolioVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let portfolioCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.portfolioCell.getIdentifier, for: indexPath) as! StudentPostfolioTblVCell
        portfolioCell.titleLbl.text = titleArr[indexPath.row]
        portfolioCell.imgView.image = UIImage(named: imgArr[indexPath.row] )
        return portfolioCell
    }
    
    
}
