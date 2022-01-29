//
//  PostCollectionCell.swift
//  Zoop-IOS
//
//  Created by 재영신 on 2022/01/30.
//

import UIKit
import SnapKit

final class PostCollectionCell: UICollectionViewCell {
    static let identifier = "PostCollectionCell"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8.0
        imageView.image = UIImage(systemName: "person.fill")
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .InterFont(.medium, size: 18.0)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var originPriceLabel: UILabel = {
       let label = UILabel()
        label.font = .InterFont(.regular, size: 15.0)
        label.textColor = .gray
        return label
    }()
    
    private lazy var sellingPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .InterFont(.regular, size: 15.0)
        return label
    }()
    
    private lazy var discountLabel: UILabel = {
        let label = UILabel()
        label.font = .InterFont(.semiBold, size: 17.0)
        label.textColor = .red
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func binding(ticket: Ticket) {
        self.imageView.kf.setImage(with: URL(string: ticket.image)!)
        self.titleLabel.text = ticket.name
        self.sellingPriceLabel.text = "\(ticket.sellingPrice)"
        self.originPriceLabel.text = String(ticket.originPrice).strikeThrough().string
        self.discountLabel.text = "\(ticket.discount)%"
        
    }
    private func configureUI() {
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.mainColor.cgColor
        self.contentView.layer.cornerRadius = 8.0
        [
            imageView,
            titleLabel,
            originPriceLabel,
            sellingPriceLabel,
            discountLabel
        ].forEach {
            self.contentView.addSubview($0)
        }
        
        imageView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview().inset(8.0)
            make.height.equalTo(100.0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8.0)
            make.leading.trailing.equalToSuperview().inset(8.0)
        }
        originPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5.0)
            make.leading.equalToSuperview().inset(8.0)
        }
        discountLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8.0)
            make.top.equalTo(originPriceLabel.snp.bottom).offset(5.0)
        }
        sellingPriceLabel.snp.makeConstraints { make in
            make.leading.equalTo(discountLabel.snp.trailing).offset(5.0)
            make.trailing.equalToSuperview().inset(8.0)
            make.top.equalTo(discountLabel)
        }
    }
}
