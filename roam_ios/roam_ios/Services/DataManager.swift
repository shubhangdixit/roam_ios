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
    
    
}
