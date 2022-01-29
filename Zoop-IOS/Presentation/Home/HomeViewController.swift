//
//  HomeViewController.swift
//  Zoop-IOS
//
//  Created by 재영신 on 2022/01/29.
//

import UIKit
import SnapKit

final class HomeViewController: BaseViewController {
    
    private lazy var searchView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 100.0
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.mainColor.cgColor
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
    override func viewDidLoad() {
        super.viewDidLoad()
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
