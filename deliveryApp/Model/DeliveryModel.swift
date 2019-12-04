//
//  delivery.swift
//  deliveryApp
//
//  Created by Nowal E Salam on 04/12/19.
//  Copyright © 2019 Nowal E Salam. All rights reserved.
//

import Foundation

struct Delivery: Codable, Identifiable {
    var id: Int
    var description: String
    var imageUrl: String
    var location: Location
    
    init(delivery : CDelivery) {
        self.id = Int(delivery.id)
        self.description = delivery.descrptn ?? ""
        self.imageUrl = delivery.imageUrl ?? ""
        self.location = Location(location : delivery.location!)
    }
}


public struct Location: Codable {
    var lat: Double
    var lng: Double
    var address: String
    
    init(location : CLocation) {
        self.lat = location.lat
        self.lng = location.long
        self.address = location.address ?? ""
    }
}
