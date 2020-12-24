//
//  GitRecordViewController.swift
//  FRLawlib
//
//  Created by Lynn Hui on 2020/12/24.
//

import UIKit

class GitRecordViewController: FRBaseViewController, UITableViewDelegate, UITableViewDataSource{
    var data:Array<Any> = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GitCell = FRBaseCell.createCell(name: "GitCell", table: tableView, arg: AnyClass.self) as! GitCell
        cell.data = self.data[indexPath.row] as! Dictionary<String, String>
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "GIT RECORD"
        
        initViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadLocalData()
    }
    
    func loadLocalData(){
        FRSqlManager.shared.getRecordS(callBack: { (ret) in
            self.data = ret
            self.tableVi.reloadData()
        })
    }
    
    private func initViews(){
        self.view.addSubview(self.tableVi)
        self.tableVi.mas_layout("l|r|t|b")
    }
    
    lazy var tableVi: UITableView = {
        var tb = UITableView.init(frame: .zero, style: .plain)
        tb.backgroundColor = rgba(r: 245, 245, 245, a: 1)
        tb.delegate = self
        tb.dataSource = self
        tb.estimatedRowHeight = 60
        return tb
    }()
}
