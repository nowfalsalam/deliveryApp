//
//  DeliveryListViewModel.swift
//  deliveryApp
//
//  Created by Nowal E Salam on 04/12/19.
//  Copyright © 2019 Nowal E Salam. All rights reserved.
//

import Foundation
import CoreData

class DeliveryListViewModel: ObservableObject {
    private var coreDataStack =  CoreDataStack.sharedInstance
    var writerContext :NSManagedObjectContext
    
    @Published var deliveryList = [Delivery]()
    var hasNextPage = true
    var offset = 0
    var pageSize = 20
    var isLoading = false
    var isFirstLoad = true
    
    init() {
        writerContext = coreDataStack.createWriterContext()
    }
}

extension DeliveryListViewModel {
    func fetchDelivery(){
        if(isFirstLoad){
            fetchDeliveriesFromCoredata()
        } else {
            fetchNextPage()
        }
    }
    
    private func fetchNextPage(){
        
        guard hasNextPage && !isLoading else {
            return
        }
        
        if(offset != 0){
            isLoading = true
        }
        
        FetchDeliveryService().execute(offset: offset, limit: pageSize) { (status, response, errorMessage) in
            print("offset\(self.offset)")
            self.isLoading = false
            if(status){
                print("offset after\(self.offset)")
                if(response.count < self.pageSize){
                    self.hasNextPage = false
                } else {
                    self.hasNextPage = true
                }
                DispatchQueue.main.async {
                    self.deliveryList += response
                    self.offset = self.deliveryList.count
                }
                self.saveResponse(response: response) // Save to coredata
            } else {
                DispatchQueue.main.async {
                    self.deliveryList += []
                }
            }
        }
    }
    
    private func fetchDeliveriesFromCoredata(){
        var deliveries = [Delivery]()
        let cDeliveries = CDelivery.fetchDelivery(withId: nil)
            for delivery in cDeliveries {
                deliveries.append(Delivery(delivery: delivery))
            }
        DispatchQueue.main.async {
            self.deliveryList += deliveries
            self.offset = self.deliveryList.count
            self.isFirstLoad = false
            if(deliveries.isEmpty){
                self.fetchNextPage()
            }
        }
        
    }
    
    private func saveResponse(response data: [Delivery]) {
        for delivery in data {
            var newDelivery : CDelivery! = nil
            let oldDelivery = CDelivery.fetchDelivery(withId: Int64(delivery.id ), context:  writerContext)
            if oldDelivery.count > 0{
                newDelivery = oldDelivery[0]
            }else{
                newDelivery = CDelivery(context: writerContext)
            }
            newDelivery.id = Int64(delivery.id)
            newDelivery.imageUrl = delivery.imageUrl
            newDelivery.descrptn = delivery.description
            
            var newLocation : CLocation! = nil
            if let oldLocation = newDelivery.location {
                newLocation = oldLocation
            } else {
                newLocation = CLocation(context: writerContext)
            }
            newLocation.lat = delivery.location.lat
            newLocation.long = delivery.location.lng
            newLocation.address = delivery.location.address
            newLocation.delivery = newDelivery
        }
        coreDataStack.save(writerContext: writerContext, saveUptoRoot: true)
    }
}
