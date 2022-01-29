//
//  TicketColletionViewCell.swift
//  Zoop-IOS
//
//  Created by 재영신 on 2022/01/29.
//

import UIKit
import Kingfisher

final class TicketCollectionViewCell: UICollectionViewCell {
    static let identifier = "TicketCollectionViewCell"
    
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .InterFont(.medium, size: 22.0)
        label.textColor = .white
        label.layer.cornerRadius = 12.0
        label.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMaxYCorner, .layerMinXMaxYCorner)
        label.clipsToBounds = true
        label.backgroundColor = .mainColor
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var discountLabel: UILabel = {
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
    
    private lazy var ticketInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainColor
        view.layer.cornerRadius = 12.0
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureUI() {
        [
            imageView,
            titleLabel,
            ticketInfoView
        ].forEach {
            self.contentView.addSubview($0)
        }
        
        [
            discountLabel,
            placeLabel
        ].forEach {
            self.ticketInfoView.addSubview($0)
        }
        
        
        self.imageView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(250.0)
        }
        
        self.titleLabel.snp.makeConstraints { make in
            //make.leading.trailing.equalToSuperview().inset(16.0)
            make.leading.trailing.bottom.equalTo(imageView)
            make.height.equalTo(60.0)
        }
        
        self.discountLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16.0)
            make.leading.equalToSuperview().inset(8.0)
        }
        
        self.placeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8.0)
            make.top.equalToSuperview().inset(8.0)
            make.bottom.equalToSuperview().inset(8.0)
        }
        
        
        self.ticketInfoView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom)
        }
    }
    
    func bind(title: String, image: String, discount: Int, place: [String]) {
        self.imageView.kf.setImage(with: URL(string: image)!)
        self.titleLabel.text = title
        self.discountLabel.text = "\(discount)"
        self.placeLabel.text = place.joined(separator: ",") + "등"
    }
}
