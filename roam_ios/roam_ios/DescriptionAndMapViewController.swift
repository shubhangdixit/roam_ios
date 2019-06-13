//
//  DescriptionAndMapViewController.swift
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
import MapKit

class DescriptionAndMapViewController: RoamBaseViewController {
    
    @IBOutlet weak var topView: UIView!
    
    @IBOutlet weak var gradientview: UIView!
    @IBOutlet weak var menuView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var productMapView: MKMapView!
    @IBOutlet weak var descriptionTextField: UITextView!
    var product : RoamProducts?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadProductData()
        view.bringSubviewToFront(gradientview)
        instantiateMapView()
        setupGradientLayer(topView: topView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func instantiateMapView() {
        productMapView.mapType = .standard
        productMapView.showsScale = true
        productMapView.showsCompass = true
        productMapView.userTrackingMode = .none
    }
    
    func loadProductData() {
        if let productPlace = product {
            titleLabel.text = productPlace.name
            descriptionTextField.text = productPlace.productDescription
            DataManager.shared.coordinates(forAddress: productPlace.name ?? "India") { [weak self]
                (location) in
                guard let coordinates = location?.coordinate else { return }
                self?.setMapView(toLocation: coordinates)
            }
            self.setScreenName(titleString: productPlace.name ?? "")
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
    
    func setupGradientLayer (topView: UIView) {
        let gradient = CAGradientLayer()
        
        gradient.frame = topView.bounds
        gradient.colors = [
            UIColor.black.cgColor,
            UIColor.init(white: 0, alpha: 0).cgColor
        ]
        topView.backgroundColor = .clear
        topView.layer.insertSublayer(gradient, at: 0)
    }
    
    func popToHomeScreen () {
        navigationController?.popViewController(animated: true)
    }
    
    func setMapView(toLocation : CLLocationCoordinate2D) {
        let coordinateRegion = DataManager.shared.getCoordinateRegion(withLocation: toLocation)
        self.productMapView.setRegion(coordinateRegion, animated: true)
    }
}
