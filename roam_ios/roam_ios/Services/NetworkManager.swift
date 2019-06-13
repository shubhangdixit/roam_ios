//
//  NetworkManager.swift
//  roam_ios
//
//  Created by Shubhang Dixit on 09/06/19.
//  Copyright © 2019 Shubhang Dixit. All rights reserved.
//

import Foundation
import Firebase
import UIKit
import CoreData
//import GoogleSignIn


class NetworkManager {
    
    static let shared = NetworkManager()
    let ref = Database.database().reference()
    typealias successBlock  = (Any?) -> Void
    typealias failureBlock = ()-> Void
    
    func fetchUser(uid: String?, success: @escaping successBlock, failure: @escaping failureBlock) {
        
        guard let userId = uid else { failure() ; return }
        
        ref.child("users").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] { // referencing fireDB in a disctonary
                success(dictionary)
            }
        }, withCancel: {error in
            failure()
        })
    }
    
    func updateUser(uid: String?, city : String, gender : Gender , success: @escaping successBlock, failure: @escaping failureBlock) {
        guard let uid = uid else {
            failure()
            return
        }
        let dictionary = ["city" : city, "gender" : gender.rawValue] as [String : Any]
        ref.child("users").child(uid).setValue(dictionary)
        success(true)
    }
    
    func updateGoogleUser(uid: String?, city : String, gender : Gender , success: @escaping successBlock, failure: @escaping failureBlock) {
        guard let uid = uid else {
            failure()
            return
        }
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if snapshot.hasChild(uid){
                //checking if google user DB exists
                print(googleUserExists)
                success(true)
            } else {
                self.updateUser(uid: uid, city: city, gender: gender, success: success, failure: failure)
            }
        })
    }
    
    func signOut(success: @escaping successBlock) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            UserDefaults.standard.set(nil, forKey: userIdUserDefaultKey)
            UserDefaults.standard.set(nil, forKey: userNameUserDefaultKey)
            success(true)
        } catch let signOutError as NSError {
            print(signOutError)
            success(false)
        }
    }
    
    func fetchProductList(success: @escaping successBlock, failure: @escaping failureBlock) {
        ref.child("products").observeSingleEvent(of: .value, with: { (snapshot) in
            if let prodDict = snapshot.value as? [String: AnyObject] {
                success(prodDict)
            } else {
                failure()
            }
        })
    }
    
}

