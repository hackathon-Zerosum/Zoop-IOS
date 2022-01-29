////
////  SearchViewController.swift
////  Zoop-IOS
////
////  Created by 재영신 on 2022/01/29.
////
//
//import UIKit
//import SnapKit
//
//
//final class testViewController: UICollectionViewController {
//    
//    private var selectedCity: String?
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.configureUI()
//    }
//    
//    func configureUI() {
//        
//        //navigation
//        self.navigationItem.title = "지역"
//     
//        //collectionView
//        print(self.collectionView.collectionViewLayout)
//        self.collectionView.collectionViewLayout = createLayout()
//        //self.collectionView.register(CityCollectionViewCell.self, forCellWithReuseIdentifier: CityCollectionViewCell.identifier)
//       // self.collectionView.register(BoroughCollectionViewCell.self, forCellWithReuseIdentifier: BoroughCollectionViewCell.identifier)
//    }
//}
//
//private extension testViewController {
//    func createLayout() -> UICollectionViewLayout {
//        return UICollectionViewCompositionalLayout { [weak self] section, enviroment -> NSCollectionLayoutSection? in
//            guard let self = self else { return nil }
//            if section == 0 {
//                return self.createCityLayout()
//            } else {
//                return self.createboroughLayout()
//            }
//        }
//    }
//    
//    func createCityLayout() -> NSCollectionLayoutSection {
//        //item
//        
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(1))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5)
//        //group
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1))
//        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 25)
//        //section
//        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .continuous
//        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
//        
//        return section
//    }
//    
//    func createboroughLayout() -> NSCollectionLayoutSection {
//        //item
//        
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.2))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets = .init(top: 10, leading: 5, bottom: 0, trailing: 5)
//        //group
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(0.9))
//        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 10)
//        //section
//        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .continuous
//        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 5)
//        
//        return section
//    }
//}
//
//extension testViewController {
//    //섹션당 보여질 셀의 개수
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch section {
//        case 0:
//            return Constant.city.count
//        default:
//            return Constant.region[selectedCity ?? ""]?.count ?? 0
//        }
//    }
//    
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if indexPath.section == 0 {
//          //  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.identifier, for: indexPath) as! CityCollectionViewCell
//            cell.binding(city: Constant.city[indexPath.row])
//            return cell
//        } else {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoroughCollectionViewCell.identifier, for: indexPath) as! BoroughCollectionViewCell
//            let boroughs = Constant.region[selectedCity!]!
//            cell.binding(borough: boroughs[indexPath.row])
//            return cell
//        }
//    }
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 2
//    }
//    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if indexPath.section == 0 {
//            self.selectedCity = Constant.city[indexPath.row]
//            self.collectionView.reloadData()
//        }
//    }
//}
//
