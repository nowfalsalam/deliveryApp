//
//  CDelivery+CoreDataProperties.swift
//  deliveryApp
//
//  Created by Nowal E Salam on 04/12/19.
//  Copyright © 2019 Nowal E Salam. All rights reserved.
//
//

import Foundation
import CoreData


extension CDelivery {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDelivery> {
        return NSFetchRequest<CDelivery>(entityName: "CDelivery")
    }

    @NSManaged public var id: Int64
    @NSManaged public var descrptn: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var location: CLocation?

}

extension CDelivery {
    class func fetchDelivery(withId id: Int64?, context: NSManagedObjectContext = CoreDataStack.sharedInstance.mainContext)-> [CDelivery] {
        let fetchReq:NSFetchRequest<CDelivery> = CDelivery.fetchRequest()
        fetchReq.returnsObjectsAsFaults = false
        if let deliveryId = id {
            fetchReq.predicate  = NSPredicate(format: "id = %i", deliveryId)
            fetchReq.fetchLimit = 1
        }
        fetchReq.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        do {
            return try context.fetch(fetchReq)
        }catch {
            return []
        }
    }
}
