//
//  ViewController.swift
//  FMCoreDataStudy
//
//  Created by yfm on 2022/12/16.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    lazy var taskButton: UIButton = {
        let btn = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 40)))
        btn.center = view.center
        btn.setTitle("Task", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var workButton: UIButton = {
        let btn = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 40)))
        btn.center = view.center
        btn.setTitle("Work", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(workAction), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "RootVC"
        makeUI()
    }
    
    @objc func btnAction() {
        let vc = TasksVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func workAction() {
        let vc = WorkVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: -
    func makeUI() {
        view.addSubview(taskButton)
        view.addSubview(workButton)
        taskButton.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(44)
            make.center.equalToSuperview().offset(-20)
        }
        
        workButton.snp.makeConstraints { make in
            make.top.equalTo(taskButton.snp.bottom).offset(20)
            make.centerX.equalTo(taskButton)
            make.width.equalTo(100)
            make.height.equalTo(44)
        }
    }
}

