//
//  UIView+Plus.swift
//  FRLawlib
//
//  Created by Lynn Hui on 2020/10/9.
//

import UIKit
import SnapKit

@objc extension UIView{
    
    func viewController() -> UIViewController? {
        var next = self.next
        while next != nil {
            if next is UIViewController { return next as? UIViewController }
            next = next?.next
        }
        return nil
    }
    
    @objc static func initWithColor(_ color: UIColor) -> UIView{
        let vi = UIView.init()
        vi.backgroundColor = color
        return vi
    }
    
    func setCornerRadius(_ radius: CGFloat){
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
    }
    
    func setBorder(_ color: UIColor, withWidth width:CGFloat) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    func setShadow(_ color:UIColor, offset off: CGSize) {
        self.layer.masksToBounds = true
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = off
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 4
    }
    
    func setCornerRadius(_ radius: CGFloat, withCorners corners:UIRectCorner)  { // [.bottomLeft, .bottomRight]
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    @objc func mas_layout(_ parameter: Any) {
        let dict = self.dictForString(parameter: parameter)
        self.snp.makeConstraints ({ (make) in self.makeConstraints(make, cons: dict) })
    }
    
    @objc func mas_modify(_ parameter:Any) {
        let dict = self.dictForString(parameter: parameter)
        self.snp.updateConstraints ({ (make) in self.makeConstraints(make, cons: dict) })
    }
    
    @objc func mas_delete(_ parameter:Any) {
        let dict = self.dictForString(parameter: parameter)
        self.snp.remakeConstraints ({ (make) in self.makeConstraints(make, cons: dict) })
    }
    
    @objc func mas_layout(_ vi: UIView, parameter: Any) {
        let dict:Dictionary<String, String> = self.dictForString(parameter: parameter)
        self.snp.makeConstraints ({ (make) in self.makeConstraints(make, brother: vi, cons: dict) })
    }
    
    @objc func mas_modify(_ vi: UIView, parameter: Any) {
        let dict:Dictionary<String, String> = self.dictForString(parameter: parameter)
        self.snp.updateConstraints ({ (make) in self.makeConstraints(make, brother: vi, cons: dict) })
    }
    
    @objc func mas_delete(_ vi: UIView, parameter: Any) {
        let dict:Dictionary<String, String> = self.dictForString(parameter: parameter)
        self.snp.remakeConstraints ({ (make) in self.makeConstraints(make, brother: vi, cons: dict) })
    }
    
    @nonobjc private func makeConstraints(_ make: ConstraintMaker, cons dic: Dictionary<String, String>){
        if dic.keys.contains("l") { make.left.equalTo(self.superview!.snp.left).offset(CGFloat((dic["l"]! as NSString).floatValue)) }
        if dic.keys.contains("t") { make.top.equalTo(self.superview!.snp.top).offset(CGFloat((dic["t"]! as NSString).floatValue)) }
        if dic.keys.contains("r") { make.right.equalTo(self.superview!.snp.right).offset(-(CGFloat((dic["r"]! as NSString).floatValue))) }
        if dic.keys.contains("b") { make.bottom.equalTo(self.superview!.snp.bottom).offset(-CGFloat((dic["b"]! as NSString).floatValue)) }
        if dic.keys.contains("x") { make.centerX.equalTo(self.superview!).offset(CGFloat((dic["x"]! as NSString).floatValue)) }
        if dic.keys.contains("y") { make.centerY.equalTo(self.superview!).offset(CGFloat((dic["y"]! as NSString).floatValue))  }
        if dic.keys.contains("w") { make.width.equalTo(CGFloat((dic["w"]! as NSString).floatValue)) }
        if dic.keys.contains("h") { make.height.equalTo(CGFloat((dic["h"]! as NSString).floatValue)) }
        if dic.keys.contains("lw") { make.width.lessThanOrEqualTo(CGFloat((dic["lw"]! as NSString).floatValue)) }// 小于等于
        if dic.keys.contains("gw") { make.width.greaterThanOrEqualTo(CGFloat((dic["gw"]! as NSString).floatValue)) }// 大于等于
        if dic.keys.contains("lh") { make.height.lessThanOrEqualTo(CGFloat((dic["lh"]! as NSString).floatValue)) }// 小于等于
        if dic.keys.contains("gh") { make.height.greaterThanOrEqualTo(CGFloat((dic["gh"]! as NSString).floatValue)) }// 大于等于
    }
    
    @nonobjc private func makeConstraints(_ make: ConstraintMaker, brother vi: UIView, cons dic: Dictionary<String, String>){
        if dic.keys.contains("H") { make.left.equalTo(vi.snp.right).offset(CGFloat((dic["H"]! as NSString).floatValue)) }
        if dic.keys.contains("V") { make.top.equalTo(vi.snp.bottom).offset(CGFloat((dic["V"]! as NSString).floatValue)) }
        if dic.keys.contains("X") { make.centerX.equalTo(vi.snp.centerX).offset(CGFloat((dic["X"]! as NSString).floatValue)) }
        if dic.keys.contains("Y") { make.centerY.equalTo(vi.snp.centerY).offset(CGFloat((dic["Y"]! as NSString).floatValue)) }
    }
    
    @nonobjc private func dictForString(parameter : Any) -> Dictionary<String, String>{
        var dict = [String: String]()
        if parameter is NSDictionary { return parameter as! Dictionary<String, String> }
        if parameter is String {
            let ary = (parameter as! String).split(separator: "|")
            for str in ary {
                let rang: Range? = str.range(of: ":")
                if rang != nil {
                    let idx = str.distance(from: str.startIndex, to: rang!.lowerBound)
                    if idx >= 0 { dict[(String(str.prefix(idx)))] = String(str.suffix(str.count-idx-1)) }
                } else { dict[String(str)] = "0" }
            }
        }
        return dict
    }

}
 
