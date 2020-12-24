//
//  FRLawlib-Prefix.swift
//  FRLawlib
//
//  Created by Lynn Hui on 2020/10/12.
//

import Foundation

#if DEBUG
    let kToken = "" // "Rb22DWyvP7HRTOLLuqCIWN6dfmKXbPMQo4Eivdv36DQd1Smzu1heDaokfrYX6bim" //  tq7uwLNNidn9KaN6/cr+ju5VpE1JwGO7u0sLH9+jvlWqZGGGqj+Mrf2nIpJFDQ0k

#else
    let kToken = ""

#endif

let universalLink = "https://www.banklaw.com/"

let kPageSize = 10
let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height

let kContentNoTabHeight = (Int(kScreenHeight) - kStatusBarHeight - kNavigationBarHeight - kBottomSpaceHeight)
let kContentHeight = (Int(kScreenHeight) - kStatusBarHeight - kNavigationBarHeight)
let kStatusBarHeight = (fullScreen() ? 44 : 20)
let kNavigationBarHeight =  44
let kTabbarHeight = (fullScreen() ? (49 + 34) : 49)
let kBottomSpaceHeight = (fullScreen() ? 34 : 0)

let Semibold = "PingFangSC-Semibold"
let Medium = "PingFang-SC-Medium"
let Regular = "PingFang-SC-Regular"

func rgba(r:CGFloat,_ g:CGFloat,_ b:CGFloat, a:CGFloat) -> UIColor { return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: a) }
func fullScreen () -> Bool { if #available(iOS 11.0, *) { return (UIApplication.shared.delegate?.window??.safeAreaInsets.bottom)! > 0 } else { return true } }

