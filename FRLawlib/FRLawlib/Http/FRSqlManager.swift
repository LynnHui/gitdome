//
//  FRSqlManager.swift
//  FRLawlib
//
//  Created by Lynn Hui on 2020/12/24.
//

import Foundation

let dbName = "localDB"
let dataTableName = "data_table"
let recordTableName = "record_table"

class FRSqlManager{
    var dbQueue: FMDatabaseQueue?
    static let shared = FRSqlManager()
    private init() {
        self.dbQueue = FMDatabaseQueue.init(path: FRUtils.filePath(dbName) as String)
        let createDataTableSQL = "create table if not exists \(dataTableName)(identifier integer primary key AUTOINCREMENT, jsonstr text)"
        executeSQL(sql:createDataTableSQL)
        let createRecordTableSQL = "create table if not exists \(recordTableName)(identifier integer primary key AUTOINCREMENT, urlstr text, querytime text)"
        executeSQL(sql:createRecordTableSQL)
    }
    
    func addData(data: Dictionary<String, String>){
        var jsonStr = ""
        if (JSONSerialization.isValidJSONObject(data)){
            let jsonData = try? JSONSerialization.data(withJSONObject: data, options: [])
            jsonStr = NSString(data:jsonData! as Data,encoding: String.Encoding.utf8.rawValue)! as String
        }
        self.dbQueue?.inDatabase({ (db) in
            let sql = "insert into \(dataTableName)(jsonstr) values(?)"
            let paramter = [jsonStr]
            let result: Bool = ((try? db.executeUpdate(sql, values: paramter)) != nil)
            if result { print("insert success : \(db.lastInsertRowId)") }
            else { print("insert failed") }
        })
    }
    
    func getData(callBack: @escaping (_ data: Dictionary<String, String>) -> Void){
        self.dbQueue?.inDatabase({ (db) in
            let sql = "select identifier, jsonstr  from \(dataTableName) order by identifier desc limit 1"
            let reseultSet: FMResultSet = try! db .executeQuery(sql, values: [])
        
            while reseultSet.next() {
                let jsonStr = reseultSet.string(forColumn: "jsonstr") ?? ""
                print("row: \(reseultSet.int(forColumn: "identifier"))")
                
                let jsonData:Data = jsonStr.data(using: .utf8)!
                let local = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
                if let ret = local as? Dictionary<String,String> {
                    callBack(ret)
                }else {
                    callBack([:])
                }
            }
        })
    }
    
    func addRecord(url: String){
        self.dbQueue?.inDatabase({ (db) in
            let sql = "insert into \(recordTableName)(urlstr,querytime) values(?,?)"
            let paramter = [url,FRUtils.stringDate(date: Date(), formatter: "yyyy-MM-dd hh:mm:ss")]
            let result: Bool = ((try? db.executeUpdate(sql, values: paramter)) != nil)
            if result { print("insert success : \(db.lastInsertRowId)") }
            else { print("insert failed") }
        })
    }
    
    func getRecordS(callBack: @escaping (_ data: Array<Any>) -> Void){
        self.dbQueue?.inDatabase({ (db) in
            let sql = "select identifier, urlstr, querytime from \(recordTableName) order by identifier desc"
            let reseultSet: FMResultSet = try! db .executeQuery(sql, values: [])
        
            var records:Array<Any> = []
            while reseultSet.next() {
                let url = reseultSet.string(forColumn: "urlstr") ?? ""
                let time = reseultSet.string(forColumn: "querytime") ?? ""
                records.append(["url":url,"time":time])
            }
            callBack(records)
        })
    }
    
    func executeSQL(sql: String){
        self.dbQueue?.inDatabase({ (db) in
            if db.executeStatements(sql) {
                print("success")
            }else {
                print("failed")
            }
        })
    }
}
