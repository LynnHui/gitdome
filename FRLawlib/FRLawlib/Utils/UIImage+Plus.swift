//
//  UIImage+Plus.swift
//  FRLawlib
//
//  Created by Lynn Hui on 2020/10/13.
//

import UIKit
import Kingfisher

@objc extension UIImage{
    @objc static func imageWithColor(_ color: UIColor) -> UIImage{
        let rect = CGRect(x:0,y:0,width:1,height:1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    @objc static func imageNamedWithoutBlue(title : String) -> UIImage{
        var image: UIImage = UIImage.init(named: title)!
        image = image.withRenderingMode(.alwaysOriginal)
        return image
    }
}

@objc extension UIImageView{
    @objc func kf_loadImg(urlStr: String, placeholder: String) { self.kf.setImage(with: URL(string: urlStr), placeholder: UIImage.init(named: placeholder)) }
}
