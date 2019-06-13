//
//  RoamBaseViewcontroller.swift
//  roam_ios
//
//  Created by Shubhang Dixit on 09/06/19.
//  Copyright © 2019 Shubhang Dixit. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class RoamBaseViewController: UIViewController {
    
    let progressIndicator = ActivityIndicator.instantiateView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(progressIndicator)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setScreenName(titleString : String) {
        self.navigationController?.navigationBar.topItem?.title = titleString
        self.title = titleString
    }
    
    func setupGradientLayer (topView: UIView, previewImageView:UIImageView) {
        let gradient = CAGradientLayer()
        
        gradient.frame = topView.bounds
        gradient.colors = [
            UIColor.black.cgColor,
            UIColor.init(white: 0, alpha: 0).cgColor
        ]
        topView.backgroundColor = .clear
        topView.layer.insertSublayer(gradient, at: 0)
        previewImageView.image = UIImage(named: "defaultImage.jpeg")
        view.sendSubviewToBack(previewImageView)
    }
    
    func checkForConnection() {
//        let error = ErrorMesseges.noConnection
//        if ConnectionCheck.isConnectedToNetwork() == false {
//            showPermissionAlert(self, strtittle: error.rawValue, message: error.getDetail(), actionTittle: "settings"){
//                UIApplication.shared.open(URL(string: "prefs:root")!)
//            }
//
//        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        // checks email address with regular expression for its validity
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
    
}
