//
//  ViewController.swift
//  KrotAles_L30_HW
//
//  Created by Ales Krot on 2.02.22.
//

import UIKit
import Security

class RootViewController: UIViewController {
    
    let credentialStorage = CredentialsKeychainStorage()
    var domain = "reminder.app"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavigationBar()
        
        let token = credentialStorage.check(for: domain)
        if token == nil {
            checkAutorization()
        } else {
            print("I have been authorized")
        }
    }
    private func setupNavigationBar(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func checkAutorization(){
        let loginViewController = LoginViewController()
        loginViewController.modalPresentationStyle = .fullScreen
        present(loginViewController, animated: true, completion: nil)
    }
}

