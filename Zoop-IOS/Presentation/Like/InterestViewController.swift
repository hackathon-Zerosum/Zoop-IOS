//
//  InterestViewController.swift
//  Zoop-IOS
//
//  Created by 재영신 on 2022/01/30.
//

import UIKit
import SnapKit
import Tabman
import Pageboy

final class InterestViewController: TabmanViewController {
    private var vcs: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [
            LikeViewController(),
            InterestListViewController()
        ].forEach {
            self.vcs.append($0)
        }
        self.dataSource = self

              // Create bar
        let bar = TMBar.TabBar()
        bar.layout.transitionStyle = .snap // Customize
       bar.layout.contentInset = UIEdgeInsets(top: 10.0, left: 0, bottom: 30.0, right: 0)
              // Add to view
     
        addBar(bar, dataSource: self, at: .top)
        
    }
}

extension InterestViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
      let item = TMBarItem(title: "")
       
        if index == 0 {
            item.title = "찜"
            item.image = UIImage(systemName: "suit.heart.fill")
            item.image?.withTintColor(.mainColor)
        } else if index == 1 {
            item.title = "관심목록"
            item.image = UIImage(systemName: "cart.fill.badge.minus")
        }
  
        // ↑↑ 이미지는 이따가 탭바 형식으로 보여줄 때 사용할 것이니 "이미지가 왜 있지?" 하지말고 넘어가주세요.
        
        return item
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return vcs.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return vcs[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}
