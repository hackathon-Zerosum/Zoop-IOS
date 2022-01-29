//
//  CityCollectionViewCell.swift
//  Zoop-IOS
//
//  Created by 재영신 on 2022/01/29.
//

import UIKit
import SnapKit

final class CityCell: UITableViewCell {
    static let identifier = "CityCell"

    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.font = .InterFont(.regular, size: 20.0)
        label.textAlignment = .center
        label.textColor = .gray
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
        
        self.contentView.addSubview(cityLabel)
        
        self.cityLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func binding(city: String) {
        self.cityLabel.text = city
        
    }
    
    func update(isSelected: Bool) {
        if isSelected {
            self.cityLabel.textColor = .white
        } else {
            self.cityLabel.textColor = .gray
        }
        
    }
}
