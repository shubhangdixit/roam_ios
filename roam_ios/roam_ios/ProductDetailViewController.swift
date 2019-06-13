//
//  ProductDetailViewController.swift
//  roam_ios
//
//  Created by Shubhang Dixit on 13/06/19.
//  Copyright © 2019 Shubhang Dixit. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn
import Firebase
import FirebaseStorage
import SafariServices

class ProductDetailViewController: RoamBaseViewController {
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var gradientview: UIView!
    @IBOutlet weak var bckgrndImageView: UIImageView!
    @IBOutlet weak var menuView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var peopleCountLabel: UILabel!
    @IBOutlet weak var numberOfDaysLabel: UILabel!
    @IBOutlet weak var zoneLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var wikiButton: UIButton!
    
    var product : RoamProducts?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientLayer(topView: topView, previewImageView: bckgrndImageView)
        loadProductData()
        view.bringSubviewToFront(gradientview)
        detailsButton.layer.borderWidth = 2.0
        detailsButton.layer.borderColor = detailsButton.tintColor.cgColor
        wikiButton.layer.borderWidth = 2.0
        wikiButton.layer.borderColor = detailsButton.tintColor.cgColor
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func loadProductData() {
        if let productPlace = product {
            if let urlString = productPlace.imageUrl {
            bckgrndImageView.loadImageUsingCache(withUrl: urlString)
            }
            titleLabel.text = productPlace.name
            stateLabel.text = productPlace.state
            priceLabel.text = productPlace.getProductPrice()
            peopleCountLabel.text = productPlace.getPeopleCountString()
            numberOfDaysLabel.text = productPlace.getNumberOfDaysString()
            zoneLabel.text = productPlace.getZoneString()
            typeLabel.text = productPlace.type?.rawValue
            setScreenName(titleString: productPlace.name ?? "")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        menuView.layer.cornerRadius = 10
        menuView.layer.shadowColor = UIColor.black.cgColor
        menuView.layer.shadowOpacity = 1
        menuView.layer.shadowOffset = CGSize(width: 0, height: 5)
        menuView.layer.shadowRadius = 15
    }

    func popToHomeScreen () {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func detailButtonAction(_ sender: Any) {
        
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "DescriptionAndMapViewController") as! DescriptionAndMapViewController
        viewController.product = product
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func wikiButtonAction(_ sender: Any) {
        if let url = product?.wiki {
            
            let safariVC = SFSafariViewController(url: URL(string: url)!)
            self.present(safariVC, animated: true, completion: nil)
            safariVC.delegate = self as? SFSafariViewControllerDelegate
        }
    }
}



extension ProductDetailViewController {
    
}
