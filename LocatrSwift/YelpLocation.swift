//
//  YelpLocation.swift
//  LocatrSwift
//
//  Created by Nina Yang on 3/23/16.
//  Copyright © 2016 Nina Yang. All rights reserved.
//

import Foundation
import ObjectMapperi

class YelpLocation: Mappable {
    var name: String?
    var categories: [AnyObject]?
    var location: [AnyObject]?
    
    required init?(_ map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        name <- map["businesses.name"]
        categories  <- map["businesses.categories.0.value"]
        location <- map["businesses.location.address"]
    }
}