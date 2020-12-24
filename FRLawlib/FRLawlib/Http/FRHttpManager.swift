//
//  FRHttpManager.swift
//  FRLawlib
//
//  Created by Lynn Hui on 2020/11/12.
//

import Foundation
import Alamofire

class FRHttpManager{
    static let shared = FRHttpManager()
    private init() { }
    
    func request(url:String, parameters:Dictionary<String, Any>, method: HTTPMethod, result: @escaping (_ data: responseObj) -> Void){
        print("【\(FRUtils.stringDate(date: Date(), formatter: "mm:ss"))】Request:\(url)\n\(parameters)")
        if ((UserDefaults().object(forKey: "token")) != nil) { self.httpHeader.add(name: "Access-Token", value: UserDefaults().object(forKey: "token") as! String) }
        AF.request(url, method: method, parameters: parameters, headers: self.httpHeader).responseJSON{ (response) in //
            print("【\(FRUtils.stringDate(date: Date(), formatter: "mm:ss"))】Response:\(String(describing: response.request?.url?.absoluteString))")
            self.handleResponse(data: response.data! as Data, result: result)
        }
    }
    
    func postBody(url:String, parameters: Any, method: HTTPMethod, result: @escaping (_ data: responseObj) -> Void){
        print("【\(FRUtils.stringDate(date: Date(), formatter: "mm:ss"))】Request:\(url)\n\(parameters)")
        if ((UserDefaults().object(forKey: "token")) != nil) { self.httpHeader.add(name: "Access-Token", value: UserDefaults().object(forKey: "token") as! String) }
        var request = URLRequest.init(url: URL.init(string: url)!)
        request.httpMethod = method.rawValue
        request.headers = self.httpHeader
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        if type(of: parameters) == String.self { request.httpBody = try! JSONEncoder().encode(parameters as! String) }
        if (type(of: parameters) == Dictionary<String, Any>.self || type(of: parameters) == Dictionary<String, String>.self) && JSONSerialization.isValidJSONObject(parameters) {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        }
        AF.request(request).responseJSON { (response) in
            print("【\(FRUtils.stringDate(date: Date(), formatter: "mm:ss"))】Response:\(String(describing: response.request?.url?.absoluteString))")
            self.handleResponse(data: response.data! as Data, result: result)
        }
    }
    
    func upload(url: String, file: Data, result: @escaping (_ data: responseObj) -> Void)  {
        let upload = AF.upload(multipartFormData: { (mutilPartData) in
            mutilPartData.append(file, withName: "file", fileName:"card.jpg", mimeType: "image/jpg/png/jpeg")
        }, to: url, usingThreshold: UInt64.init(), method: .post, headers: self.httpHeader, interceptor: nil, fileManager: FileManager())
        upload.responseJSON { (response) in
            print("【\(FRUtils.stringDate(date: Date(), formatter: "mm:ss"))】Response:\(String(describing: response.request?.url?.absoluteString))")
            self.handleResponse(data: response.data! as Data, result: result)
        }
//        AF.upload(file, to: URLConvertible as! URLConvertible)
    }
    
    private func handleResponse(data: Data, result: @escaping (_ data: responseObj) -> Void){
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        if (json != nil) {
            print(json!)
            if let jsonResult = json as? Dictionary<String,Any> {
                if jsonResult["code"] == nil { result(responseObj.init(json: ["code":0,"data":json as Any])!) }
                else { result(responseObj.init(json: jsonResult)!) } }
            else { result(responseObj.init(json: ["code":0,"data":json as Any])!) }
        } else {
            print(String(data: data, encoding: String.Encoding.utf8)!)
            result(responseObj.init(json: ["code": 404, "message": "Not found!"])!)
        }
    }
    
    func reset() { }
    
    lazy private var httpHeader: HTTPHeaders = {
        let headers: HTTPHeaders = [ "Content-Type": "application/json;charset=UTF-8", "User-Agent" : "banklaw/1.0.0 ios/14.2.0 iPhone 8", "X-App-Version": "1.0.0", "frontend": "1" ]
        return headers
    }()
}


struct responseObj {
    init?(json: [String: Any]) {
        self.code = json["code"] as? Int ?? -1
        self.data = json["data"] 
        self.message = json["message"] as? String ?? ""
    }
    
    let code: Int
    var data: (Any)? = nil
    let message: String
}
        
//func get(){
//    let urlStr:String = "https://api.banklaw.com.cn/course/online_uat/v1/courses/latest"
//    let parameters:Dictionary = ["size":"4","type":"1"]
//    request(url:urlStr,parameters: parameters,method: .get) { (data) in
//
//    }
//}
//
//func post(){
//    let urlStr:String = "https://api.banklaw.com.cn/course/online_uat/v1/courses/56054dc2a3064b069cb14db6b889a8ad/play_auth"
//    let parameters:Dictionary = ["timestamp":"1605267175","sign":"24dda7036c394443b90f24d5e7f2c663"]
//    request(url:urlStr,parameters: parameters,method: .post) { (data) in
//        let play = (data as! Dictionary<String, Any>).kj.model(FRCoursePlay.self)
//        print("auth:" + play.playAuth)
//    }
//}
//
//func body(){
//    self.httpHeader.add(name: "Access-Token", value: "2JmKlPHJRj6qiKvnbmwB9en8KtHE1xa1s4nfAkwCp14wOQspgB873qLpY5fUsczL")
//    let urlStr:String = "https://api.banklaw.com.cn/course/online_uat/v1/courses/report_offline_progress"
//    let parameters:Dictionary = ["listenProgressList":[["userId":"615516","beginTime":"2020-11-13 19:55:17","endTime":"2020-11-13 19:55:19","courseId":"56054dc2a3064b069cb14db6b889a8ad","startOffset":"1","endOffset":"2","identifier":"2ee35be3226242d68b49b87c397b2916","rowid":"2","progress":"0"]]]
//    AF.request(urlStr, method: .post, parameters: parameters, encoder: JSONParameterEncoder.prettyPrinted, headers: self.httpHeader).responseJSON { (response) in
//        print(response)
//    }
//}
