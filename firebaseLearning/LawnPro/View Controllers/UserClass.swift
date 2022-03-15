//
//  UserClass.swift
//  LawnPro
//
//  Created by 90304588 on 3/7/22.
//

import Foundation

class User{
    var userID: String
    var firstName: String
    var lastName: String
    
    init(userID: String, firstName: String, lastName: String){
        self.userID = userID
        self.firstName = firstName
        self.lastName = lastName
    }
}
