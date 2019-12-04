//
//  ServiceProtocol.swift
//  deliveryApp
//
//  Created by Nowal E Salam on 04/12/19.
//  Copyright © 2019 Nowal E Salam. All rights reserved.
//

import Foundation

 protocol ServiceProtocol {
    func execute(offset : Int, limit : Int, completion: @escaping (_ status : Bool, _ deliveries : [Delivery], _ errorMessage : String)->())
}
