//
//  GatePassSelectionVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 27/12/23.
//

import UIKit

class GatePassSelectionVC: UIViewController {

    @IBOutlet weak var gatePassSelectionTblView: UITableView!
    @IBOutlet weak var studentImgView: UIImageView!
    @IBOutlet weak var studentNameLbl: UILabel!
    @IBOutlet weak var studentClassNameLbl: UILabel!
    
    var titleArr = ["Apply Gate Pass","View Status "]
    var imgArr = ["gatePassImg","leavestatus"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLblData()
        backBtn(title: "Gate Pass")
        // Do any additional setup after loading the view.
    }
    func setLblData() {
        let img = (UserDefaults.getUserDetail()?.studentImage ?? "")
        let imgUrl = URL(string: img)
        studentImgView.kf.setImage(with: imgUrl,placeholder: UIImage.studentImg)
        studentNameLbl.text = UserDefaults.getUserDetail()?.studentName
        studentClassNameLbl.text = "Class - \(UserDefaults.getUserDetail()?.className ?? "") \(UserDefaults.getUserDetail()?.sectionName ?? "")"
        
    }
}
extension GatePassSelectionVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row  == 0 {
            performSegue(withIdentifier: AppSegue.applyGatePassSegue.getDescription, sender: nil)
        }
        if indexPath.row == 1 {
            performSegue(withIdentifier: AppSegue.gatePassStatusSegue.getDescription, sender: nil)
        }
    }
}
extension GatePassSelectionVC : UITableViewDataSource {
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
