//
//  ViewController.swift
//  KrotAles_L30_HW
//
//  Created by Ales Krot on 2.02.22.
//

import UIKit
import Security

class RootViewController: UIViewController {
    @IBOutlet weak var userLabel: UILabel!
    
    let credentialStorage = CredentialsKeychainStorage()
    var domain = "reminder.app"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let token = credentialStorage.check(for: domain)
        if token == nil {
            makeAutorization()
        } else {
            print("I have been authorized")
        }
    }
//    private func setupNavigationBar(){
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
//    }
    
    private func makeAutorization(){
        let loginViewController = LoginViewController()
        loginViewController.modalPresentationStyle = .automatic
        present(loginViewController, animated: true, completion: nil)
    }
}

extension RootViewController: LoginViewControllerDelegate {
    func loginViewController(_ controller: LoginViewController, didCreateNew user: User) {
        userLabel.text = user.login
    }
}
