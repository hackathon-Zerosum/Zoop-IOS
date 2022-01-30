//
//  TicketViewController.swift
//  Zoop-IOS
//
//  Created by 류창휘 on 2022/01/30.
//

import UIKit

class TicketViewController: UIViewController {
    
    @IBOutlet weak var upperTicketView: UIView!
    @IBOutlet weak var bottomTicketView: UIView!
    
    @IBOutlet weak var ticketLabel: UILabel!
    @IBOutlet weak var ticketImage: UIImageView! {
        didSet {
            ticketImage.contentMode = .scaleAspectFill
        }
    }
    
    var ticketId: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.upperTicketView.layer.cornerRadius = 12
        self.bottomTicketView.layer.cornerRadius = 12

        
        TicketNetworkManager.getBuyTicket(ticketId: ticketId ?? -1) { image in
            print(image)
            self.ticketImage.kf.setImage(with: URL(string: image) ?? URL(string: ""))
        }
    }




}
