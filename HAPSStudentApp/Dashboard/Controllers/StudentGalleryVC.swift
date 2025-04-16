//
//  StudentGalleryVC.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 05/07/23.
//

import UIKit
import ObjectMapper
import Kingfisher

class StudentGalleryVC: UIViewController {
    var studentGalleryObj: StudentGalleryModel?
    @IBOutlet weak var studentGalleryCVCell: UICollectionView!
    var type: ScreenType?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if type == .StudentGallery {
            backBtn(title: "Gallery")
            studentGalleryAPI()
        } else if type == .ArtWorkGallery{
            backBtn(title: "Art Work")
            artWorkAPI()
        } else {
            backBtn(title: "Class Gallery")
            classGalleryAPI()
        }
//        print(type ?? "")
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppSegue.stGalleryDetailSegue.getDescription {
            if let destinationVC = segue.destination as? StudentGalleryDetailVC {
                destinationVC.imageId = studentGalleryObj?.studentGalleryArr?[sender as! Int].image_id
                destinationVC.categeryName = studentGalleryObj?.studentGalleryArr?[sender as! Int].categery_name
                destinationVC.type = .StudentGalleryDetail
            }
        }
        if segue.identifier == AppSegue.artWorkDetailSegue.getDescription {
            if let destinationVC = segue.destination as? StudentGalleryDetailVC {
                destinationVC.imageId = studentGalleryObj?.studentGalleryArr?[sender as! Int].image_id
                destinationVC.categeryName = studentGalleryObj?.studentGalleryArr?[sender as! Int].categery_name
                destinationVC.type = .ArtWorkDetail
            }
        }
        if segue.identifier == AppSegue.classGalleryDetailSegue.getDescription {
            if let destinationVC = segue.destination as? StudentGalleryDetailVC {
                destinationVC.imageId = studentGalleryObj?.studentGalleryArr?[sender as! Int].image_id
                destinationVC.categeryName = studentGalleryObj?.studentGalleryArr?[sender as! Int].categery_name
                destinationVC.type = .ClassGalleryDetail
            }
        }
    }
}

extension StudentGalleryVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch type {
        case .StudentGallery:
            performSegue(withIdentifier: AppSegue.stGalleryDetailSegue.getDescription, sender: indexPath.row)
        case .ArtWorkGallery:
            performSegue(withIdentifier: AppSegue.artWorkDetailSegue.getDescription, sender: indexPath.row)
        case .ClassGallery:
            performSegue(withIdentifier: AppSegue.classGalleryDetailSegue.getDescription, sender: indexPath.row)
        default:
            print("Unknown Type")
            break
        }
    }
    
}
extension StudentGalleryVC : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return studentGalleryObj?.studentGalleryArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let studentGalleryCell = collectionView.dequeueReusableCell(withReuseIdentifier: AppCVCells.studentGalleryCell.getIdentifier, for: indexPath) as! StudentGalleryCVCell
        let stGalleryData = studentGalleryObj?.studentGalleryArr?[indexPath.row]
        studentGalleryCell.categeryNameLbl.text = stGalleryData?.categery_name ?? ""
        studentGalleryCell.countLbl.text = "\(stGalleryData?.count ?? 0) Images"
        let imgs = (stGalleryData?.image ?? "")
        let imgsUrl = URL(string: imgs)
        studentGalleryCell.stImageView.kf.setImage(with:imgsUrl,placeholder: UIImage(named: "placeholderStImg") )
        return studentGalleryCell
    }
}

extension StudentGalleryVC {
    func  studentGalleryAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(Base_Url)\(End_Points.Api_Student_Gallery.getEndpoints).php?branch_id=\(UserDefaults.getUserDetail()?.branch_id ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Student_Gallery.getEndpoints, apiRequestURL: strUrl)
    }
    func  artWorkAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(Base_Url)\(End_Points.Api_Artwork.getEndpoints).php?branch_id=\(UserDefaults.getUserDetail()?.branch_id ?? "")&session_id=\(UserDefaults.getUserDetail()?.session_id ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Artwork.getEndpoints, apiRequestURL: strUrl)
    }
    func  classGalleryAPI() {
        CommonObjects.shared.showProgress()
        let strUrl = "\(Base_Url)\(End_Points.Api_Student_Class_Gallery.getEndpoints).php?branch_id=\(UserDefaults.getUserDetail()?.branch_id ?? "")&session_id=\(UserDefaults.getUserDetail()?.session_id ?? "")&class_id=\(UserDefaults.getUserDetail()?.class_id ?? "")"
        let obj = ApiRequest()
        obj.delegate = self
        obj.requestAPI(apiName: End_Points.Api_Student_Class_Gallery.getEndpoints, apiRequestURL: strUrl)
    }
}
extension StudentGalleryVC : RequestApiDelegate {
    func success(api: String, response: [String : Any]) {
        if api == End_Points.Api_Student_Gallery.getEndpoints {
            let status = response["status"] as! Int
            if status == 1 {
                if let switchUserDictData = Mapper<StudentGalleryModel>().map(JSONObject: response) {
                    studentGalleryObj = switchUserDictData
                    print(switchUserDictData)
                    DispatchQueue.main.async {
                        self.studentGalleryCVCell.reloadData()
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
        if api == End_Points.Api_Artwork.getEndpoints {
            let status = response["status"] as! Int
            if status == 1 {
                if let switchUserDictData = Mapper<StudentGalleryModel>().map(JSONObject: response) {
                    studentGalleryObj = switchUserDictData
                    print(switchUserDictData)
                    DispatchQueue.main.async {
                        self.studentGalleryCVCell.reloadData()
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
        if api == End_Points.Api_Student_Class_Gallery.getEndpoints {
            let status = response["status"] as! Int
            if status == 1 {
                if let switchUserDictData = Mapper<StudentGalleryModel>().map(JSONObject: response) {
                    studentGalleryObj = switchUserDictData
                    print(switchUserDictData)
                    DispatchQueue.main.async {
                        self.studentGalleryCVCell.reloadData()
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
            CommonObjects.shared.showToast(message: AppMessages.MSG_FAILURE_ERROR, controller: self)
        }
    }
}
