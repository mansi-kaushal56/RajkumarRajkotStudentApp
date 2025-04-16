//
//  APIRequests.swift
//  HAPSStudentApp
//
//  Created by Vijay Sharma on 21/06/23.
//

import Foundation
import UIKit

protocol RequestApiDelegate {
    func success(api:String, response : [String : Any])
    func failure()
}

class ApiRequest : NSObject {
    var delegate : RequestApiDelegate?
    func requestAPI(apiName : String, apiRequestURL : String) {
        guard let serviceUrl = URL(string: apiRequestURL) else { return }
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: [:], options: []) else {
            return
        }
        request.httpBody = httpBody
        request.timeoutInterval = 20
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let error = error {
                if let urlError = error  as? URLError, urlError.code == .notConnectedToInternet {
                    DispatchQueue.main.async {
                        CommonObjects.shared.stopProgress()
                        CommonObjects.shared.showToast(message: AppMessages.MSG_NO_INTERNET)
                    }
                } else if (error as NSError).code == NSURLErrorTimedOut {
                    DispatchQueue.main.async {
                        CommonObjects.shared.stopProgress()
                        CommonObjects.shared.showToast(message: AppMessages.MSG_TIME_OUT)
                    }
                } else {
                    DispatchQueue.main.async {
                        CommonObjects.shared.stopProgress()
                        CommonObjects.shared.showToast(message: AppMessages.MSG_FAILURE_ERROR)
                    }
                }
                
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    self.delegate?.success(api: apiName, response: json as! [String : Any])
                    CommonObjects.shared.stopProgress()
                    
                } catch {
                    print(error)
                    self.delegate?.failure()
                    CommonObjects.shared.stopProgress()
                }
            }
        }.resume()
    }
    func requestNativeImageUpload(apiName : String, image: UIImage?, parameters : [String : String]){
        CommonObjects.shared.showProgress()
        guard let url = URL(string: "\(Base_Url)\(apiName).php?") else { return }
        // guard let url = "\(Base_Url)\(End_Points.Api_Feedback_Submit.getEndpoints).php? else { return }
        let boundary = generateBoundary()
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = [
            "X-User-Agent": "ios",
            "Accept-Language": "en",
            "Accept": "application/json",
            "Content-Type": "multipart/form-data; boundary=\(boundary)",
        ]
        
        var dataBody = Data()
        if let mediaImage = Media(withImage: image, forKey: "file") {
            dataBody = createDataBody(withParameters: parameters, media: [mediaImage], boundary: boundary)
        } else {
            dataBody = createDataBody(withParameters: parameters, media: [], boundary: boundary)
        }
        request.httpBody = dataBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            CommonObjects.shared.stopProgress()
            if let response = response {
                print(response)
            }
            if let error = error {
                if let urlError = error  as? URLError {
                    if urlError.code == .notConnectedToInternet {
                        DispatchQueue.main.async {
                            CommonObjects.shared.stopProgress()
                            CommonObjects.shared.showToast(message: AppMessages.MSG_NO_INTERNET)
                        }
                    } else if (error as NSError).code == NSURLErrorTimedOut {
                        DispatchQueue.main.async {
                            CommonObjects.shared.stopProgress()
                            CommonObjects.shared.showToast(message: AppMessages.MSG_TIME_OUT)
                        }
                    } else {
                        DispatchQueue.main.async {
                            CommonObjects.shared.stopProgress()
                            CommonObjects.shared.showToast(message: AppMessages.MSG_FAILURE_ERROR)
                        }
                    }
                }
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    self.delegate?.success(api: apiName, response: json as! [String : Any])
                    CommonObjects.shared.stopProgress()
                    print(json)
                } catch {
                    print(error)
                    self.delegate?.failure()
                    CommonObjects.shared.stopProgress()
                }
            }
        }.resume()
    }
    
    
    func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    

}

func createDataBody(withParameters params: [String: String]?, media: [Media]?, boundary: String) -> Data {
    
    let lineBreak = "\r\n"
    var body = Data()
    
    if let parameters = params {
        for (key, value) in parameters {
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
            body.append("\(value + lineBreak)")
        }
    }
    
    if let media = media {
        for photo in media {
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.fileName)\"\(lineBreak)")
            body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
            body.append(photo.data)
            body.append(lineBreak)
        }
    }
    
    body.append("--\(boundary)--\(lineBreak)")
    
    return body
}
extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}

struct Media {
    let key: String
    let fileName: String
    let data: Data
    let mimeType: String
    
    init?(withImage image: UIImage?, forKey key: String) {
        self.key = key
        self.mimeType = "image/jpg"
        self.fileName = "\(arc4random()).jpeg"
        
        guard let data = image?.jpegData(compressionQuality: 0.5) else { return nil }
        self.data = data
    }
}

