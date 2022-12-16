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
    
    // MARK: -
    func makeUI() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(lineView)
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.centerY.equalToSuperview()
        }
        
        lineView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
}
