//
//  TaskCell.swift
//  FMCoreDataStudy
//
//  Created by yfm on 2022/12/16.
//

import UIKit

class TaskCell: UITableViewCell {
    
    enum RoundCornerType {
        case none
        case top
        case bottom
        case all
    }
    
    var roundCornerType: RoundCornerType = .none {
        didSet {
            switch roundCornerType {
            case .none:
                addRoundCorners(corners: .allCorners, radius: 0)
                
            case .top:
                addRoundCorners(corners: [.topLeft, .topRight], radius: 8)
                
            case .bottom:
                addRoundCorners(corners: [.bottomLeft, .bottomRight], radius: 8)
                
            case .all:
                addRoundCorners(corners: .allCorners, radius: 8)
            }
        }
    }
        
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    lazy var createDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    lazy var updateDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.15)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(task: Task) {
        nameLabel.text = task.name
        detailLabel.text = task.detail
        createDateLabel.text = "Create at " + (task.date?.toString() ?? "")
        updateDateLabel.text = "Update at " + (task.updateDate?.toString() ?? "")
    }
    
    // MARK: -
    func makeUI() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(detailLabel)
        contentView.addSubview(createDateLabel)
        contentView.addSubview(updateDateLabel)
        contentView.addSubview(lineView)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(25)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.left.right.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom)
        }
        
        createDateLabel.snp.makeConstraints { make in
            make.top.equalTo(detailLabel.snp.bottom)
            make.left.equalTo(nameLabel)
            make.height.equalTo(25)
        }
        
        updateDateLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-40)
            make.centerY.equalTo(createDateLabel)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(createDateLabel.snp.bottom)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
}
