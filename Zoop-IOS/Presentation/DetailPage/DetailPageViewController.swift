//
//  DetailPageViewController.swift
//  Zoop-IOS
//
//  Created by 류창휘 on 2022/01/30.
//

import UIKit
import Kingfisher

class DetailPageViewController: UIViewController {
    @IBOutlet var timerButton: UIButton!
    
    @IBOutlet var buyingButton: UIButton!
    
    @IBOutlet weak var detailImageView: UIImageView!
    
    @IBOutlet weak var sellerImageView: UIImageView!
    @IBOutlet weak var sellerName: UILabel!
    
    @IBOutlet weak var ticketNameLabel: UILabel!
    
    @IBOutlet weak var ticketBeginLabel: UILabel!
    @IBOutlet weak var ticketEndLabel: UILabel!
    
    @IBOutlet weak var expiredDateLabel: UIButton!
    
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    
    @IBOutlet weak var sellingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.buyingButton.layer.cornerRadius = 8
        self.timerButton.layer.cornerRadius = 8
        self.timerButton.layer.borderWidth = 2
        self.timerButton.layer.borderColor = UIColor.projectTintColor.cgColor
        
        DetailPageDataManager().DetailPageData(self)
        

    }

    
    @IBAction func cancelButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func heartButton(_ sender: Any) {
    }
    


}

extension DetailPageViewController {
    func didSuccess(_ response: DetailPageResponse) {
        self.ticketNameLabel.text = response.ticket.name
        self.sellerName.text = response.seller.nickname
        self.detailImageView.kf.setImage(with: URL(string: response.ticket.image))
        self.sellerImageView.kf.setImage(with: URL(string: response.seller.avatar ?? ""))
        self.ticketBeginLabel.text = response.ticket.beginAt
        self.ticketEndLabel.text = response.ticket.endAt
        self.expiredDateLabel.setTitle(response.ticket.expiredAt, for: .normal)
        self.originLabel.text = String(response.ticket.originPrice)
        self.discountLabel.text = String(response.ticket.discount)
        self.sellingLabel.text = String(response.ticket.sellingPrice)
    }
}
