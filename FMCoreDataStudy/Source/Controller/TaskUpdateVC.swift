//
//  TaskUpdateVC.swift
//  FMCoreDataStudy
//
//  Created by yfm on 2022/12/30.
//

import UIKit

class TaskUpdateVC: UIViewController {
    
    var task: Task!
    
    lazy var textfiled: UITextField = {
        let view = UITextField()
        view.borderStyle = .roundedRect
        return view
    }()
    
    lazy var detailTextfiled: UITextField = {
        let view = UITextField()
        view.borderStyle = .roundedRect
        return view
    }()
    
    lazy var createDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    lazy var updateDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    convenience init(task: Task) {
        self.init()
        self.task = task
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Update"
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAction))
        
        makeUI()
        
        textfiled.text = task.name
        detailTextfiled.text = task.detail
        createDateLabel.text = "Create at " + (task.date?.toString(format: "yyyy-MM-dd HH:mm:ss") ?? "")
        updateDateLabel.text = "Update at " + (task.updateDate?.toString(format: "yyyy-MM-dd HH:mm:ss") ?? "")
    }
    
    @objc func saveAction() {
        if textfiled.text?.count == 0 { return }
        task.name = textfiled.text
        task.updateDate = Date()
        task.detail = detailTextfiled.text
        FMCoreData.shared.update(entity: task)
        navigationController?.popViewController(animated: true)
    }
    
    func makeUI() {
        view.addSubview(textfiled)
        view.addSubview(detailTextfiled)
        view.addSubview(createDateLabel)
        view.addSubview(updateDateLabel)
        textfiled.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(safeArea.top + navHeight + 20)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
        }
        
        detailTextfiled.snp.makeConstraints { make in
            make.top.equalTo(textfiled.snp.bottom).offset(10)
            make.left.right.equalTo(textfiled)
        }
        
        createDateLabel.snp.makeConstraints { make in
            make.left.equalTo(detailTextfiled)
            make.top.equalTo(detailTextfiled.snp.bottom).offset(10)
            make.height.equalTo(25)
        }
        
        updateDateLabel.snp.makeConstraints { make in
            make.left.right.equalTo(createDateLabel)
            make.top.equalTo(createDateLabel.snp.bottom).offset(10)
            make.height.equalTo(25)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textfiled.resignFirstResponder()
    }
}
