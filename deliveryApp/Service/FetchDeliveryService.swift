//
//  FetchDeliveryService.swift
//  deliveryApp
//
//  Created by Nowal E Salam on 04/12/19.
//  Copyright © 2019 Nowal E Salam. All rights reserved.
//

import Foundation

struct FetchDeliveryService : ServiceProtocol {
    func execute(offset: Int, limit: Int, completion: @escaping ( _ status : Bool,  _ deliveries : [Delivery],  _ errorMessage : String) -> ()) {
        let urlRequest = URL(string:"https://mock-api-mobile.dev.lalamove.com/deliveries?offset=\(offset)&limit=\(limit)")
        
        URLSession.shared.dataTask(with: urlRequest!) { data, response, error in
            
            guard let data = data, error == nil else {
                completion(false, [], "Something went to wrong")
                return
            }
            
            let response = try? JSONDecoder().decode([Delivery].self, from: data)
            if let deliveries = response {
                DispatchQueue.main.async {
                    completion(true, deliveries, "Success")
                }
            }
        }.resume()
    }
}
