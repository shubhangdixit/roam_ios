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
    case incorrectFields = "Incorrect Fields"
    case noConnection = "No Connection"
    case alreadyOwned = "already Owned"
    case smileyRemoveError = "Can not remove"
    case genderNotSelected = "Gender not set"
    case passwordLength = "Password length"
    case signOutError = "error SignOut!"
    
    func getDetail() -> String {
        switch self {
        case .invalidEmail:
            return " Pls Enter Valid email address"
        case .passwordNotMatched:
            return "Please re enter passwords! Follow Guidelines"
        case .incorrectFields:
            return "Failed , Check all feilds"
        case .noConnection:
            return "Please enable internet settings"
        case .alreadyOwned:
            return "already Owned!"
        case .smileyRemoveError:
            return "You cant empty your emotions"
        case .genderNotSelected:
            return "Please set your gender."
        case .passwordLength:
            return "Password length should be atleast 6 characters"
        case .signOutError:
            return "check your network connection and try again."
        }
    }
}
enum AlertMesseges : String {
    case removeTagFromTagList = "Remove Tag?"
    case maximumTagLimit = "Maximum Tag Limit is 4 "
    case smileyAdded = "smiley added"
    case removeEmotion = "Remove Emotion"
    case logoutALert = "logout!"
    case chooseAnOption = " Choooose one option"
    case youTubeAlert = "Search YouTube"
    
    func getMessage() -> String {
        switch self {
        case .removeTagFromTagList:
            return "Tag will be removed."
        case .maximumTagLimit:
            return " Reached maximum Limit , Please Pop some tags."
        case .smileyAdded:
            return "added!"
        case .removeEmotion:
            return "Do you want to remove?"
        case .logoutALert:
            return "do you want to logout?"
        case .chooseAnOption:
            return "\nSelect an option\n"
        case .youTubeAlert:
            return " Please enter text. "
            
            
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
    let userOptionsVC = "UserOptionsViewController"
    let videoPlayerVC = "VideoPlayerViewController"
    let signUpVC = "SignUpViewController"
    let signInVC = "SignInViewController"
    let settingsVC = "settingsViewController"
}
let vCIdentifiers = ViewControllersIdentifiers()

struct FIRDatabaseNodeNames {
    let userName = "userName"
    let language = "language"
    let gender = "gender"
    let smiley = "smiley"
    let profileImageUrl = "profileImageUrl"
    let settings = "settings"
    let dayTime = "dayTime"
    let season = "season"
    let emojiList = "emojiList"
    let users = "users"
    let playlist = "playlist"
    let videoId = "videoId"
    let date = "date"
    let videoName = "videoName"
    let discription = "discription"
}
let fIRDatabaseNodeNames = FIRDatabaseNodeNames()



struct introScreenViewControllerConstants {
    let videoName = "intro"
    let videoType = "mp4"
    let webPageUrl = "https://ymedialabs.com"
}

//signUPcontroler

struct SignUpViewControllerConstants {
    let error = "Error"
    let registeringWait = "Registering, Please wait !!"
    let registeredSeccusfully = "You have been Registered Successfully with email id "
    let googleUserExists = "google user already exists"
    let googleSignUpButtonTitle = "Google Sign up"
}



//signin controller
struct SignInViewControllerConstants {
    let loggingIn = "Logging In"
    let error = "Error"
    let LoginDefaultMessage = "Logged In Successfully \n"
}



//MoodSelectorViewController

struct moodSelectorViewControllerConstants{
    let loadingMessage = "loading..."
    let welcomeMessage = "welcome to charlie"
    let playFromPlaylist = "Play from Playlist"
    let selectTags = "Select Tags"
    let random = "Random"
    let selectYourOptions = "Select your option"
    let zeroTag = "\nZERO TAGS!!\n"
    let searchKeyLatest = "latest"
    let searchKeyError = "error"
    let continueAction = "continue"
    let selectionTagsCollectionViewCellIdentifier = "SelectionTagsCollectionViewCell"
    let MoodsShowCollectionViewCellIdentifier = "MoodsShowCollectionViewCell"
    let MoodBubbleCollectionViewCellIdentifier = "MoodBubbleCollectionViewCell"
    let good = "Good "
}

// SettingsViewController

let autoplayAbstractMenuDetail = "play video automatically by reducing tags if no video is found for current querry"
let videoOrderMenuDetail = "This spcecifies the type of order response we get from youtube"
let relevencelanguageMenuDetail = "This parameter returns search results that are most relevant to the specified language. "
let videoTypeMenuDetail = "type of video you want to play"

//UserOptionsViewController

struct UserOptionsViewControllerConstants {
    
    let addEmotion = "Add Emotion"
    let install = "Install!"
    let shareImageUrl = "https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png"
    let yes = "yes"
    let emotion = "emotion?"
    let continueAction = "continue"
}



//VideoplayerViewController

let noVideoErrorMessage = "There is no video for your querry \n Suggestion : Try with less tags"
let playForAbstract = "play for Abstract"
let goBack = "Go Back"
