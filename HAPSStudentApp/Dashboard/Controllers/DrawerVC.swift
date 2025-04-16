//
//  DrawerVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 24/06/23.
//

import UIKit

struct DrawerItems {
    var id: String?
    var title: String?
    var image: String?
}
class DrawerVC: UIViewController {
    @IBOutlet weak var homeTblView :UITableView!
    @IBOutlet weak var stImgView: UIImageView!
    @IBOutlet weak var stnameLbl: UILabel!
    @IBOutlet weak var stclassnameLbl: UILabel!
    
    let drawerItemsList = [
        DrawerItems(id: "1", title: "My Profile", image: "studentprofile"),
        DrawerItems(id: "2", title: "Inbox", image: "inbox"),
        DrawerItems(id: "3", title: "Notice Board/Circular", image: "notice"),
        DrawerItems(id: "4", title: "Home Work", image: "homework"),
        DrawerItems(id: "5", title: "Attendance", image: "attendance"),
        DrawerItems(id: "6", title: "Request for Leave", image: "leave"),
        DrawerItems(id: "7", title: "Fee Ledger", image: "feeledger"),
        DrawerItems(id: "8", title: "Time Table", image: "timetable"),
        DrawerItems(id: "9", title: "Gallery", image: "gallery"),
        DrawerItems(id: "10", title: "Feedback/Suggestions", image: "feedback"),
        DrawerItems(id: "11", title: "Discipline", image: "discipline"),
        DrawerItems(id: "12", title: "News", image: "news")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLblData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppSegue.studentGallerySegue.getDescription {
            if let destinationVC = segue.destination as? StudentGalleryVC {
                destinationVC.type = .StudentGallery
            }
        }
    }
    private func setLblData(){
         stnameLbl.text = UserDefaults.getUserDetail()?.studentName
         stclassnameLbl.text = "Class - \(UserDefaults.getUserDetail()?.className ?? "") , \(UserDefaults.getUserDetail()?.sectionName ?? "")"
         let img = (UserDefaults.getUserDetail()?.studentImage ?? "")
         let imgUrl = URL(string: img)
         stImgView.kf.setImage(with: imgUrl)
     }
    @IBAction func switchUserBtn(_ sender:UIButton) {
        performSegue(withIdentifier: AppSegue.switchUserSegue.getDescription, sender: nil)
    }
}
extension DrawerVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch drawerItemsList[indexPath.row].id {
        case "1":
            performSegue(withIdentifier:AppSegue.profileSegue.getDescription, sender: nil)
        case "2":
            performSegue(withIdentifier:AppSegue.studentInboxSegue.getDescription, sender: nil)
        case "3":
            performSegue(withIdentifier:AppSegue.noticeSegue.getDescription, sender: nil)
        case "4":
            performSegue(withIdentifier: AppSegue.homeWorkSegue.getDescription, sender: nil)
        case "5":
            performSegue(withIdentifier: AppSegue.attendanceSegue.getDescription, sender: nil)
        case "6":
            performSegue(withIdentifier:AppSegue.leaveRequestSegue.getDescription, sender: nil)
        case "7":
            performSegue(withIdentifier:AppSegue.feeLedgerSegue.getDescription, sender: nil)
        case "8":
            performSegue(withIdentifier:AppSegue.timeTableSegue.getDescription, sender: nil)
        case "9":
            performSegue(withIdentifier:AppSegue.studentGallerySegue.getDescription, sender: nil)
        case "10":
            performSegue(withIdentifier:AppSegue.feedbackSuggestionSegue.getDescription, sender: nil)
        case "11":
            performSegue(withIdentifier:AppSegue.disciplineSegue.getDescription, sender: nil)
        case "12":
            performSegue(withIdentifier:AppSegue.newsSegue.getDescription, sender: nil)
            
        default:
            break
        }

    }
    
}
extension DrawerVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(drawerItemsList.count)
        return drawerItemsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let homeCell = tableView.dequeueReusableCell(withIdentifier: AppTblCells.homeCell.getIdentifier, for: indexPath) as! DrawerTblViewCell
        homeCell.drawerImgView.image = UIImage(named: drawerItemsList[indexPath.row].image ?? "")
        homeCell.drawerTitleLbl.text = drawerItemsList[indexPath.row].title
        
        return homeCell
    }
}
