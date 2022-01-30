//
//  UserLogInViewController.swift
//  Zoop-IOS
//
//  Created by 류창휘 on 2022/01/30.
//

import UIKit
import TweeTextField
import FirebaseMessaging
class UserLogInViewController: UIViewController {
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var myemailTextField: TweeAttributedTextField!
    
    @IBOutlet weak var mypasswordTextField: TweeAttributedTextField! 
       
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginBtn.layer.cornerRadius = 8
        
        self.myemailTextField.delegate = self
        self.mypasswordTextField.delegate = self
        
        // Do any additional setup after loading the view.
    }



    @IBAction func loginWhileEdit(_ sender: TweeAttributedTextField) {
        if sender.tag == 1 {
            
            if let myUserInput = sender.text {
                if myUserInput.count == 0 {
                    return
                }
                if myUserInput.isValidEmail == true {
                    sender.infoTextColor = UIColor.projectTintColor
                    sender.showInfo("이메일 형식입니다.", animated: true)
                    sender.layer.borderColor = UIColor.projectTintColor.cgColor
                    sender.layer.borderWidth = 1
                } else {
                    sender.infoTextColor = .red
                    sender.showInfo("이메일 형식이 아닙니다.", animated: true)
                    sender.layer.borderWidth = 1
                    sender.layer.borderColor = UIColor.red.cgColor
                    
                }
            }
            
        } else if sender.tag == 2 {
            if let passwordInput = sender.text {
                if passwordInput.count == 0 {
                    return
                }
                if passwordInput.isValidPassword == true {
                    sender.infoTextColor = UIColor.projectTintColor
                    sender.showInfo("비밀번호 형식입니다.", animated:  true)
                    sender.layer.borderColor = UIColor.projectTintColor.cgColor
                    sender.layer.borderWidth = 1
                    
                } else {
                    sender.infoTextColor = .red
                    sender.showInfo("비밀번호 형식이 아닙니다.", animated: true)
                    sender.layer.borderWidth = 1
                    sender.layer.borderColor = UIColor.red.cgColor
                }
            }

            
        }
        
        
    }
    
    
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func loginButton(_ sender: Any) {
            LogInUserInfo.email = myemailTextField.text!
            LogInUserInfo.password = myemailTextField.text!
        let appdelegate =  UIApplication.shared.delegate as! AppDelegate
        
        LogInUserInfo.deviceToken = appdelegate.device_Token
        LogInUserInfo.deviceName = "IOS"

            LogInDataManager().logInPostData()

            self.showIndicator()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                let tabBarController = UITabBarController()
                let vcs = TabBarItem.allCases.map { item -> UIViewController in
                    let vc = item.vc
                    vc.tabBarItem = UITabBarItem(title: item.title, image: item.icon, selectedImage: item.icon)
                    return vc
                }
                tabBarController.viewControllers = vcs
                tabBarController.modalPresentationStyle = .fullScreen
                self.dismissIndicator()
                self.present(tabBarController,animated: true)
            }
        }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}


extension UserLogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
