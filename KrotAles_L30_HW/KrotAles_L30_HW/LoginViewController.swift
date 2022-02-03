//
//  LoginViewController.swift
//  KrotAles_L30_HW
//
//  Created by Ales Krot on 2.02.22.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func loginViewController(_ controller: LoginViewController, didCreateNew user: User)
}

class LoginViewController: UIViewController {
    @IBOutlet weak var authorizationLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    weak var delegate: LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }
    @IBAction func didPressSignInButton(_ sender: UIButton) {
        guard let login = loginTextField.text,
              let password = passwordTextField.text,
              login.count > 3,
              password.count > 0 else { return }
        let newUser = User(login: login, password: password)
        
        let server = Server()
        let infoJSON = server.signIn(user: newUser)
        
        dismiss(animated: true, completion: {
            self.delegate?.loginViewController(self, didCreateNew: newUser)
        })
    }
    
    @IBAction func didPressCloseButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
