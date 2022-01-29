//
//  TicketListViewController.swift
//  Zoop-IOS
//
//  Created by 재영신 on 2022/01/30.
//

import UIKit
import SnapKit
import TTGTags

enum Category: Int, Decodable, CaseIterable {
    case lodging = 1
    case landmark = 2
    case activity = 3
    case transportation = 4
    
    var tag: String {
        switch self {
        case .lodging:
            return "숙소"
        case .landmark:
            return "랜드마크"
        case .activity:
            return "액티비티"
        case .transportation:
            return "교통/이동수단"
        }
    }
    
    var image: UIImage {
        switch self {
        case .lodging:
            return UIImage(named: "숙소")!
        case .landmark:
            return UIImage(named: "랜드마크")!
        case .activity:
            return UIImage(named: "액티비티")!
        case .transportation:
            return UIImage(named: "교통")!
        }
    }
    
    var title: String {
        switch self {
        case .lodging:
            return """
            "도심을 벗어나
            자연과 하나되기
            """
        case .landmark:
            return """
            올 겨울 꼭 가봐야할
            야경 맛집
            """
        case .activity:
            return     """
        상쾌한 바람 마음껏
        즐길 명소
        """
        case .transportation:
            return """
귀성길, 혼잡한 도로
대신 기차는 어때요?!
"""
        }
    }
}

final class TicketListViewController: UIViewController {
    private let city: String
    private let borough: String
    private let start: String
    private let end: String
    private let tags = Category.allCases.map { $0.tag} + ["잉여","잉여","잉여"]
    private var page = 0
    private var tickets: [Ticket] = []
    private var fetchingMore = false
    private var selectedCategory: Category = .lodging
    init(city: String, borough: String, start: String, end: String) {
        self.city = city
        self.borough = borough
        self.start = start
        self.end = end
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var searchView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.mainColor.cgColor
        view.layer.cornerRadius = 28.0
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
        label.text = "\(city) \(borough)"
        label.textColor = .mainColor
        return label
    }()
    
    private lazy var sortButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "sortButton"), for: .normal)
        return button
    }()
    
    private lazy var boardCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width:UIScreen.main.bounds.width / 2 - 15.0, height:200.0)
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 140.0 )
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PostCollectionCell.self, forCellWithReuseIdentifier: PostCollectionCell.identifier)
        collectionView.register(HeaderCollectionCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionCell.identifier)
        return collectionView
    }()
    private lazy var tagCollectionView: TTGTextTagCollectionView = {
        let tagView = TTGTextTagCollectionView()
        tagView.numberOfLines = 1
        tagView.scrollDirection = .horizontal
        tagView.showsHorizontalScrollIndicator = false
        tagView.selectionLimit = 1
        tagView.delegate = self
        let insetValue: CGFloat = 16.0
        tagView.contentInset = UIEdgeInsets(
            top: insetValue,
            left: insetValue,
            bottom: insetValue,
            right: insetValue)
        
        let cornerRadiusValue: CGFloat = 12.0
        let shadowOpacity: CGFloat = 0.0
        let extraSpace = CGSize(width: 20.0, height: 12.0)
        let color = UIColor.mainColor
        let style = TTGTextTagStyle()
        
        style.backgroundColor = color
        style.cornerRadius = cornerRadiusValue
        style.borderWidth = 0.0
        style.shadowOpacity = shadowOpacity
        style.extraSpace = extraSpace
        
        let selectedStyle = TTGTextTagStyle()
        selectedStyle.backgroundColor = .white
        selectedStyle.cornerRadius = cornerRadiusValue
        selectedStyle.shadowOpacity = shadowOpacity
        selectedStyle.extraSpace = extraSpace
        selectedStyle.borderColor = color
        
        tags.forEach{
            let font = UIFont.InterFont(.semiBold, size: 12.0)
            let tagContents = TTGTextTagStringContent(
                text: $0,
                textFont: font,
                textColor: .white
            )
            let selectedTagContents = TTGTextTagStringContent(
                text: $0,
                textFont: font,
                textColor: color
            )
            let tag = TTGTextTag(
                content: tagContents,
                style: style,
                selectedContent: selectedTagContents,
                selectedStyle: selectedStyle
            )
            tagView.addTag(tag)
        }
        return tagView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        
        TicketNetworkManager.getTickets(region: 1, begin: start, end: end, category: 1, page: page, sort: 1) { ticketList in
            guard let ticketList = ticketList else {
                return
            }
            print(ticketList.tickets)
            self.tickets = ticketList.tickets
            self.boardCollectionView.reloadData()
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.bounds.size.height) {
            print("끝에 도달")
            if !fetchingMore {
                beginFetch()
            }
        }
    }
}

extension TicketListViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tickets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionCell.identifier, for: indexPath) as! PostCollectionCell
        cell.binding(ticket: tickets[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind ==  UICollectionView.elementKindSectionHeader {
            let headerview = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionCell.identifier, for: indexPath) as! HeaderCollectionCell
            
            headerview.binding(category: self.selectedCategory)
            print(headerview.frame)
            return headerview
        }
        return UICollectionReusableView()
    }
    
}

extension TicketListViewController: UICollectionViewDelegate {
    
}
private extension TicketListViewController {
    func configureUI() {
        
        [
            searchView,
            sortButton,
            tagCollectionView,
            boardCollectionView
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
        
        sortButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16.0)
            make.top.equalTo(searchView.snp.bottom).offset(16.0)
            make.width.height.equalTo(36.0)
        }
        
        tagCollectionView.snp.makeConstraints { make in
            make.leading.equalTo(sortButton.snp.trailing).offset(8.0)
            make.top.equalTo(searchView.snp.bottom).offset(8.0)
            make.trailing.equalToSuperview().inset(16.0)
        }
        
        boardCollectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(8.0)
            make.top.equalTo(tagCollectionView.snp.bottom).offset(16.0)
        }
        
    }
    
    private func beginFetch() {
        fetchingMore = true
        let indicatorView = UIActivityIndicatorView()
        self.view.addSubview(indicatorView)
        indicatorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        indicatorView.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: {
            self.page += 1
            
            TicketNetworkManager.getTickets(region: 1, begin: self.start, end: self.end, category: 1, page: self.page, sort: 1) { ticketList in
                guard let ticketList = ticketList else {
                    self.fetchingMore = false
                    indicatorView.stopAnimating()
                    return
                }
                indicatorView.stopAnimating()
                self.tickets.append(contentsOf: ticketList.tickets)
                self.fetchingMore = false
                self.boardCollectionView.reloadData()
                
            }
            
        })
    }
}


extension TicketListViewController: TTGTextTagCollectionViewDelegate {
    func textTagCollectionView(
        _ textTagCollectionView: TTGTextTagCollectionView!
        , didTap tag: TTGTextTag!,
        at index: UInt)
    {
        guard tag.selected else { return }
        print(Int(index))
        self.selectedCategory = Category.allCases[Int(index)]
        self.boardCollectionView.reloadData()
        self.boardCollectionView.scrollsToTop = true
    }
}
