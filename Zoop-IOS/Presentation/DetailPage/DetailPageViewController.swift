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
    
    @IBOutlet weak var heartButton: UIButton! {
        didSet {
            heartButton.sizeToFit()
        }
    }
    @IBOutlet weak var ticketBeginLabel: UILabel!
    @IBOutlet weak var ticketEndLabel: UILabel!
    
    @IBOutlet weak var expiredDateLabel: UIButton!
    
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    
    @IBOutlet weak var sellingLabel: UILabel!
    var ticketId: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.buyingButton.layer.cornerRadius = 8
        self.timerButton.layer.cornerRadius = 8
        self.timerButton.layer.borderWidth = 2
        self.timerButton.layer.borderColor = UIColor.projectTintColor.cgColor
        
        if let ticketId = ticketId {
            DetailPageDataManager().DetailPageData(ticketId: ticketId, self)
        }
        
        

    }

    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func heartButton(_ sender: Any) {
        TicketNetworkManager.updateLiketTicket(ticketId: self.ticketId!) { isLiked in
            if isLiked.likes {
                self.heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                self.heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
    }
    
    @IBAction func didTapBuyButton(_ sender: Any) {
        
        let tabbarController = self.presentingViewController as! UITabBarController
        let vc = tabbarController.viewControllers![1] as! TicketViewController
        vc.ticketId = self.ticketId!
        tabbarController.selectedViewController = vc
        self.dismiss(animated: true, completion: nil)
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
        
        if response.able == false {
            self.buyingButton.backgroundColor = .gray
            self.buyingButton.isEnabled = false
        }
        
        if response.likes {
            self.heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            self.heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
}
