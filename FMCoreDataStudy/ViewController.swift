//
//  ViewController.swift
//  FMCoreDataStudy
//
//  Created by yfm on 2022/12/16.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    lazy var btn: UIButton = {
        let btn = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 40)))
        btn.center = view.center
        btn.setTitle("Jump", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
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
    
    // MARK: -
    func makeUI() {
        view.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.center.equalToSuperview()
        }
    }
}

