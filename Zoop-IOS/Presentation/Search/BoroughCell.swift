//
//  BoroughCollectionViewCell.swift
//  Zoop-IOS
//
//  Created by 재영신 on 2022/01/29.
//

import UIKit
import SnapKit

final class BoroughCell: UITableViewCell {
    
    static let identifier = "BoroughCell"
    
    private lazy var boroughLabel: UILabel = {
        let label = UILabel()
        label.font = .InterFont(.regular, size: 16.0)
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureUI()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureUI() {
        
        self.contentView.addSubview(boroughLabel)
        
        self.boroughLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
   
    func binding(borough: String) {
        self.boroughLabel.text = borough
    }
}
