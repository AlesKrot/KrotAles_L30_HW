//
//  Server.swift
//  KrotAles_L30_HW
//
//  Created by Ales Krot on 2.02.22.
//

import Foundation

class Server {
    private var dictionary = [String: User]()
    private let concurrentQueue = DispatchQueue(label: "app.reminder.server", attributes: .concurrent)
    
    private func add(user: User) {
        dictionary[user.login] = user
        print(dictionary)
    }
    
    private func remove(){
        self.dictionary.removeAll()
    }
    
    func signIn(user: User) -> String {
        var json = ""
        let password = dictionary[user.login]?.password
        concurrentQueue.async {
            if self.dictionary[user.login] == nil {
                self.add(user: user)
            } else if password == user.password {
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted
                let data = try! encoder.encode(user)
                json = (String(data: data, encoding: .utf8)!)
                print(json)
            } else {
                print("I have this user")
            }
        }
        return json
    }
}
