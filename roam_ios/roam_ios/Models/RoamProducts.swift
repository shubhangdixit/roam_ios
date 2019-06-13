//
//  RoamProducts.swift
//  roam_ios
//
//  Created by Shubhang Dixit on 12/06/19.
//  Copyright © 2019 Shubhang Dixit. All rights reserved.
//

import Foundation

enum LocationType : String {
    
    case hill = "Hill", lake = "Lake", beach = "Beach", city = "City", island = "Island"
    static let allValues = [hill, lake, beach, city, island]
    
}

enum Zone : String {
    case north = "north",south = "south",east = "east",west = "west",centre = "centre"
}

class RoamProducts : NSObject {
    var productDescription : String?
    var maxPeople : Int?
    var state : String?
    var type : LocationType?
    var wiki : String?
    var zone : Zone?
    var imageUrl : String?
    var name : String?
    var price : Int?
    
    init(dictionary : [String: Any], productName : String) {
        name = productName
        productDescription = dictionary["description"] as? String
        maxPeople = dictionary["maxPeople"] as? Int
        state = dictionary["state"] as? String
        type = LocationType.init(rawValue: dictionary["type"] as? String ?? "Hill")
        wiki = dictionary["wiki"] as? String
        zone = Zone.init(rawValue: dictionary["zone"] as! String)
        price = dictionary["price"] as? Int
        imageUrl = dictionary["imageUrl"] as? String
    }
    
    func getNumberOfDays() -> Int {
        return Int.random(in: 4...7)
    }
    
    func getProductPrice() -> String {
        if let priceInInt = price {
            let priceInString = String(describing: priceInInt) + " rs/trip"
            return priceInString
        }
        return ""
    }
    
    func getPeopleCountString () -> String {
        if let people = maxPeople {
            let peopleCount = "Maximum " + String(describing: people) + " people"
            return peopleCount
        }
        return ""
    }
    
    func getNumberOfDaysString () -> String {
        let numberOfDays = String(describing: getNumberOfDays()) + " Days"
        return numberOfDays
    }
    
    func getZoneString () -> String {
        if let zone = zone?.rawValue {
            var zoneString = zone + " India"
            zoneString = zoneString.capitalized
            return zoneString
        }
        return ""
    }
}
