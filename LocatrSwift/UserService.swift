//
//  File.swift
//  LocatrSwift
//
//  Created by Chris Jeon on 3/4/16.
//  Copyright © 2016 Nina Yang. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper
import AlamofireObjectMapper

class UserService {
    
    let baseUrl = "http://locatr-rails.herokuapp.com/api/users"
    
    func getUsers(completionHandler: (Array<User>) -> ()) -> () {
        Alamofire.request(.GET, baseUrl).responseArray { (response: Response<[User], NSError>) in
            let userArray = response.result.value
            completionHandler(userArray!)
        }
    }
}