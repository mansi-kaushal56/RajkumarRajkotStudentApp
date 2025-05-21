//
//  DashboardVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 22/06/23.
//

import UIKit
import Kingfisher
import ObjectMapper

class DashboardVC: UIViewController {
    
    @IBOutlet weak var studentNameLbl : UILabel!
    @IBOutlet weak var classNameLbl : UILabel!
    @IBOutlet weak var admissionNoLbl : UILabel!
    @IBOutlet weak var dayLbl : UILabel!
    @IBOutlet weak var studentImgView : UIImageView!
    @IBOutlet weak var studentDetailView : UIView!
    
    var wedsiteurl : String?
    var updateLoginObj: UserModel?
    var timeTableDayObj : TimetableDateModel?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Dashboard"
        
        updateLoginAPI()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppSegue.studentGallerySegue.getDescription {
            if let destinationVC = segue.destination as? StudentGalleryVC {
                destinationVC.type = .StudentGallery
            }
        }
        if segue.identifier == AppSegue.studentArtWorkSegue.getDescription {
            if let destinationVC = segue.destination as? StudentGalleryVC {
                destinationVC.type = .ArtWorkGallery
            }
        }
        if segue.identifier == AppSegue.classGallerySegue.getDescription {
            if let destinationVC = segue.destination as? StudentGalleryVC {
                destinationVC.type = .ClassGallery
            }
        }
        if segue.identifier == AppSegue.academicCalenderSegue.getDescription {
            if let destinationVC = segue.destination as? AcademicCalendarVC {
                destinationVC.type = .AcademicCalendar
            }
        }
        if segue.identifier == AppSegue.bookListSegue.getDescription {
            if let destinationVC = segue.destination as? AcademicCalendarVC {
                destinationVC.type = .BooksList
            }
        }
        
    }

}
extension DashboardVC : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch dashboardItemList[indexPath.row].id {
        case "1":
            performSegue(withIdentifier: AppSegue.noticeSegue.getDescription, sender: nil)
        case "2":
            performSegue(withIdentifier: AppSegue.studentInboxSegue.getDescription, sender: nil)
        case "3":
            performSegue(withIdentifier: AppSegue.attendanceSegue.getDescription, sender: nil)
        case "4":
            performSegue(withIdentifier: AppSegue.homeWorkSegue.getDescription, sender: nil)
//        case "5":
//            performSegue(withIdentifier: AppSegue.assignmentsSegue.getDescription, sender: nil)
        case "6":
            performSegue(withIdentifier: AppSegue.timeTableSegue.getDescription, sender: nil)
//        case "7":
//            performSegue(withIdentifier: AppSegue.leaveRequestSegue.getDescription, sender: nil)
//        case "8":
//            performSegue(withIdentifier: AppSegue.leaveStatusSegue.getDescription, sender: nil)
        case "9":
            performSegue(withIdentifier: AppSegue.resultSegue.getDescription, sender: nil)
        case "10":
            performSegue(withIdentifier: AppSegue.reportCardSegue.getDescription, sender: nil)
//        case "11":
//            performSegue(withIdentifier: AppSegue.feedbackSuggestionSegue.getDescription, sender: nil)
//        case "12":
//
//            wedsiteurl = "https://www.dukeinfosys.com/rajkumar/student/"
//            print(wedsiteurl ?? "")
//            openWebView(urlSting:wedsiteurl ?? "" , viewController: self)
//        case "13":
//            performSegue(withIdentifier: AppSegue.feeLedgerSegue.getDescription, sender: nil)
        case "14":
            performSegue(withIdentifier: AppSegue.studentPortfolioSegue.getDescription, sender: nil)
        case "15":
            performSegue(withIdentifier: AppSegue.disciplineSegue.getDescription, sender: nil)
        case "16":
            performSegue(withIdentifier: AppSegue.librarySegue.getDescription, sender: nil)
        case "17":
            performSegue(withIdentifier: AppSegue.schoolCalenderSegue.getDescription, sender: nil)
        case "18":
            performSegue(withIdentifier: AppSegue.studentGallerySegue.getDescription, sender: nil)
        case "19":
            performSegue(withIdentifier: AppSegue.studentArtWorkSegue.getDescription, sender: nil)
        case "20":
            wedsiteurl = "https://rkcrajkot.com/"
            openWebView(urlSting: wedsiteurl ?? "", viewController: self)
            
//            if UserDefaults.getUserDetail()?.branch_name == "Hiranagar" {
//                wedsiteurl = "https://www.haps.co.in/"
//                print(wedsiteurl ?? "")
//                openWebView(urlSting: wedsiteurl ?? "", viewController: self)
//            } else {
//                wedsiteurl = "https://www.himacademy.com/"
//                openWebView(urlSting: wedsiteurl ?? "", viewController: self)
//            }
        case "21":
            performSegue(withIdentifier: AppSegue.newsSegue.getDescription, sender: nil)
//        case "22":
//            performSegue(withIdentifier: AppSegue.pocketMoneySegue.getDescription, sender: nil)
        case "23":
            performSegue(withIdentifier: AppSegue.academicCalenderSegue.getDescription, sender: indexPath.row)
        case "24":
            performSegue(withIdentifier: AppSegue.bookListSegue.getDescription, sender: indexPath.row)
        case "25":
            performSegue(withIdentifier: AppSegue.classGallerySegue.getDescription, sender: indexPath.row)
//        case "26":
//            performSegue(withIdentifier: AppSegue.gatePassSegue.getDescription, sender: nil)
            
