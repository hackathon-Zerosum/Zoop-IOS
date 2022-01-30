//
//  InterestListViewController.swift
//  Zoop-IOS
//
//  Created by 재영신 on 2022/01/30.
//

import UIKit
import SnapKit

final class InterestListViewController: UITableViewController {
    private var regions: [InterestRegion] = []
 


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        tableView.register(InterestListCell.self, forCellReuseIdentifier: InterestListCell.identifier)
        RegionNetworkManager.getInterestRegion { [weak self]regions in
            self?.regions = regions
            self?.tableView.reloadData()
        }
    }

    
}

extension InterestListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.regions.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InterestListCell.identifier, for: indexPath) as! InterestListCell
        cell.binding(name: self.regions[indexPath.row].name)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    
}
