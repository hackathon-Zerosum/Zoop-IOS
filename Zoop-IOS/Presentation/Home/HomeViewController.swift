//
//  HomeViewController.swift
//  Zoop-IOS
//
//  Created by 재영신 on 2022/01/29.
//

import UIKit
import SnapKit
import Kingfisher

enum Region: String, CaseIterable {
    case seoul
    case busan
    
    var title: String {
        switch self {
        case .seoul:
            return "서울(seoul)"
        case .busan:
            return "부산(busan)"
        }
    }
    
    var dummyDisCount: String {
        switch self {
        case .seoul:
            return "~50%"
        case .busan:
            return "~30%"
        }
    }
    
    var dummyPlace: String {
        switch self {
        case .seoul:
            return "N서울타워, 경복궁, 코엑스 등"
        case .busan:
            return "광안리 해수욕장, 센텀시티, 국제시장 등"
        }
    }
}

final class HomeViewController: UIViewController {
    
    private lazy var searchView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.mainColor.cgColor
        view.layer.cornerRadius = 28.0
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSearchView))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    private lazy var searchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "search-line")
        imageView.tintColor = .mainColor
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var searchLabel: UILabel = {
        let label = UILabel()
        label.text = Constant.search_Text
        label.textColor = .mainColor
        return label
    }()
    
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = Constant.main_Text
        label.font = .InterFont(.medium, size: 24.0)
        return label
    }()
    
    private lazy var ticketColletionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: 206, height: 350)
        let colletionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colletionView.showsHorizontalScrollIndicator = false
        colletionView.delegate = self
        colletionView.dataSource = self
        colletionView.register(TicketCollectionViewCell.self, forCellWithReuseIdentifier: TicketCollectionViewCell.identifier)
        
        return colletionView
    }()
    
    private var hotRegions: HotRegions?
    private lazy var currentLocationButton: UIButton = {
        let button = UIButton()
        button.setTitle("현재 위치로 보기", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .mainColor
        button.layer.cornerRadius = 8.0

        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configueUI()
        RegionNetworkManager.getPopularRegion {
            self.hotRegions = $0
            self.ticketColletionView.reloadData()
        }
    }
    
}

private extension HomeViewController {
    func configueUI() {
        
        [
            searchView,
            mainLabel,
            ticketColletionView,
            currentLocationButton
        ].forEach {
            self.view.addSubview($0)
        }
        
        [
            searchImageView,
            searchLabel
        ].forEach {
            self.searchView.addSubview($0)
        }
        
        
        searchView.snp.makeConstraints { make in
            make.left.trailing.equalToSuperview().inset(17.0)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(8.0)
            make.height.equalTo(56.0)
            
        }
        
        searchImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24.0)
            make.width.height.equalTo(28.0)
            make.top.equalTo(14.0)
        }
        
        searchLabel.snp.makeConstraints { make in
            make.top.equalTo(10.0)
            make.height.equalTo(36.0)
            make.leading.equalTo(searchImageView.snp.trailing).offset(8.0)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.leading.equalTo(21.0)
            make.top.equalTo(searchView.snp.bottom).offset(40.0)
            make.width.equalTo(293.0)
            make.height.equalTo(36.0)
        }
        
        ticketColletionView.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(17.0)
            make.height.equalTo(400.0)
        }
        
        currentLocationButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-30.0)
            make.centerX.equalToSuperview()
            make.width.equalTo(165.0)
            make.height.equalTo(56.0)
        }
    }
    
    @objc func didTapSearchView() {
        let regionSelectVC = RegionSelectViewController()
        self.navigationController?.pushViewController(regionSelectVC, animated: true)
    }
}


extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hotRegions?.states.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let hotRegions = hotRegions?.states else { return UICollectionViewCell() }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TicketCollectionViewCell.identifier, for: indexPath)
        as! TicketCollectionViewCell
        
        let region = hotRegions[indexPath.row]
        cell.bind(title: region.name, image: region.image,discount: region.max, place: region.tickets)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 1
    }
    
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DateSelectViewController(city: "서울", borough: "강남구")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


import SwiftUI
struct HomeViewController_Priviews: PreviewProvider {
    static var previews: some View {
        Contatiner().edgesIgnoringSafeArea(.all)
    }
    struct Contatiner: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            let vc = HomeViewController() //보고 싶은 뷰컨 객체
            return UINavigationController(rootViewController: vc)
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
        typealias UIViewControllerType =  UIViewController
    }
}
