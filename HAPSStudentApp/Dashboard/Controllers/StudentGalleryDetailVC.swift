//
//  StudentGalleryDetailVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 13/07/23.
//

import UIKit
import ObjectMapper

class StudentGalleryDetailVC: UIViewController {
    var studentGalleryDetailObj: StudentGalleryDetailModel?
    var imageId: String?
    var categeryName: String?
    var type : ScreenType?
    
    @IBOutlet weak var categerynameLbl: UILabel!
    @IBOutlet weak var studentGalleryDetailCV: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if type == .StudentGalleryDetail {
            studentGalleryDetailAPI()
            backBtn(title: "Gallery Detail")
        } else if type == .ArtWorkDetail {
            artWorkDetailAPI()
            backBtn(title: "Art Work Detaill")
        } else {
            backBtn(title: "Class Gallery Detail")
            classGalleryDetailAPI()
        }
        
//        studentGalleryDetailAPI()
//        backBtn(title: "Gallery Detail")
        // Do any additional setup after loading the view.
    }
    
}
extension StudentGalleryDetailVC : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: AppStoryboards.dashboard.getDescription, bundle: .main)
        if let showImgVc = storyboard.instantiateViewController(withIdentifier: AppViewControllerID.showImgVC.getIdentifier) as? ShowImgVC {
            showImgVc.image = studentGalleryDetailObj?.studentGalleryDetailArr?[indexPath.row].image_name
            present(showImgVc, animated: true)
        }
    }
}
extension StudentGalleryDetailVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return studentGalleryDetailObj?.studentGalleryDetailArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let studentGalleryDetailCell = collectionView.dequeueReusableCell(withReuseIdentifier: AppCVCells.studentGalleryDetailCell.getIdentifier, for: indexPath) as! StudentGalleryDetailCVCell
        let imgs = (studentGalleryDetailObj?.studentGalleryDetailArr?[indexPath.row].image_name ?? "")
        let imgsUrl = URL(string: imgs)
        studentGalleryDetailCell.stImgView.kf.setImage(with:imgsUrl,placeholder: UIImage(named: "placeholderStImg") )
        return studentGalleryDetailCell
    }
    
    
}
extension StudentGalleryDetailVC {
    func  studentGalleryDetailAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(Base_Url)\(End_Points.Api_Student_Sub_Gallery.getEndpoints).php?image_id=\(imageId ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Student_Sub_Gallery.getEndpoints, apiRequestURL: strUrl)
    }
    func  artWorkDetailAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(Base_Url)\(End_Points.Api_Art_Images.getEndpoints).php?image_id=\(imageId ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Art_Images.getEndpoints, apiRequestURL: strUrl)
    }
    func  classGalleryDetailAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(Base_Url)\(End_Points.Api_Student_Sub_Class_Gallery.getEndpoints).php?class_id=\(UserDefaults.getUserDetail()?.class_id ?? "")&category_id=\(imageId ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Student_Sub_Class_Gallery.getEndpoints, apiRequestURL: strUrl)
    }
}
extension StudentGalleryDetailVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_Student_Sub_Gallery.getEndpoints {
            let status = response["status"] as! Int
            if status == 1 {
                if let  studentGalleryDetailDictData = Mapper<StudentGalleryDetailModel>().map(JSONObject: response) {
                    studentGalleryDetailObj = studentGalleryDetailDictData
                    print(studentGalleryDetailDictData)
                    DispatchQueue.main.async {
                        self.categerynameLbl.text = self.categeryName
                        self.studentGalleryDetailCV.reloadData()
                    }
                }
                CommonObjects.shared.stopProgress()
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.stopProgress()
                    CommonObjects.shared.showToast(message: AppMessages.MSG_NO_DATA_FOUND, controller: self)
                }
                
                
            }
        }
        if api == End_Points.Api_Art_Images.getEndpoints {
            let status = response["status"] as! Int
            if status == 1 {
                if let  studentGalleryDetailDictData = Mapper<StudentGalleryDetailModel>().map(JSONObject: response) {
                    studentGalleryDetailObj = studentGalleryDetailDictData
                    print(studentGalleryDetailDictData)
                    DispatchQueue.main.async {
                        self.categerynameLbl.text = self.categeryName
                        self.studentGalleryDetailCV.reloadData()
                    }
                }
                CommonObjects.shared.stopProgress()
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.stopProgress()
                    CommonObjects.shared.showToast(message: AppMessages.MSG_NO_DATA_FOUND, controller: self)
                }
            }
        }
        if api == End_Points.Api_Student_Sub_Class_Gallery.getEndpoints {
            let status = response["status"] as! Int
            if status == 1 {
                if let  studentGalleryDetailDictData = Mapper<StudentGalleryDetailModel>().map(JSONObject: response) {
                    studentGalleryDetailObj = studentGalleryDetailDictData
                    print(studentGalleryDetailDictData)
                    DispatchQueue.main.async {
                        self.categerynameLbl.text = self.categeryName
                        self.studentGalleryDetailCV.reloadData()
                    }
                }
                CommonObjects.shared.stopProgress()
            } else {
                DispatchQueue.main.async {
                    CommonObjects.shared.stopProgress()
                    CommonObjects.shared.showToast(message: AppMessages.MSG_NO_DATA_FOUND, controller: self)
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

