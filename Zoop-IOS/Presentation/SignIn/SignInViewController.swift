import UIKit
import TweeTextField

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: TweeAttributedTextField!
    
    @IBOutlet weak var passwordTextField: TweeAttributedTextField!
    @IBOutlet weak var rePasswordTextField: TweeAttributedTextField!
    
    @IBOutlet weak var phoneTextField: TweeAttributedTextField!
    
    @IBOutlet weak var nameTextField: TweeAttributedTextField!
    
    @IBOutlet weak var signInBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.rePasswordTextField.delegate = self
        self.phoneTextField.delegate = self
        self.nameTextField.delegate = self
        self.signInBtn.layer.cornerRadius = 8

//        signInBtn.isEnabled = false

    }


    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func signInButton(_ sender: Any) {
        if emailTextField.text == "" || passwordTextField.text == "" || rePasswordTextField.text == "" || phoneTextField.text == "" || nameTextField.text == "" {
//            signInBtn.isEnabled = true
            
        } else {
            SignInUserInfo.email = emailTextField.text!
            SignInUserInfo.password = passwordTextField.text!
            SignInUserInfo.passwordCheck = rePasswordTextField.text!
            SignInUserInfo.phone = phoneTextField.text!
            SignInUserInfo.nickname = nameTextField.text!
            SignInDataManager().signInPostData()
            
            self.showIndicator()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.dismissIndicator()
                //여기서
            }
        }
        
        print()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func whileEditing(_ sender: TweeAttributedTextField) {
        if sender.tag == 1 {
            
            if let userInput = sender.text {
                if userInput.count == 0 {
                    return
                }
                
                if userInput.isValidEmail == true {
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
        }
        else if sender.tag == 2 {
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
    
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
