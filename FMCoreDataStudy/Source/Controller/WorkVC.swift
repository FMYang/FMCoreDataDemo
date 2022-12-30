//
//  WorkVC.swift
//  FMCoreDataStudy
//
//  Created by yfm on 2022/12/30.
//

import UIKit

class WorkVC: UIViewController {

    var datasource = [Work]()
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.dataSource = self
        view.delegate = self
        view.separatorStyle = .none
        view.register(TaskCell.self, forCellReuseIdentifier: "cell")
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Works"
        view.backgroundColor = .white
        makeUI()
        configAppearance()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    func configAppearance() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAction))
    }
    
    func loadData() {
        datasource = FMCoreData.shared.fetch(name: Work.entityName) as! [Work]
        tableView.reloadData()
    }
    
    @objc func addAction() {
        let vc = TaskAddVC()
        vc.confirmBlock = { [unowned self] text in
            let work = Work.create(with: FMCoreData.shared.backgroundContext, name: text ?? "")
            self.datasource.append(work)
            self.tableView.reloadData()
            FMCoreData.shared.insert(entity: work)
        }
        present(vc, animated: true)
    }
    
    // MARK: -
    func makeUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

extension WorkVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskCell
        cell.lineView.isHidden = (indexPath.row == datasource.count - 1)
//        cell.config(task: datasource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let taskCell = cell as! TaskCell
        if datasource.count == 1 {
            taskCell.roundCornerType = .all
        } else if indexPath.row == 0 {
            taskCell.roundCornerType = .top
        } else if indexPath.row == datasource.count - 1 {
            taskCell.roundCornerType = .bottom
        } else {
            taskCell.roundCornerType = .none
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        FMCoreData.shared.delete(entity: datasource[indexPath.row])
        datasource.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let work = datasource[indexPath.row]
    }
}
