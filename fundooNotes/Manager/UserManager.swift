//
//  UserManager.swift
//  fundooNotes
//
//  Created by Yashom on 27/03/22.
//

import Foundation
import GoogleSignIn
import Firebase

class UserManager {
    
    static let shared = UserManager()
    
    private init() { }
    
    func saveGoogleToken(token: String?) {
        UserDefaults.standard.set(token, forKey: UserDefaultsKeys.uid)
    }
    
    func getToken() -> String? {
        UserDefaults.standard.string(forKey: UserDefaultsKeys.uid)
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.uid)
    }
    
    func isUserLoggedIn() -> Bool {
//        getToken() != nil
        return Auth.auth().currentUser?.uid != nil
    }
}
