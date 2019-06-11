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
    
//    
//    static func initialiseDatabaseForGoogleSignIn() {
//        guard let uid = UserDefaults.standard.string(forKey: userIdUserDefaultKey) else { return }
//        guard let uname = UserDefaults.standard.string(forKey: userNameUserDefaultKey) else { return }
//        
//        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
//            
//            if snapshot.hasChild(uid){
//                //checking if google user DB exists
//                print(googleUserExists)
//                setGoogleUserProfileImage(name: uname, uid: uid)
//                
//            } else {
//                // if not create firebase DB entry for tht user
//                let profileImageURL = defaultBoyProfileImageUrl
//                // creating tree structure using dictionary to store on Firebase DB
//                
//                // in case of google sign in , we need to know gender of user thorugh this api
//                //updateProfileImageURL(name : uname, uid : uid)
//                
//                let userData = ["userName": uname , "language" : defaultLanguage, "gender": "boy", "smiley" : defaultSmileyList, "profileImageUrl" : profileImageURL] as [String : Any]
//                
//                // playlist contains list of all songs user adds to playlist
//                // initially user gets one song in playlist
//                // on final verison of product this video will be video abvout the app
//                // user can later delete this video from his playlist
//                
//                ref.child("users").child(uid).setValue(userData)
//                ref.child("users").child(uid).child("playlist").child("Kabali Song").setValue(defaultPlaylistSong)
//                setGoogleUserProfileImage(name: uname, uid: uid)
//                print("Successfully logged into Firebase with Google", uid)
//                
//            }
//            
//            
//        })
//        
//        
//    }
//    
//    static func updateProfileImageURL(name : String, uid : String) {
//        //abstracting first name of user
//        var components = name.components(separatedBy: " ")
//        let firstName = components.removeFirst()
//        let gender = GenderChecker.getGender(name: firstName)
//        if gender == "girl" {
//            let profileImageURL = defaultGirlProfileImageUrl
//            ref.child("users").child(uid).child("profileImageUrl").setValue(profileImageURL)
//            ref.child("users").child(uid).child("gender").setValue("girl")
//        }
//        
//    }
//    
//    static func setGoogleUserProfileImage(name : String, uid : String) {
//        if GIDSignIn.sharedInstance().currentUser != nil && GIDSignIn.sharedInstance().currentUser.profile.hasImage == true {
//            // getting profile image url from GIDSign in shared instance
//            
//            let imageUrl = GIDSignIn.sharedInstance().currentUser.profile.imageURL(withDimension: 400).absoluteString
//            // updating url each time in case the profile pic at google end is changed
//            
//            ref.child("users").child(uid).child("profileImageUrl").setValue(imageUrl)
//        } else {
//            updateProfileImageURL(name: name, uid: uid)
//        }
//        
//        
//    }
//    
//    static func completeMySignIn(id: String, userData: Dictionary<String, Any>) {
//        
//        let defaultPlaylist = ["Kabali Song" : defaultPlaylistSong] as [String : Any]
//        var userDataDictionary = userData
//        userDataDictionary.updateValue(defaultPlaylist, forKey: "playlist")
//        ref.child("users").child(id).setValue(userDataDictionary)
//        user = User(dictionary: userDataDictionary as [String : AnyObject])
//        user.userId = id
//        
//    }
//    
//    
//    
//    static func getSetting() {
//        
//        // get settings functions fetches user settings from firebase specific to his account
//        
//        guard let uid = UserDefaults.standard.string(forKey: userIdUserDefaultKey) else { return }
//        
//        ref.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
//            
//            if snapshot.hasChild("settings"){
//                let settingsRef = ref.child("users").child(uid).child("settings")
//                
//                settingsRef.observeSingleEvent(of: .value, with: { (snapshot) in
//                    if let userDict = snapshot.value as? [String: AnyObject] {
//                        videoOrder = (userDict["videoOrder"] as? String)!
//                        videoType = (userDict["videoType"] as? String)!
//                        videoLanguage = (userDict["videoLanguage"] as? String)!
//                        playAutomatic = (userDict["playAutomatic"] as? Bool)!
//                    }
//                })
//                
//                
//                
//            }else{
//                setSetting()
//            }
//        })
//        
//    }
//    
//    static func setSetting(){
//        
//        // set setting function update user setting to firebase
//        
//        guard let uid = UserDefaults.standard.string(forKey: userIdUserDefaultKey) else { return }
//        ref.child("users").child(uid).child("settings").setValue(defaultSettings)
//    }
//    
    
}

