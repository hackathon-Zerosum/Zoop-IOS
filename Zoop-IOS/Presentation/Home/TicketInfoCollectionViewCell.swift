//
//  TicketInfoCollectionViewCell.swift
//  Zoop-IOS
//
//  Created by 재영신 on 2022/01/29.
//

import UIKit
import SnapKit

final class TicketInfoColletionViewCell: UICollectionViewCell {
    static let identifier = "TicketInfoColletionViewCell"
    
    private lazy var disCountLabel: UILabel = {
        let label = UILabel()
        label.font = .InterFont(.semiBold, size: 24.0)
        label.textColor = .disCountColor
        return label
    }()
    
    private lazy var placeLabel: UILabel = {
        let label = UILabel()
        label.font = .InterFont(.regular, size: 12.0)
        label.numberOfLines = 1
        return label
        
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureUI() {
        
        [
            disCountLabel,
            placeLabel
        ].forEach {
            self.contentView.addSubview($0)
        }
        
        self.contentView.backgroundColor = .mainColor
        self.disCountLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(23.0)
            make.leading.equalToSuperview().inset(16.0)
        }
        
        self.placeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16.0)
            make.top.equalToSuperview().inset(8.0)
            make.bottom.equalToSuperview().inset(13.0)
        }
    }
    func bind(disCount: String, place: String) {
        self.disCountLabel.text = disCount
        self.placeLabel.text = place
    }
}
