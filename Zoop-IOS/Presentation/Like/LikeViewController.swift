//
//  LikeViewController.swift
//  Zoop-IOS
//
//  Created by 재영신 on 2022/01/30.
//


import UIKit
import SnapKit
import TTGTags


    

final class LikeViewController: UIViewController {

    
    private var page = 0
    private var tickets: [Ticket] = []
    private var fetchingMore = false
 
    
    
   
  
    
    private lazy var boardCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width:UIScreen.main.bounds.width / 2.3, height:200.0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PostCollectionCell.self, forCellWithReuseIdentifier: PostCollectionCell.identifier)
        collectionView.register(HeaderCollectionCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionCell.identifier)
        return collectionView
    }()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        
        
        TicketNetworkManager.getLikeTickets { ticketList in
            guard let ticketList = ticketList else {
                let label = UILabel()
                label.text = "찜한 목록이 없습니다"
                label.font = .InterFont(.bold, size: 24.0)
                self.boardCollectionView.backgroundView = label
                return
            }
            self.tickets = ticketList.tickets
            self.boardCollectionView.reloadData()
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.bounds.size.height) {
            print("끝에 도달")
            if !fetchingMore {
                //beginFetch()
            }
        }
    }
}

extension LikeViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tickets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionCell.identifier, for: indexPath) as! PostCollectionCell
        cell.binding(ticket: tickets[indexPath.row])
        return cell
    }
    
    
    
}

extension LikeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailPageViewController(nibName: "DetailPageViewController", bundle: nil)
        let ticketId = self.tickets[indexPath.row].ticketId
        vc.ticketId = ticketId
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
private extension LikeViewController {
    func configureUI() {
        
        [
            boardCollectionView
        ].forEach {
            self.view.addSubview($0)
        }
        
      
        
        boardCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide).inset(16.0)
        }
        
    }
    
//    private func beginFetch() {
//        fetchingMore = true
//        let indicatorView = UIActivityIndicatorView()
//        self.view.addSubview(indicatorView)
//        indicatorView.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//        }
//        indicatorView.startAnimating()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: {
//            self.page += 1
//
//            TicketNetworkManager.getLikeTickets(completion: <#T##(TicketList?) -> Void#>)) { ticketList in
//                guard let ticketList = ticketList else {
//                    self.fetchingMore = false
//                    indicatorView.stopAnimating()
//                    return
//                }
//                indicatorView.stopAnimating()
//                self.tickets.append(contentsOf: ticketList.tickets)
//                self.fetchingMore = false
//                self.boardCollectionView.reloadData()
//
//            }
//
//        })
//    }
}


