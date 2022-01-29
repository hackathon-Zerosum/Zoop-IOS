//
//  GoView.swift
//  Zoop-IOS
//
//  Created by 재영신 on 2022/01/30.
//

import UIKit
import SnapKit

final class HeaderCollectionCell: UICollectionReusableView {
    static let identifier = "HeaderCollectionCell"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16.0
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .InterFont(.semiBold, size: 21.0)
        label.numberOfLines = 0
        label.textColor = .white
        return label
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
            titleLabel
        ].forEach {
            self.addSubview($0)
        }
        self.imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.titleLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(self.imageView).offset(16.0)
        }
    }
    
    func binding(category: Category) {
        self.imageView.image = category.image
        self.titleLabel.text = category.title
    }
}
