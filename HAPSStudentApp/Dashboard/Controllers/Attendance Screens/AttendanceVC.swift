//
//  AttendanceVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 28/06/23.
//

import UIKit

class AttendanceVC: UIViewController {
    @IBOutlet weak var schoolNameLbl: UILabel?
    
    var titleArr = ["Overall Attendance","Monthly Attendance"]
    var imageArr = ["attendance","monthly-attendance"]

    override func viewDidLoad() {
        super.viewDidLoad()
        backBtn(title: "Attendance")
        schoolNameLbl?.text = "\(AppStrings.SchoolName.schoolName)\n\(UserDefaults.getUserDetail()?.branch_name ?? "")"
    }
}
extension AttendanceVC : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            performSegue(withIdentifier: AppSegue.overallAttendanceSegue.getDescription, sender: nil)
        } else {
            performSegue(withIdentifier: AppSegue.monthlyAttendanceSegue.getDescription, sender: nil)
        }
    }
    
}
extension AttendanceVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let attendanceCell = collectionView.dequeueReusableCell(withReuseIdentifier:AppCVCells.attendanceCVCell.getIdentifier , for: indexPath) as! AttendanceCVCell
        attendanceCell.imageView.image = UIImage(named: imageArr[indexPath.row])
        attendanceCell.titleLbl.text = titleArr[indexPath.row]
         return attendanceCell
    }
}
extension AttendanceVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 40)/1
        print(width)
        return CGSize(width: width, height: width - 150)
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
}
