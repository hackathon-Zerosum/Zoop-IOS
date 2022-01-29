//
//  TicketView.swift
//  Zoop-IOS
//
//  Created by 재영신 on 2022/01/29.
//

import UIKit
import SnapKit

final class TicketView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .InterFont(.medium, size: 22.0)
        label.textColor = .white
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    convenience init(title: String,image: String) {
        //TODO: 타이틀,이미지설정
        self.titleLabel.text = title
        self.imageView.image = UIImage(named: image)
        self.configureUI()
        self.init(frame: .zero)
    }
    
    private func configureUI() {
        [
            imageView,
            titleLabel
        ].forEach {
            self.addSubview($0)
        }
        
        self.imageView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16.0)
            make.top.equalToSuperview().inset(11.0)
            make.width.equalTo(188.0)
            make.height.equalTo(29.0)
        }
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
