//
//  FRBaseViewController.swift
//  FRLawlib
//
//  Created by Lynn Hui on 2020/10/8.
//

import UIKit

@objc class FRBaseViewController: UIViewController, UIGestureRecognizerDelegate {
    var createArg: Any?
    
    @objc static func createVC(_ vcName: String, createArg arg: Any) -> FRBaseViewController {
        let clsName = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String
        let vcView = NSClassFromString("\(clsName!).\(vcName)") as! FRBaseViewController.Type
        let vc: FRBaseViewController? = vcView.init()
        vc?.createArg = arg
        if (!SHOW_TAB_ARRAY.contains(vcName)) { vc?.hidesBottomBarWhenPushed = true }
        return vc!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) { self.overrideUserInterfaceStyle = UIUserInterfaceStyle.light }
        if #available(iOS 11.0, *) {} else { self.automaticallyAdjustsScrollViewInsets = false }
        self.view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = HIDDEN_NAV_PAGE_ARRAY.contains(self.className) as Bool
        self.navigationController?.navigationBar.barTintColor = (NAV_WHITE_ARRAY.contains(self.className) as Bool ? rgba(r: 82, 158, 252, a: 1) : .white) // 变白色导航栏
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:(NAV_WHITE_ARRAY.contains(self.className) as Bool ? .white : rgba(r: 51, 51, 51, a: 1))]
        let firstVc = self.navigationController!.viewControllers.first
        if (firstVc! != self) { self.backBtn() }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let edgeGes = UIScreenEdgePanGestureRecognizer.init(target: self, action: #selector(edgePanGesture(_:)))
        edgeGes.delegate = self
        edgeGes.edges = .left
        self.view.addGestureRecognizer(edgeGes)
    }
    
    @objc func doBackAction(){ self.navigationController?.popViewController(animated: true) }
    @objc private func edgePanGesture(_ edgeGes: UIScreenEdgePanGestureRecognizer){ backBtn() }
    @objc func doRightAction(_ sender: UIButton){ }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if (self.navigationController != nil && self.navigationController?.viewControllers.count == 1){ return false }
        return true
    }
    
    private func backBtn(){
        let btn = UIButton.initWithIcon(NAV_BACK_BTN_ICON)
        btn.addTarget(self, action: #selector(doBackAction), for: .touchUpInside)
        let leftItem = UIBarButtonItem.init(customView: btn)
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    func rightBtns(_ titles:Array<String>, color: UIColor) {
        var items: [UIBarButtonItem] = []
        for title in titles {
            let btn = UIButton.initWithIcon(title, image: "", fontName: Medium, titleColor: color, fontSize: 14)
            btn.addTarget(self, action: #selector(doRightAction(_ :)), for: .touchUpInside)
            let item = UIBarButtonItem.init(customView: btn)
            items.append(item)
        }
        self.navigationItem.rightBarButtonItems = items
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        if #available(iOS 13.0, *) { return .lightContent }
        else { return .default }
    }
    
    func setTitle(title: String, color: UIColor) {
        let titleVi = UIView.init(frame: CGRect(x: 44, y: 0, width: 200, height: 44))
        titleVi.autoresizesSubviews = true
        let titleLbl = UILabel.initWithText(title, fontName: Medium, fontSize: 18, fontColor: color)
        titleLbl.frame = CGRect(x: 0, y: 0, width: 200, height: 44)
        titleVi.addSubview(titleLbl)
        self.navigationItem.titleView = titleVi
    }
}

let NAV_BACK_BTN_ICON = "nav_btn_back"
let SPACK = "占位占位占位"
let CANCEL_BTN_TITLE = "取消"
let HIDDEN_NAV_PAGE_ARRAY = ["FRAuthViewController","FRLoginViewController","FRBindNOViewController","FRCodeViewController","FRHomeViewController","FRSelectViewController","FRMineViewController"]
let SHOW_TAB_ARRAY = ["FRHomeViewController","FRHorizonViewController","FRFinanceViewController","FRMineViewController"]
let NAV_WHITE_ARRAY = ["FRLawDetailViewController","FRConfigViewController","FRWebViewController","FRMineViewController"]
