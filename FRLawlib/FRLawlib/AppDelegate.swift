//
//  AppDelegate.swift
//  FRLawlib
//
//  Created by Lynn Hui on 2020/9/29.
//

import UIKit

typealias wxLoginBlock = (_ text: String) -> Void
typealias wxMessageBlock = () -> Void

@main
@objc class AppDelegate: UIResponder, UIApplicationDelegate, WXApiDelegate {
    var window: UIWindow?
    var rootTab: UITabBarController!
    var callBack: wxLoginBlock?
    var msgBack: wxMessageBlock?
    
    @objc static func shared() -> Self{ return UIApplication.shared.delegate as! Self }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
        
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.native)
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
        SVProgressHUD.setMinimumDismissTimeInterval(1.0)
        
        rootView()
        customizeTabAndNav()
        
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) { }
    func applicationDidBecomeActive(_ application: UIApplication) { }
    func applicationWillResignActive(_ application: UIApplication) { }
    func applicationDidEnterBackground(_ application: UIApplication) { }
    func applicationWillTerminate(_ application: UIApplication) { }
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool { return WXApi.handleOpen(url, delegate: self) }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool { return WXApi.handleOpen(url, delegate: self) }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool { return WXApi.handleOpen(url, delegate: self) }

    func rootView(){
        let git = FRBaseViewController.createVC("GitViewController", createArg: AnyClass.self)
        let gitNav = UINavigationController.init(rootViewController: git);
        self.window?.rootViewController = gitNav;

    }
    
    static func showText(_ msg: String) { SVProgressHUD.show(UIImage.init(named: "svptip")!, status: msg) }
    @objc static func alert(_ title: String, msg: String, clTitle: String, okTitle: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController.init(title: title, message: msg, preferredStyle: .alert)
        if #available(iOS 13.0, *) { alert.overrideUserInterfaceStyle = .light }
        if clTitle.count > 0 {
            let cancelAction = UIAlertAction.init(title: clTitle, style: .cancel) { (cl) in }
            alert.addAction(cancelAction)
        }
        if okTitle.count > 0 {
            let okAction = UIAlertAction.init(title: okTitle, style: .default, handler: handler )
            alert.addAction(okAction)
        }
        AppDelegate.getCurrentVC().present(alert, animated: true, completion: nil)
    }
    
    @objc static func getCurrentVC() -> UIViewController {
        let rootVC: UIViewController = (UIApplication.shared.keyWindow!.rootViewController!)
        let currentVC: UIViewController = AppDelegate.getCurrentVCFrom(rootVC)
        return currentVC
    }
    
    private static func getCurrentVCFrom(_ rootVC: UIViewController) -> UIViewController{
        var currentVC: UIViewController?
        var vc: UIViewController = rootVC
        if (vc.presentedViewController != nil) { vc = vc.presentedViewController! }
        if (vc.isKind(of: UITabBarController.self)) { currentVC = AppDelegate.getCurrentVCFrom((vc as! UITabBarController).selectedViewController!) }
        else if (vc .isKind(of: UINavigationController.self)) { currentVC = AppDelegate.getCurrentVCFrom((vc as! UINavigationController).visibleViewController!) }
        else { currentVC = vc }
        return currentVC!
    }
    
    private func customizeTabAndNav(){
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: rgba(r: 190, 192, 199, a: 1), .font: UIFont.init(name: Medium, size: 10)!], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: rgba(r: 10, 124, 240, a: 1), .font: UIFont.init(name: Medium, size: 10)!], for: .selected)
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.init(name: Semibold, size: 18)!]
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = rgba(r: 82, 158, 252, a: 1)
        if #available(iOS 13.0, *) { UINavigationBar.appearance().overrideUserInterfaceStyle = .light }
    }
}

