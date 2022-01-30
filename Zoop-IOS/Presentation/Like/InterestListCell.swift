//
//  InterestListCell.swift
//  Zoop-IOS
//
//  Created by 재영신 on 2022/01/30.
//

import UIKit
import SnapKit

final class InterestListCell: UITableViewCell {
    
    static let identifier = "InterestListCell"
    
    private lazy var regionNameLabel: UILabel = {
        let label = UILabel()
        label.font = .InterFont(.bold, size: 26.0)
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
        self.addSubview(regionNameLabel)
        
        regionNameLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16.0)
        }
    }
    
    func binding(name: String) {
        self.regionNameLabel.text = name
    }
}
