//
//  HomeMenuViewModel.swift
//  roam_ios
//
//  Created by Shubhang Dixit on 06/06/19.
//  Copyright © 2019 Shubhang Dixit. All rights reserved.
//

import Foundation
public enum HomeOptionType : CaseIterable {
    case search, shop, cart, signIn
    
    func getTitle () -> String {
        switch self {
        case .search:
            return "Search"
        case .shop:
            return "Deals"
        case .cart:
            return "Cart"
        case .signIn:
            return "Login"
        }
    }
    
    func getControllerName() -> String {
        return ""
    }
}


