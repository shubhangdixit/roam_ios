//
//  RoamUser.swift
//  roam_ios
//
//  Created by Shubhang Dixit on 09/06/19.
//  Copyright © 2019 Shubhang Dixit. All rights reserved.
//

import Foundation
import UIKit
import Firebase

enum UserType {
    case registered
    case guest
}

enum RoamCities : String {
    case bangalore = "Bangalore", delhi = "Delhi", chennai = "Chennai", kolkata = "Kolkata", lucknow = "Lucknow", ahmadabad = "Ahmedabad", mumbai = "Mumbai", nagpur = "Nagpur", pune = "Pune", trivendrum = "Thiruvananhtpuram", kanyakumari = "Kanyakumari", jammuCity = "Jammu City", none = "Not Selected"
    static let allValues = [bangalore, delhi, chennai, kolkata, lucknow, ahmadabad, mumbai, nagpur, pune, trivendrum, kanyakumari, jammuCity, none]
}

public enum Gender : Character {
    case male = "M", female = "F", undisclosed = "T"
}

class RoamUser: NSObject {
    var userName: String?
    var gender: Gender = .undisclosed
    var userId : String?
    var userType : UserType = .guest
    var usercity : RoamCities = .none
    var firebaseUser : User?
    var firebaseUserDataisLoaded : Bool = false
    
    override init(){
        super.init()
        userName = ""
        userId = ""
    }
    
    init(firUser : User) {
        super.init()
        firebaseUser = firUser
        userName = firUser.displayName
        userId = firUser.uid
        userType = .registered
        loadUserDataFromFirebase()
        saveDataToDefaults()
    }
    
    func saveDataToDefaults() {
        UserDefaults.standard.set(userId, forKey: userIdUserDefaultKey)
        UserDefaults.standard.set(userName, forKey: userNameUserDefaultKey)
    }
    
    func loadUserDataFromFirebase() {
        NetworkManager.shared.fetchUser(uid: userId, success: {[weak self] (data) in
            if let dictionary = data as? [String: AnyObject] {
                self?.firebaseUserDataisLoaded = true
                if let city = dictionary["city"] as? String {
                    self?.usercity = RoamCities.init(rawValue: city) ?? .none
                }
                if let gender = dictionary["gender"] as? Character {
                    self?.gender = Gender.init(rawValue: gender) ?? .undisclosed
                }
            }
        }) { [weak self] in
            self?.firebaseUserDataisLoaded = false
        }
    }
    
}
