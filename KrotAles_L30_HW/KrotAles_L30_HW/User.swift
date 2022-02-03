//
//  NewUser.swift
//  KrotAles_L30_HW
//
//  Created by Ales Krot on 2.02.22.
//

import Foundation

struct User {
    let login: String
    let password: String
    
    init(login: String, password: String){
        self.login = login
        self.password = password
    }
}
