//
//  DataManager.swift
//  roam_ios
//
//  Created by Shubhang Dixit on 11/06/19.
//  Copyright © 2019 Shubhang Dixit. All rights reserved.
//

import Foundation
import Firebase
import UIKit
import CoreData
import GoogleSignIn


class DataManager {
    
    static let shared = DataManager()
    let ref = Database.database().reference()
    var rUser = RoamUser.init()
    
    func initialiseUser(user: User) {
        let user = RoamUser.init(firUser: user)
        rUser = user
    }
    
    func registerUser(user: User, userName : String, gender : Gender) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = userName
        changeRequest?.commitChanges {[weak self] (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                let user = RoamUser.init(firUser: user)
                self?.rUser = user
                NetworkManager.shared.updateUser(uid: user.userId, city: RoamCities.none.rawValue, gender: gender, success: { (success) in
                    print("User updated successfully")
                }, failure: { })
            }
        }
    }
    
    func registerGoogleUser(user: User) {
        let user = RoamUser.init(firUser: user)
        rUser = user
        NetworkManager.shared.updateGoogleUser(uid: user.userId
            , city: RoamCities.none.rawValue, gender: Gender.undisclosed,  success: { (success) in
                print("User updated successfully")
        }, failure: { })
    }
    

    
}
