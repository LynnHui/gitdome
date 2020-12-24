//
//  UILabel+Plus.swift
//  FRLawlib
//
//  Created by Lynn Hui on 2020/10/12.
//

import UIKit

@objc extension UILabel{
    @objc static func initWithText(_ text: String, fontName fName: String, fontSize size: CGFloat, fontColor color: UIColor) -> UILabel{
        let lbl = UILabel.init()
        lbl.text = text
        lbl.textColor = color
        lbl.font = UIFont.init(name: Regular, size: size)
        if fName.count > 0 { lbl.font = UIFont.init(name: fName, size: size) }
        return lbl
    }
    
    @objc static func initWithAttri(_ attr: NSMutableAttributedString) -> UILabel{
        let lbl = UILabel.init()
        lbl.attributedText = attr
        return lbl
    }
}
