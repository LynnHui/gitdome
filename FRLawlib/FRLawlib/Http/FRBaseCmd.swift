//
//  FRBaseCmd.swift
//  FRLawlib
//
//  Created by Lynn Hui on 2020/11/20.
//

import Foundation
import Alamofire

class FRBaseCmd: NSObject {
    var isHud: Bool = false
    var method: HTTPMethod = .post
    var methodName: String = ""
    
    required override init(){ }
    
    func request(paramter: Dictionary<String, Any>, callBack: @escaping (_ data: (Any)?) -> Void) {
        if self.isHud { SVProgressHUD.show() }
        FRHttpManager.shared.request(url: self.methodName, parameters: paramter, method: self.method) { (result) in
            if self.isHud { SVProgressHUD.dismiss() }
            if result.code == 0 || result.code == -1793 { callBack(result.data) }
            else if result.code == 403 { AppDelegate.showText("登录失败") }
            else { AppDelegate.showText(result.message) }
        }
    }
    func postBody(paramter: Any, callBack: @escaping (_ data: (Any)?) -> Void) {
        if self.isHud { SVProgressHUD.show() }
        FRHttpManager.shared.postBody(url: self.methodName, parameters: paramter, method: self.method) { (result) in
            if self.isHud { SVProgressHUD.dismiss() }
            if result.code == 0 || result.code == -1793 { callBack(result.data) }
            else if result.code == 403 { AppDelegate.showText("登录失败") }
            else { AppDelegate.showText(result.message) }
        }
    }
    
    func upload(file: Data, callBack: @escaping (_ data: (Any)?) -> Void) {
        if self.isHud { SVProgressHUD.show() }
        FRHttpManager.shared.upload(url: self.methodName, file: file) { (result) in
            if self.isHud { SVProgressHUD.dismiss() }
            if result.code == 0 || result.code == -1793 { callBack(result.data) }
            else if result.code == 403 { AppDelegate.showText("登录失败") }
            else { AppDelegate.showText(result.message) }
        }
    }
    
}
//- (void)doRequestWithParameters:(id)parameters Result:(void(^)(id))result Error:(void(^)(id))error{
//    if (self.HUD && !self.group) [SVProgressHUD show];
//    __weak typeof(self) weakSelf = self;
//    if (self.group) dispatch_group_enter(self.group);
//    [[FRHttpManager sharedHttpManager] request:self.methodName type:self.method parameters:parameters fileData:nil success:^(id reaultObj) {
//        if (self.HUD && !self.group && [SVProgressHUD isVisible]) [SVProgressHUD dismiss];
//        if (result) result(reaultObj);
//        if (weakSelf.group) dispatch_group_leave(weakSelf.group);
//    } failure:^(NSError *err){
//        [self handleError:err handler:error];
//        if (weakSelf.group) dispatch_group_leave(weakSelf.group);
//    }];
//}
