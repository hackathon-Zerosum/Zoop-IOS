//
//  RegionSelectViewContrller.swift
//  Zoop-IOS
//
//  Created by 재영신 on 2022/01/29.
//

import UIKit
import SnapKit

final class RegionSelectViewController: UIViewController {
    
    private var selectedIndex: Int?
    
    private lazy var cityTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .mainColor
        tableView.register(CityCell.self, forCellReuseIdentifier: CityCell.identifier)
        return tableView
    }()
    
    private lazy var boroughTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .mainColor
        tableView.register(BoroughCell.self, forCellReuseIdentifier: BoroughCell.identifier)
        return tableView
    }()
    
    private lazy var backgroundViewLabel: UILabel = {
        let label = UILabel()
        label.font = .InterFont(.bold, size: 24.0)
        label.text = "도시를 선택해주세요."
        label.numberOfLines = 0
        label.textColor = .white
        label.sizeToFit()
        return label
    }()
    private lazy var defaultBackgroudView: UIView = {
       let view = UIView()
        let imageView = UIImageView()
        imageView.image = UIImage(named: "zooplogo_1")
        view.addSubview(backgroundViewLabel)
        view.addSubview(imageView)
        view.backgroundColor = .mainColor
        backgroundViewLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.bottom.equalTo(backgroundViewLabel.snp.top).offset(-16.0)
            make.centerX.equalToSuperview()
        }
        view.isHidden = true
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
}

private extension RegionSelectViewController {
    func configureUI() {
        
        [
            self.cityTableView,
            self.boroughTableView,
            self.defaultBackgroudView
        ].forEach {
            self.view.addSubview($0)
        }
        
        self.cityTableView.snp.makeConstraints { make in
            make.leading.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.width.equalTo(self.view.frame.width / 3.0)
        }
        
        self.boroughTableView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalTo(self.cityTableView.snp.trailing)
        }
        
        self.defaultBackgroudView.snp.makeConstraints { make in
            make.edges.equalTo(boroughTableView)
        }
    }
    
    func showBackgrondView(isShow: Bool) {
        print(isShow)
        if isShow {
            self.defaultBackgroudView.isHidden = false
                self.boroughTableView.isHidden = true
        } else {
            self.defaultBackgroudView.isHidden = true
                self.boroughTableView.isHidden = false
        }
    }
}

extension RegionSelectViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.cityTableView {
            return Constant.city.count
        }
        if tableView == self.boroughTableView {
            guard let index = selectedIndex else {
               showBackgrondView(isShow: true)
                return 0
            }
            let selectedCity = Constant.city[index]
            guard let count = Constant.region[selectedCity]?.count else {
                return 0
            }
            showBackgrondView(isShow: count == 0)
            print(count)
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.cityTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.identifier, for: indexPath) as! CityCell
            cell.binding(city: Constant.city[indexPath.row])
            
            let view = UIView()
            view.backgroundColor = .mainColor
            cell.selectedBackgroundView = view
            return cell
        }
        if tableView == self.boroughTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: BoroughCell.identifier, for: indexPath) as! BoroughCell
            cell.accessoryType = .disclosureIndicator
            guard let index = selectedIndex else { return UITableViewCell() }
            let selectedCity = Constant.city[index]
            let boroughs = Constant.region[selectedCity]!
            cell.binding(borough: boroughs[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    
}

extension RegionSelectViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if backgroundViewLabel.text == "도시를 선택해주세요." {
            backgroundViewLabel.text = "서비스 준비중 입니다."
        }
        if tableView == self.cityTableView {
            guard let selectedIndex = selectedIndex else {
                self.selectedIndex = indexPath.row
                let cell = tableView.cellForRow(at: indexPath) as! CityCell
                self.boroughTableView.reloadData()
                cell.update(isSelected: true)
                return
            }
            
            let selectedCell = tableView.cellForRow(at: IndexPath(row: selectedIndex, section: 0)) as! CityCell
            selectedCell.update(isSelected: false)
            self.selectedIndex = indexPath.row
            let newSelectedCell = tableView.cellForRow(at: indexPath) as! CityCell
            newSelectedCell.update(isSelected: true)
           
            self.boroughTableView.reloadData()
        }
        
        if tableView == self.boroughTableView {
            guard let index = selectedIndex else {
                 return
            }
            let city = Constant.city[index]
            let boroughs = Constant.region[city]!
            let borough = boroughs[indexPath.row]
            let vc = DateSelectViewController(city: city, borough: borough)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

import SwiftUI
struct RegionSelectViewController_Priviews: PreviewProvider {
    static var previews: some View {
        Contatiner().edgesIgnoringSafeArea(.all)
    }
    struct Contatiner: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            let vc = RegionSelectViewController() //보고 싶은 뷰컨 객체
            return UINavigationController(rootViewController: vc)
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
        typealias UIViewControllerType =  UIViewController
    }
}
