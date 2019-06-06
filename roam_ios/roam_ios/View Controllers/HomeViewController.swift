//
//  HomeViewController.swift
//  roam_ios
//
//  Created by Shubhang Dixit on 05/06/19.
//  Copyright © 2019 Shubhang Dixit. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var previewImageView: UIImageView!
    
    @IBOutlet weak var optionsView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let titleString = "home"
        self.navigationController?.navigationBar.topItem?.title = titleString
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
    
    
}
