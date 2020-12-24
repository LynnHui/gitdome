//
//  UIButton+Plus.swift
//  FRLawlib
//
//  Created by Lynn Hui on 2020/10/12.
//

import UIKit

enum ButtonEdgeInsetsStyle {
    case None
    case imageLeft
    case imageRight
    case imageTop
    case imgageBottom
}

@objc extension UIButton{
    @objc static func initWithIcon(_ icon: String) -> UIButton {
        let btn = UIButton.init(type: ButtonType.custom)
        if icon.count > 0 { btn.setImage(UIImage.imageNamedWithoutBlue(title: icon), for: UIControl.State.normal) }
        btn.backgroundColor = UIColor.clear
        return btn
    }
    
    @objc static func initWithIcon(_ title: String, image icon: String, fontName fName: String, titleColor tColor: UIColor, fontSize size: CGFloat) -> UIButton{
        let btn = UIButton.init(type: ButtonType.custom)
        if icon.count > 0 { btn.setImage(UIImage.imageNamedWithoutBlue(title: icon), for: UIControl.State.normal) }
        btn.setTitle(title, for: UIControl.State.normal)
        btn.setTitleColor(tColor, for: UIControl.State.normal)
        btn.titleLabel?.font = UIFont.init(name: (fName.count == 0 ? Regular : fName), size: size)
        return btn
    }
    
    func redPoint(_ number: NSInteger) {
        var redLbl = self.viewWithTag(101) as? UILabel
        if redLbl == nil {
            redLbl = UILabel.init();
            redLbl?.backgroundColor = rgba(r: 235, 49, 49, a: 1)
            redLbl?.tag = 101
            redLbl?.setCornerRadius(6)
            self.addSubview(redLbl!);
        }
        redLbl?.isHidden = (number == 0)
        redLbl?.text = number > 99 ? " 99+ " : " \(number) "
    }
    
    @objc func setButtonEdgeInsets(type: Int, space: CGFloat){ // for oc
        switch type {
        case 1: setButtonEdgeInsetsStyle(style: .imageTop, space: space); break;
        case 2: setButtonEdgeInsetsStyle(style: .imageLeft, space: space); break;
        case 3: setButtonEdgeInsetsStyle(style: .imageRight, space: space); break;
        case 4: setButtonEdgeInsetsStyle(style: .imgageBottom, space: space); break;
        default: setButtonEdgeInsetsStyle(style: .None, space: space); break;
        }
    }
    
    @nonobjc func setButtonEdgeInsetsStyle(style: ButtonEdgeInsetsStyle, space: CGFloat){
        let imageRect: CGRect = self.imageView?.frame ?? CGRect.init()
        let titleRect: CGRect = self.titleLabel?.frame ?? CGRect.init()
        let selfWidth: CGFloat = self.frame.size.width
        let selfHeight: CGFloat = self.frame.size.height
        let totalHeight = titleRect.size.height + space + imageRect.size.height
        switch style {
            case .imageLeft:
                self.titleEdgeInsets = UIEdgeInsets(top: 0, left: space / 2, bottom: 0, right: -space / 2)
                self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -space / 2, bottom: 0, right: space / 2)
            case .imageRight:
                self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(imageRect.size.width + space/2), bottom: 0, right: (imageRect.size.width + space/2))
                self.imageEdgeInsets = UIEdgeInsets(top: 0, left: (titleRect.size.width + space / 2), bottom: 0, right: -(titleRect.size.width +  space/2))
            case .imageTop :
                self.titleEdgeInsets = UIEdgeInsets(top: ((selfHeight - totalHeight) / 2 + imageRect.size.height + space - titleRect.origin.y), left: (selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2, bottom: -((selfHeight - totalHeight) / 2 + imageRect.size.height + space - titleRect.origin.y), right: -(selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2)
                self.imageEdgeInsets = UIEdgeInsets(top: ((selfHeight - totalHeight) / 2 - imageRect.origin.y), left: (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2), bottom: -((selfHeight - totalHeight) / 2 - imageRect.origin.y), right: -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2))
            case .imgageBottom:
                self.titleEdgeInsets = UIEdgeInsets(top: ((selfHeight - totalHeight) / 2 - titleRect.origin.y), left: (selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2, bottom: -((selfHeight - totalHeight) / 2 - titleRect.origin.y), right: -(selfWidth/2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2)
                self.imageEdgeInsets = UIEdgeInsets(top: ((selfHeight - totalHeight) / 2 + titleRect.size.height + space - imageRect.origin.y), left: (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2), bottom: -((selfHeight - totalHeight) / 2 + titleRect.size.height + space - imageRect.origin.y), right: -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2))
            default:
                self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            }
    }
}
