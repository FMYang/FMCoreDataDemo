//
//  TaskAddVC.swift
//  FMCoreDataStudy
//
//  Created by yfm on 2022/12/16.
//

import UIKit

class TaskAddVC: UIViewController {
    
    var confirmBlock: ((String?)->())?
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "添加任务"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    lazy var textfiled: UITextField = {
        let view = UITextField()
        view.borderStyle = .roundedRect
        view.placeholder = "请输入内容"
        view.clearButtonMode = .whileEditing
        return view
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.15)
        return view
    }()
    
    lazy var verLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.15)
        return view
    }()
    
    lazy var cancelButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("取消", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        return btn
    }()
    
    lazy var sureButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("确定", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(sureAction), for: .touchUpInside)
        return btn
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .custom
        modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.15)
        makeUI()
    }
    
    // MARK: -
    @objc func cancelAction() {
        textfiled.resignFirstResponder()
        dismiss(animated: true)
    }
    
    @objc func sureAction() {
        confirmBlock?(textfiled.text)
        textfiled.resignFirstResponder()
        dismiss(animated: true)
    }
    
    // MARK: -
    func makeUI() {
        view.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(textfiled)
        contentView.addSubview(lineView)
        contentView.addSubview(cancelButton)
        contentView.addSubview(sureButton)
        contentView.addSubview(verLineView)

        contentView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(view.bounds.width-80)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(24)
        }
        
        textfiled.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(30)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(textfiled.snp.bottom).offset(20)
            make.bottom.equalTo(cancelButton.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview()
            make.right.equalTo(view.snp.centerX)
            make.height.equalTo(44)
        }
        
        sureButton.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview()
            make.left.equalTo(view.snp.centerX)
            make.height.equalTo(44)
        }
        
        verLineView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(0.5)
            make.height.equalTo(44)
        }
    }
    
}

