//
//  HomeMenuViewModel.swift
//  roam_ios
//
//  Created by Shubhang Dixit on 06/06/19.
//  Copyright © 2019 Shubhang Dixit. All rights reserved.
//

import Foundation
import UIKit

public enum HomeOptionType : CaseIterable {
    case search, shop, cart, signIn
    
    func getTitle () -> String {
        switch self {
        case .search:
            return "Search"
        case .shop:
            return "Explore Locations"
        case .cart:
            return "Cart"
        case .signIn:
            return "Login"
        }
    }
    
    func getDetailMessage () -> String {
        switch self {
        case .search:
            return "Search for your perfect destination for next getaway."
        case .shop:
            return "Choose from our featured locations"
        case .cart:
            return "Check your cart and procced to checkout"
        case .signIn:
            return "Login / logout"
        }
    }
    
    func imageForOption () -> UIImage? {
        switch self {
        case .search:
            return UIImage(named: "search")
        case .shop:
            return UIImage(named: "locationIcon")
        case .cart:
            return UIImage(named: "shoppingCartIcon")
        case .signIn:
            return UIImage(named: "user")
            
        }        
    }
    
    func getControllerName() -> String {
        return ""
    }
}


