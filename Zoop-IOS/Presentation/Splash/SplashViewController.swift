//
//  SplashViewController.swift
//  Zoop-IOS
//
//  Created by 류창휘 on 2022/01/29.
//

import UIKit

class SplashViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var signInButton: UIButton!
    

    @IBOutlet weak var loginButton: UIButton!
    
    
    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.signInButton.layer.cornerRadius = signInButton.frame.height / 2
        self.loginButton.layer.cornerRadius = loginButton.frame.height / 2

    }

    
    //MARK: - Actions

    @IBAction func loginBtn(_ sender: Any) {
        let loginVC = UserLogInViewController(nibName: "UserLoginViewController", bundle: nil)
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true, completion: nil)
        
    }
    @IBAction func signinBtn(_ sender: Any) {
        let signinVC = SignInViewController(nibName: "SignInViewController", bundle: nil)
        signinVC.modalPresentationStyle = .fullScreen
        self.present(signinVC, animated: true, completion: nil)
    }
    
}


    //MARK: - Extensions
