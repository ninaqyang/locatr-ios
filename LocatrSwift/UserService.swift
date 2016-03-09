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

protocol UserServiceDelegate: class {
    func signupComplete()
    func fbSignupComplete()
}

class UserService {
    weak var delegate: UserServiceDelegate?
    
    let defaults = NSUserDefaults.standardUserDefaults()
    let baseUrl = "http://locatr-rails.herokuapp.com/api/users"
    
    func createUser(userInfo: [String:String]) {
        Alamofire.request(.POST, baseUrl, parameters: userInfo, encoding: .JSON)
            .responseJSON { response in
                
                // Response error
                guard response.result.error == nil else {
                    print("Get request error: \(response.result.error!)")
                    return
                }
                print(response.result.value)
                
                // Response value
                guard let value: AnyObject = response.result.value else {
                    print("Value not determined")
                    return
                }
                let json = JSON(value)
                
                // Response json parse
                guard let statusCode = json["status"].string else {
                    print("Error parsing")
                    return
                }
                // get user name back as well
                print(statusCode)
                
                // Save http status code w/ NSUserDefaults
                self.httpStatusCode(statusCode)
                
                // Update UI
                guard let delegate = self.delegate else {
                    print("Delegate nil")
                    return
                }
                delegate.signupComplete()
        }
    }
    
    func getUsers(completionHandler: (Array<User>) -> ()) -> () {
        Alamofire.request(.GET, baseUrl).responseArray { (response: Response<[User], NSError>) in
            let userArray = response.result.value
            completionHandler(userArray!)
        }
    }
    
    func httpStatusCode(status: String) {
        if status == "200" {
            self.defaults.setBool(true, forKey: "Success")
        } else {
            print("Status code isn't 200")
        }
    }
}