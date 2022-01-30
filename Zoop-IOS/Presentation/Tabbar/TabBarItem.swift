//
//  enum.swift
//  Zoop-IOS
//
//  Created by 재영신 on 2022/01/30.
//

import Foundation
import UIKit

enum TabBarItem: CaseIterable {
    case home
    case card
    case like
    case myPage
    
    var vc: UIViewController {
        switch self {
        case .home:
            return UINavigationController(rootViewController: HomeViewController())
        case .card:
            return TicketViewController(nibName: "TicketViewController", bundle: nil)
        case .like:
            return InterestViewController()
        case .myPage:
            return MyPageViewController()
        }
    }
    
    var icon: UIImage {
        switch self {
        case .home:
            return UIImage(named: "홈")!
        case .card:
            return UIImage(named: "티켓")!
        case .like:
            return UIImage(named: "찜")!
        case .myPage:
            return UIImage(named: "smile")!
        }
    }
    
    var title: String {
        switch self {
        case .home:
            return "홈"
        case .card:
            return "티켓"
        case .like:
            return "찜"
        case .myPage:
            return "마이페이지"
        }
    }
}