        default:
            break
        }
    }
}
extension DashboardVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dashboardItemList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let homeCell = collectionView.dequeueReusableCell(withReuseIdentifier: AppCVCells.homeCVCell.getIdentifier, for: indexPath) as! HomeCViewCell
        homeCell.homeImgView.image = UIImage(named:dashboardItemList[indexPath.row].image ?? "")
        homeCell.bgview.layer.shadowColor = UIColor.black.cgColor
        homeCell.homeNameLbl.text = dashboardItemList[indexPath.row].title
        return homeCell
    }
}

extension DashboardVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.frame.size.width - 30)/4
        return CGSize(width: width, height: width + 60 )
    }
}

extension DashboardVC  {
    
    func timetableDayAPI(){
        CommonObjects.shared.showProgress()
        let strUrl = "\(Base_Url)\(End_Points.Api_Timetable_day.getEndpoints).php?BranchId=\( UserDefaults.getUserDetail()?.branch_id ?? "")&Session=\(UserDefaults.getUserDetail()?.session_id ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Timetable_day.getEndpoints, apiRequestURL: strUrl)
    }
    
    func updateLoginAPI(){
        CommonObjects.shared.showProgress()
        let strUrl = "\(Base_Url)\(End_Points.Api_Update_login.getEndpoints).php?enroll_no=\( UserDefaults.getUserDetail()?.enrollNo ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Update_login.getEndpoints, apiRequestURL: strUrl)
    }
}
extension DashboardVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_Timetable_day.getEndpoints {
            let status = response["status"] as! String
            let msg = response["msg"] as! String
            if status == "true" {
                if let userModelDictData = Mapper<TimetableDateModel>().map(JSONObject: response) {
                    timeTableDayObj = userModelDictData
                    print(userModelDictData)
                    DispatchQueue.main.async {
                        self.dayLbl.text = self.timeTableDayObj?.dayid
                    }
                }
                CommonObjects.shared.stopProgress()
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.stopProgress()
                    CommonObjects.shared.showToast(message: msg, controller: self)
                }
            }
        }
        if api == End_Points.Api_Update_login.getEndpoints {
            let status = response["status"] as! Bool
            let msg = response["msg"] as! String
            if status == true {
                if let updateLoginDictData = Mapper<UserModel>().map(JSONObject: response) {
                    updateLoginObj = updateLoginDictData
                    print(updateLoginDictData)
                    UserDefaults.removeAppData()
                    UserDefaults.setUserDetail(updateLoginDictData)
                }
                CommonObjects.shared.stopProgress()
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.stopProgress()
                    CommonObjects.shared.showToast(message: msg, controller: self)
                }
            }
        }
    }
    
    func failure() {
        DispatchQueue.main.async {
            CommonObjects.shared.stopProgress()
            CommonObjects.shared.showToast(message: AppMessages.MSG_FAILURE_ERROR, controller: self)
        }
    }
}
