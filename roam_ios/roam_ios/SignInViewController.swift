//
//  SignInViewController.swift
//  roam_ios
//
//  Created by Shubhang Dixit on 12/06/19.
//  Copyright © 2019 Shubhang Dixit. All rights reserved.
//

import UIKit

class SignInViewController: RoamBaseViewController {
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var bckgrndImageView: UIImageView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var menuViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuViewLeadingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientLayer(topView: topView, previewImageView: bckgrndImageView)
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
            } else {
                self.setScreenName(titleString: "Sign In")
            }
            UIView.animate(withDuration: 0.25, animations: {
                
                self.view.layoutIfNeeded()
            }) { finished in
                
            }
        }
       
    }
}
