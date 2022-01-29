//
//  DateSelectViewController.swift
//  Zoop-IOS
//
//  Created by 재영신 on 2022/01/29.
//

import UIKit
import SnapKit
import FSCalendar

final class DateSelectViewController: UIViewController {
    
    private let city: String
    private let borough: String
    private var selectedDate: Int = 0
    init(city: String, borough: String) {
        self.city = city
        self.borough = borough
        print("city , borough",city,borough)
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
    
    private lazy var calander: FSCalendar = {
        let calendar = FSCalendar()
        calendar.appearance.selectionColor = .mainColor
        calendar.delegate = self
        calendar.allowsMultipleSelection = true
        return calendar
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("완료", for: .normal)
        button.backgroundColor = .mainColor
        button.tintColor = .white
        button.layer.cornerRadius = 8.0
        button.addTarget(self, action: #selector(didTapDoneButton), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    
}

private extension DateSelectViewController {
    func setButtonState(isEnabled: Bool) {
        if isEnabled {
            self.doneButton.isEnabled = isEnabled
            self.doneButton.backgroundColor = .mainColor
        } else {
            self.doneButton.isEnabled = isEnabled
            self.doneButton.backgroundColor = .gray
        }
    }
    func configureUI() {
        self.view.backgroundColor = .systemBackground
        
        [
            self.searchView,
            self.calander,
            self.doneButton
        ].forEach {
            self.view.addSubview($0)
        }
        
        [
            self.searchImageView,
            self.searchLabel
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
        
        calander.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16.0)
            make.top.equalTo(self.searchView.snp.bottom).offset(16.0)
        }
        
        doneButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-16.0)
            make.top.equalTo(self.calander.snp.bottom).offset(32.0)
            make.width.equalTo(165.0)
            make.height.equalTo(56.0)
            make.centerX.equalToSuperview()
        }
        setButtonState(isEnabled: false)
    }
    
    @objc func didTapDoneButton() {
        let calenders = self.calander.selectedDates.map { date in
            date.text.split(separator: " ")[0]
        }
        let sortedCalander = calenders.sorted(by: <)
      
        let vc = TicketListViewController(city: self.city, borough: self.borough,start: String(sortedCalander[0]),end: String(sortedCalander[1]))
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension DateSelectViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
               // 날짜 2개까지만 선택되도록
               if calendar.selectedDates.count >= 2 {
                   return false
               } else {
                  
                   return true
               }
           }
    
    //선택해제
        func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
                //return false // 선택해제 불가능
                return true // 선택해제 가능
            }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date)
        if calendar.selectedDates.count == 2 {
            self.calander.appearance.titleDefaultColor = .gray
            setButtonState(isEnabled: true)
        } else {
            setButtonState(isEnabled: false)
        }
        print("selected")
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if calander.selectedDates.count == 1 {
            self.calander.appearance.titleDefaultColor = .label
            setButtonState(isEnabled: false)
        }
    }
}


import SwiftUI

struct DateSelectViewController_Priview: PreviewProvider {
    static var previews: some View {
        Contatiner().edgesIgnoringSafeArea(.all)
    }
    struct Contatiner: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            let vc = DateSelectViewController(city: "서울", borough: "강남구") //보고 싶은 뷰컨 객체
            return UINavigationController(rootViewController: vc)
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
        typealias UIViewControllerType =  UIViewController
    }
}
