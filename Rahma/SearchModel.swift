//
//  SearchModel.swift
//  Rahma
//
//  Created by MOHAMED on 3/15/17.
//  Copyright © 2017 Amr Mohamed. All rights reserved.
//

import UIKit
import SwiftyJSON
class SearchModel: NSObject {
    
    var name : String!
    var mobile : String!
    var country : String!
    
    init(Data : [String:JSON]) {
        if let Name = Data["name"]?.string{
              name = Name
            print(name)
        }
        if let Mobile = Data["mobile"]?.string {
            mobile = Mobile
            print(Mobile)
        }
        if let Country = Data["country"]?.string {
            country = Country
            print(Country)
        }
    }

}
