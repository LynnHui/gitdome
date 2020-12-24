//
//  GitCmd.swift
//  FRLawlib
//
//  Created by Lynn Hui on 2020/12/24.
//

import Foundation

class GitCmd: FRBaseCmd {
    func queryGit(callBack: @escaping (_ data: Dictionary<String, String>) -> Void){
        self.methodName = "https://api.github.com"
        FRSqlManager.shared.addRecord(url: self.methodName)
        self.method = .get
        request(paramter: [:]) { (data) in callBack(data as! Dictionary<String, String>) }
    }
}
