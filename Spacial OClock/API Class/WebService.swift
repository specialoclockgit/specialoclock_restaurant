//
//  APIRequest.swift
//  AffroppleApp
//
//  Created by apple on 11/09/19.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD


struct WebService {
    
    static let boundary = "----WebKitFormBoundary7MA4YWxkTrZu0gW"
    
    static func service<Model: Codable>(_ api: API, urlAppendId: Any? = nil,form_urlencoded : Bool = false, param: Any? = nil, service: Services = .post ,showHud: Bool = true, response:@escaping (Model,Data,Any) -> Void)
    {
        if Reachability.isConnectedToNetwork()
        {
            if showHud
            {
                DispatchQueue.main.async {
                    if let vc = UIApplication.shared.keyWindow{
                        MBProgressHUD.showAdded(to: vc, animated: true)
                    }
                    
                }
            }
            
            var fullUrlString = baseURL + api.rawValue
            if let idApend = urlAppendId
            {
                fullUrlString = baseURL + api.rawValue + "/\(idApend)"
            }
            
            if service == .get{
                if let parm = param{
                    if parm is String{
                        fullUrlString.append("?")
                        fullUrlString += (parm as! String)
                    }else if parm is Dictionary<String, Any>{
                        fullUrlString += self.getString(from: parm as! Dictionary<String, Any>)
                    }else{
                        assertionFailure("Parameter must be Dictionary or String.")
                    }
                }
            }
            
            print(fullUrlString)
            guard let encodedString = fullUrlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else {return}
            var request = URLRequest(url: URL(string: encodedString)!, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 2000)
            
            request.httpMethod = service.rawValue
            
            if let authKey = Store.authKey
            {
                request.addValue("Bearer " + authKey, forHTTPHeaderField: "Authorization")
                print("authKey---\("Bearer " + authKey)")
                
            }
            
//            if (api == API.login ||  api == API.signup ) {
//                request.addValue("dfdf", forHTTPHeaderField: "deviceToken")
//                request.addValue("2", forHTTPHeaderField: "deviceType")
//            }
            
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue(securitykey, forHTTPHeaderField: "secret_key")
            request.addValue(publishedkey, forHTTPHeaderField: "publish_key")
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            if service == .delete {
                //   request.addValue("application/json", forHTTPHeaderField: "Accept")
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                if let param = param{
                    if param is String{
                        let postData = NSMutableData(data: (param as! String).data(using: String.Encoding.utf8)!)
                        request.httpBody = postData as Data
                    }else if param is Dictionary<String, Any>{
                        var parm = self.getString(from: param as! Dictionary<String, Any>)
                        //print(parm)
                        parm.removeFirst()
                        let postData = NSMutableData(data: parm.data(using: String.Encoding.utf8)!)
                        request.httpBody = postData as Data
                    }
                }
            }
            
            if service == .put || service == .post{
                //request.addValue("application/json", forHTTPHeaderField: "Accept")
                if form_urlencoded == true {
                    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                    if let param = param{
                        if param is String{
                            let postData = NSMutableData(data: (param as! String).data(using: String.Encoding.utf8)!)
                            request.httpBody = postData as Data
                        }else if param is Dictionary<String, Any>{
                            var parm = self.getString(from: param as! Dictionary<String, Any>)
                            //print(parm)
                            parm.removeFirst()
                            let postData = NSMutableData(data: parm.data(using: String.Encoding.utf8)!)
                            request.httpBody = postData as Data
                        }
                    }
                    
                }else {
                    
                    if let parameter = param{
                        if parameter is String{
                            request.httpBody = (parameter as! String).data(using: .utf8)
                        }else if parameter is Dictionary<String, Any>{
                            var body = Data()
                            for (key, Value) in parameter as! Dictionary<String, Any>{
                                //print(key,Value)
                                if let imageInfo = Value as? ImageStructInfo{
                                    body.append("--\(boundary)\r\n")
                                    body.append("Content-Disposition: form-data; name=\"\(imageInfo.key)\"; filename=\"\(imageInfo.fileName)\"\r\n")
                                    body.append("Content-Type: \(imageInfo.file_type)\r\n\r\n")
                                    body.append(imageInfo.data)
                                    body.append("\r\n")
                                    request.httpBody = body
                                    
                                }
                                else if let images = Value as? [ImageStructInfo]{
                                    for value in images{
                                        body.append("--\(boundary)\r\n")
                                        body.append("Content-Disposition: form-data; name=\"\(value.key)\"; filename=\"\(value.fileName)\"\r\n")
                                        body.append("Content-Type: \(value.file_type)\r\n\r\n")
                                        body.append(value.data)
                                        body.append("\r\n")
                                        request.httpBody = body
                                    }
                                }else{
                                    body.append("--\(boundary)\r\n")
                                    body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                                    body.append("\(Value)\r\n")
                                }
                            }
                            body.append("--\(boundary)--\r\n")
                            request.httpBody = body
                            
                            
                        }else{
                            assertionFailure("Parameter must be Dictionary or String.")
                        }
                    }
                }
            }
            
            let sessionConfiguration = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfiguration)
            
            session.dataTask(with: request) { (data, jsonResponse, error) in
                if showHud{
                    DispatchQueue.main.async {
                        if let vc = UIApplication.shared.keyWindow{
                            MBProgressHUD.hide(for: vc, animated: true)
                        }
                    }
                }
                
                if error != nil{
                    WebService.showAlert(error!.localizedDescription)
                }else{
                    if let jsonData = data{
                        do{
                            let jsonSer = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! [String: Any]
                            print(jsonSer)
                            let codeInt = jsonSer["code"] as? Int ?? 0
                           
                            var code = "\(codeInt)"
                            
//                            if let httpResponse = jsonResponse as? HTTPURLResponse {
//                                print("statusCode: \(httpResponse.statusCode)")
////                                if api == API.imageUplaod {
////                                    code = "\(httpResponse.statusCode)"
////                                }
//                            }
                            if code == "401"{
                                DispatchQueue.main.async {
                                    if UIApplication.shared.isRegisteredForRemoteNotifications
                                    {
                                        UIApplication.shared.unregisterForRemoteNotifications()
                                        UIApplication.shared.registerForRemoteNotifications()
                                    }
//                                    Store.userDetails = nil
//                                    Store.autoLogin = false
//                                    let mainStoryBoard = UIStoryboard(name: "Login", bundle: nil)
//                                    let redViewController = mainStoryBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
//                                    let nav = UINavigationController.init(rootViewController: redViewController)
//                                    nav.isNavigationBarHidden = true
//                                    UIApplication.shared.windows.first?.rootViewController = nav
                                }
                                
                            }
                            else if code != "200" {
                                
                                
                                    DispatchQueue.main.async {
                                        if let errorMessage = jsonSer["msg"] as? String{
                                            if errorMessage == "Unauthenticated."
                                            {
//                                                Store.userDetails = nil
                                             //  Store.autoLogin = false
                                                
                                                //                                                applicationDelegate.setUpLogin()
                                            }
                                            else
                                            {
                                                if errorMessage != "Data not found"
                                                {
                                                    WebService.showAlert(errorMessage)
                                                }
                                            }
                                        }else if let message = jsonSer["message"] as? String{
                                            
                                            if message == "Unauthenticated."
                                            {
                                                //Store.userDetails = nil
                                              //  Store.autoLogin = false
                                                //                                                applicationDelegate.setUpLogin()
                                            }
                                            else
                                            {
                                                if message != "Data not found"
                                                {
                                                    WebService.showAlert(message)
                                                }
                                        }
                                    }
                                }
                                

                                
                            }else{
                                let decoder = JSONDecoder()
                                let model = try decoder.decode(Model.self, from: jsonData)
                                DispatchQueue.main.async {
                                    response(model,jsonData,jsonSer)
                                }
                            }
                        }catch let err{
                            print(err)
                            WebService.showAlert(err.localizedDescription)
                        }
                    }
                }
            }.resume()
        }
        else
        {
            self.showAlert(noInternetConnection)
        }
    }
    
    private static func showAlert(_ message: String){
        DispatchQueue.main.async {
            CommonUtilities.shared.showAlert(message: message, isSuccess: .error)
        }
    }
    
    
    private static func getString(from dict: Dictionary<String,Any>) -> String{
        var stringDict = String()
        stringDict.append("?")
        for (key, value) in dict{
            let param = key + "=" + "\(value)"
            stringDict.append(param)
            stringDict.append("&")
        }
        stringDict.removeLast()
        return stringDict
    }
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8){
            append(data)
        }
    }
}

extension UIImage{
    func toData() -> Data{
        return self.jpegData(compressionQuality: 0.5)!
    }
    func isEqualToImage(image: UIImage) -> Bool
    {
        let data1: Data = self.pngData()!
        let data2: Data = image.pngData()!
        return data1 == data2
    }
}

struct ImageStructInfo {
    var fileName: String
    var file_type: String = "image/jpg"
    var data: Data
    var key:String
    var image: UIImage
}
