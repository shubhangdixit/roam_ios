//
//  Constants.swift
//  roam_ios
//
//  Created by Shubhang Dixit on 09/06/19.
//  Copyright © 2019 Shubhang Dixit. All rights reserved.
//

import Foundation

let appTitle = "Roam"
let appUrl = "app_url"
let appInfoMesg = "Developed By Shubhang Dixit"

//errors

enum ErrorMesseges : String {
    case invalidEmail = "Invalid Email"
    case passwordNotMatched = "Password Not Matchced"
    case passwordLength = "Password length"
    case signOutError = "error SignOut!"
    case logOutAlert = "logout!"
    
    func getDetail() -> String {
        switch self {
        case .invalidEmail:
            return " Pls Enter Valid email address"
        case .passwordNotMatched:
            return "Please re enter passwords! Follow Guidelines"
        case .passwordLength:
            return "Password length should be atleast 6 characters"
        case .signOutError:
            return "check your network connection and try again."
        case .logOutAlert:
            return "do you want to logout?"
        }
    }
}

// general
let notificationIdentifier = "NotificationIdentifier"
let googleUserExists = "Google user already exists"

//userDefaultsEkey

let userIdUserDefaultKey = "userId"
let userNameUserDefaultKey = "userName"
let pngExtension = ".png"
let jpgExtension = ".jpg"



struct ViewControllersIdentifiers {
    let productListVC = "ProductListsViewController"
    let signInVC = "SignInViewController"
}
let vCIdentifiers = ViewControllersIdentifiers()

struct FIRDatabaseNodeNames {
    //let userName = "userName"
}
let fIRDatabaseNodeNames = FIRDatabaseNodeNames()
