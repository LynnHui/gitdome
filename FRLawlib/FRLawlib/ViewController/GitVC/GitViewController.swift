//
//  GitViewController.swift
//  FRLawlib
//
//  Created by Lynn Hui on 2020/12/24.
//

import UIKit

class GitViewController: FRBaseViewController, UITableViewDelegate, UITableViewDataSource{
    var data:Array<Any> = []
    var timerCount = 0
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
        self.title = "GIT"
        
        initViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadLocalData()
        self.timer.fireDate = NSDate.init() as Date
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.timer.fireDate = NSDate.distantFuture as Date
    }
    
    override func doRightAction(_ sender: UIButton){
        let record = FRBaseViewController.createVC("GitRecordViewController", createArg: AnyClass.self)
        self.navigationController?.pushViewController(record, animated: true)
    }
    
    @objc func doTimerAction(){
        if self.timerCount == 0 {
            self.timerCount = 5
            loadData()
            return
        }
        self.timerCount = self.timerCount - 1
    }
    
    func loadLocalData(){
        FRSqlManager.shared.getData() { (ret) in
            print(ret)
            for str in ret.keys{
                self.data.append([str: ret[str]])
            }
            self.tableVi.reloadData()
        }
    }
    
    func loadData() {
        GitCmd().queryGit { (ret) in
            FRSqlManager.shared.addData(data: ret)
            for str in ret.keys{
                self.data.append([str: ret[str]])
            }
            self.tableVi.reloadData()
        }
    }
    
    private func initViews(){
        rightBtns(["记录"], color: rgba(r: 51, 51, 51, a: 1))
        
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
    
    lazy var timer: Timer = {
        var ti = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(doTimerAction), userInfo: AnyObject.self, repeats: true)
        return ti
    }()
}

class GitCell: FRBaseCell {
    override func initViews(){
        self.contentView.addSubview(self.titleLbl)
        self.contentView.addSubview(self.contentLbl)

        self.titleLbl.mas_layout("l:15|r:15|t:10")
        self.contentLbl.mas_layout("l:15|r:15|b:10")
        self.contentLbl.mas_layout(self.titleLbl, parameter: "V:10")
    }
    
    var data: Dictionary<String, String> = [:]{
        didSet{
            if data.count == 1 {
                self.titleLbl.text = data.keys.first
                self.contentLbl.text = data.values.first
            }else {
                self.titleLbl.text = data["url"]
                self.contentLbl.text = data["time"]
            }
        }}
    
    lazy var titleLbl: UILabel = {
        var lbl = UILabel.initWithText("", fontName: Medium, fontSize: 14, fontColor: rgba(r: 49, 50, 56, a: 1))
        return lbl
    }()
    
    lazy var contentLbl: UILabel = {
        var lbl = UILabel.initWithText("", fontName: "", fontSize: 12, fontColor: rgba(r: 71, 75, 79, a: 1))
        lbl.numberOfLines = 2
        return lbl
    }()
}
