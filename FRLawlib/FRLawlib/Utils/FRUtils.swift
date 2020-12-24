//
//  FRUtils.swift
//  FRLawlib
//
//  Created by Lynn Hui on 2020/10/15.
//

import Foundation

@objc class FRUtils: NSObject{
    static func cachePath() -> NSString { return NSHomeDirectory() + "/Library/Caches" as NSString }
    
    static func filePath(_ path: String) -> NSString { return FRUtils.cachePath().appendingPathComponent(path) as NSString }
    
    static func textSize(_ text: String, fontName name: String, fontSize size: CGFloat, limit width:Int) -> CGSize{
        let font = UIFont.init(name: (name.count == 0 ? Regular : name), size: size)
        return text.boundingRect(with: CGSize(), options: .usesFontLeading, attributes: [NSAttributedString.Key.font : font as Any], context: nil).size
    }
    
    @objc static func attribute(str: String, font fDic: Dictionary<String, Any>, image iDic: Dictionary<String, String>) -> NSMutableAttributedString {
        let attr = NSMutableAttributedString.init(string: str)
        attr.addAttributes([.font: UIFont.init(name: Regular, size: CGFloat((fDic["size"]! as! NSString).floatValue))!], range: NSRange(location: 0, length: str.count))
        if fDic["name"] != nil { attr.addAttributes([.font: UIFont.init(name: fDic["name"]! as! String, size: CGFloat((fDic["size"]! as! NSString).floatValue))!], range: NSRange(location: 0, length: str.count)) }
        if fDic["color"] != nil { attr.addAttributes([.foregroundColor: fDic["color"] as! UIColor], range: NSRange(location: 0, length: str.count)) }
        if fDic["bg"] != nil { attr.addAttributes([.backgroundColor: fDic["bg"] as! UIColor], range: NSRange(location: 0, length: str.count)) }
        if iDic.count > 0 && iDic["name"] != nil {
            let img: UIImage = UIImage.init(named: iDic["name"]!)!
            let attachment = NSTextAttachment.init()
            attachment.image = img
            attachment.bounds = .init(x: 0, y: -2, width: img.size.width, height: img.size.height)
            let attrString = NSAttributedString(attachment: attachment)
            var idx = Int((iDic["idx"]! as NSString).intValue)
            idx = idx == -1 ? str.count : idx
            attr.insert(attrString, at: idx)
        }
        return attr
    }
    
    static func stringDate(interval: TimeInterval, formatter str: String) -> String {
        let date = Date.init(timeIntervalSince1970: interval / 1000)
        let formatter = FRUtils.formatter(string: str)
        return formatter.string(from: date)
    }
    
    static func stringDate(date: Date, formatter str: String) -> String {
        let formatter = FRUtils.formatter(string: str)
        return formatter.string(from: date)
    }
    
    static func formatter(string: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "Asia/Shanghai")
        formatter.dateFormat = string
        return formatter
    }
    
    @objc static func getUserAgent() -> String{ return "fr/\(getAppVersion()) ios/\(getSystemVersion()) iphone12" }
    @objc static func getAppVersion() -> String { return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String }
    @objc static func getAppVersionBuild() -> String { return Bundle.main.infoDictionary!["CFBundleVersion"] as! String }
    @objc static func getSystemVersion() -> String { return UIDevice.current.systemVersion }
}
//        return NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
