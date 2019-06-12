//
//  SignInViewController.swift
//  roam_ios
//
//  Created by Shubhang Dixit on 12/06/19.
//  Copyright © 2019 Shubhang Dixit. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase
import FirebaseStorage

enum RoamSigningStyle {
    case signIn, signUp
}

class SignInViewController: RoamBaseViewController, GIDSignInUIDelegate {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bckgrndImageView: UIImageView!
    @IBOutlet weak var menuView: UIView!
    
    @IBOutlet weak var signInEmailTextField: UITextField!
    @IBOutlet weak var signInPasswordTextField: UITextField!
    @IBOutlet weak var signUpUserNameTextField
    : UITextField!
    @IBOutlet weak var signUpEmailTextField: UITextField!
    @IBOutlet weak var signUpPasswordTextField: UITextField!
    
    @IBOutlet weak var menuViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    
    var signingStyle : RoamSigningStyle = .signIn
    
    let kMinimumPasswordLength : Int = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientLayer(topView: topView, previewImageView: bckgrndImageView)
        GIDSignIn.sharedInstance().uiDelegate = self
        setUpGoogleSignInButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setScreenName(titleString: "Sign In")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        menuView.layer.cornerRadius = 10
        menuView.layer.shadowColor = UIColor.black.cgColor
        menuView.layer.shadowOpacity = 1
        menuView.layer.shadowOffset = CGSize(width: 0, height: 5)
        menuView.layer.shadowRadius = 15
    }
    
    func setUpGoogleSignInButton() {
        
        googleSignInButton.colorScheme = GIDSignInButtonColorScheme.light
        googleSignInButton.style = .standard
        googleSignInButton.accessibilityLabel = "Sign Up with Google"
    }
    
    
    @IBAction func scrollToSingUpAction(_ sender: Any) {
        animateMenuViewToSwipe()
    }
    
    @IBAction func scrollToSignInAction(_ sender: Any) {
        animateMenuViewToSwipe()
    }
    
    func animateMenuViewToSwipe() {
        let newtrailingConstraint = menuViewLeadingConstraint.constant
        let newLeadingConstraint = menuViewTrailingConstraint.constant
        view.setNeedsUpdateConstraints()
        UIView.animate(withDuration: 0.5, animations: {
            
            self.view.layoutIfNeeded()
        }) { finished in
            self.menuViewLeadingConstraint.constant = newLeadingConstraint
            self.menuViewTrailingConstraint.constant = newtrailingConstraint
            if self.title == "Sign In" {
                self.setScreenName(titleString: "Sign Up")
                self.signingStyle = .signUp
            } else {
                self.setScreenName(titleString: "Sign In")
                self.signingStyle = .signIn
            }
            UIView.animate(withDuration: 0.25, animations: {
                
                self.view.layoutIfNeeded()
            }) { finished in
                
            }
        }
        
    }
    
    @IBAction func signInButtonAction(_ sender: Any) {
        //self.progressIndicator.startSpinner(withMessage: contains.loggingIn)
        guard let password = signInPasswordTextField.text else { return }
        guard let email = signInEmailTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) {[weak self] (data, error) in
            if error != nil {
                //self.progressIndicator.flashSpinner(state: .error)
                self?.showAlertMsg(title: "Error", message: error.debugDescription)
            }
            else {
                if let user = data?.user {
                    DataManager.shared.initialiseUser(user: user)
                    self?.popToHomeScreen()
                }
            }
        }
    }
    
    @IBAction func signUpButtonAction(_ sender: Any) {
        //progressIndicator.startSpinner(withMessage: constants.registeringWait)
        if validateFields() {
            
            guard let password = signUpPasswordTextField.text else { return }
            guard let email = signUpEmailTextField.text else { return }
            
            Auth.auth().createUser(withEmail: email , password: password) {[weak self] (data, error) in
                if let user = data?.user {
                    var userName = email
                    if let name = self?.signUpUserNameTextField.text {
                        userName = name
                    }
                    DataManager.shared.registerUser(user: user, userName: userName, gender: Gender.undisclosed)
                    self?.popToHomeScreen()
                } else {
                    self?.showAlertMsg(title: "Error", message: "Unable to Register user")
                }
            }
        }
    }
    
    func verifyPasswordForNewUser(completion: @escaping (Bool) -> (Void)) {
        let alert = UIAlertController(title: "Re-Enter Password", message: "Enter your password again.", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.text = "Enter Password"
        }
        
        alert.addAction(UIAlertAction(title: "Validate", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            guard let password : String = self.signUpPasswordTextField.text else { completion(false) ; return }
            if textField?.text == password {
                completion(true)
            } else {
                completion(false)
            }
            
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    func popToHomeScreen () {
        navigationController?.popViewController(animated: true)
    }
    
}



extension SignInViewController {
    func validatePassword() -> Bool {
        if let password = signingStyle == .signIn ? signInPasswordTextField.text : signUpPasswordTextField.text {
            if (password.count) < kMinimumPasswordLength {
                return false
            }
        } else {
            return false
        }
        return true
    }
    
    func validateFields() -> Bool {
        
        if validatePassword() {
            
            guard let emailAddressToVerify : String = (signingStyle == .signIn) ? signInEmailTextField.text : signUpEmailTextField.text else { return false }
            if isValidEmail(testStr: emailAddressToVerify) {
                if signingStyle == .signUp {
                    guard let userName : String = signUpUserNameTextField.text else { return false }
                    if userName != "" {
                        return true
                    } else {
                        return false
                    }
                } else {
                    return true
                }
            } else {
                showAlertMsg(title: "Error", message: ErrorMesseges.invalidEmail.getDetail())
            }
            
        } else {
            showAlertMsg(title: "", message: ErrorMesseges.passwordLength.getDetail())
        }
        return false
    }
}
