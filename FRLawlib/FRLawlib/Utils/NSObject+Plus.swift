//
//  NSObject+Plus.swift
//  FRLawlib
//
//  Created by Lynn Hui on 2020/10/21.
//

import UIKit

extension NSObject{
    var className: String{
        get{
            let name =  type(of: self).description()
            if(name.contains(".")){ return name.components(separatedBy: ".")[1]; }
            else{ return name; }
        }
    }
}
