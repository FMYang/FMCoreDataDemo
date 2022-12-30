//
//  TasksVC.swift
//  FMCoreDataStudy
//
//  Created by yfm on 2022/12/16.
//

import UIKit

class TasksVC: UIViewController {
    
    var datasource = [Task]()
    
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
        title = "Tasks"
        view.backgroundColor = .white
        makeUI()
        configAppearance()
        loadData()
    }
    
    func configAppearance() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAction))
    }
    
    func loadData() {
        datasource = FMCoreData.shared.fetch()
        tableView.reloadData()
    }
    
    @objc func addAction() {
        let vc = TaskAddVC()
        vc.confirmBlock = { [unowned self] text in
            let task = Task.insert(into: FMCoreData.shared.backgroundContext, name: text ?? "")
            self.datasource.append(task)
            self.tableView.reloadData()
            FMCoreData.shared.insert(task: task)
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

extension TasksVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskCell
        cell.nameLabel.text = datasource[indexPath.row].name
        cell.lineView.isHidden = (indexPath.row == datasource.count - 1)
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
        FMCoreData.shared.delete(task: datasource[indexPath.row])
        datasource.remove(at: indexPath.row)
        tableView.reloadData()
    }

}
