//
//  FRBaseCCell.swift
//  FRLawlib
//
//  Created by Lynn Hui on 2020/12/17.
//

import UIKit

class FRBaseCCell: UICollectionViewCell {
    var createArg: Any?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        initViews()
    }
    
    static func createCell(name: String, collectView: UICollectionView, idx: IndexPath, arg: Any) -> FRBaseCCell {
        let clsName = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String
        collectView.register((NSClassFromString("\(clsName!).\(name)") as! FRBaseCCell.Type).classForCoder(), forCellWithReuseIdentifier: name)
        let cell = collectView.dequeueReusableCell(withReuseIdentifier: name, for: idx) as! FRBaseCCell
        cell.createArg = arg
        return cell
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override func awakeFromNib() { super.awakeFromNib() }

    
    func initViews() {}
}


