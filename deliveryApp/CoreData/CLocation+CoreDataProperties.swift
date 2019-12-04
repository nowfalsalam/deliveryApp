//
//  CLocation+CoreDataProperties.swift
//  deliveryApp
//
//  Created by Nowal E Salam on 04/12/19.
//  Copyright © 2019 Nowal E Salam. All rights reserved.
//
//

import Foundation
import CoreData


extension CLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CLocation> {
        return NSFetchRequest<CLocation>(entityName: "CLocation")
    }

    @NSManaged public var lat: Double
    @NSManaged public var long: Double
    @NSManaged public var address: String?
    @NSManaged public var delivery: CDelivery?

}
