//
//  FRBaseViews.swift
//  FRLawlib
//
//  Created by Lynn Hui on 2020/10/21.
//

import UIKit

class FRBaseViews: UIView {
    var createArg: Any?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(arg:Any) {
        self.init(frame: CGRect.zero)
        self.createArg = arg
        initViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initViews() {}

}
