//
//  FRBaseCell.swift
//  FRLawlib
//
//  Created by Lynn Hui on 2020/10/22.
//

import UIKit

class FRBaseCell: UITableViewCell {
    var createArg: Any?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    static func createCell(name: String, table: UITableView, arg: Any) -> FRBaseCell {
        let clsName = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String
        table.register((NSClassFromString("\(clsName!).\(name)") as! FRBaseCell.Type).classForCoder(), forCellReuseIdentifier: name)
        let cell: FRBaseCell = table.dequeueReusableCell(withIdentifier: name)! as! FRBaseCell
        cell.createArg = arg
        cell.initViews()
        return cell
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initViews() {}
}
