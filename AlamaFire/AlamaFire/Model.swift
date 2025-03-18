//
//  Model.swift
//  AlamaFire
//
//  Created by mac on 12/01/23.
//

import Foundation



//{
//    "data": {
//        "id": 2,
//        "email": "janet.weaver@reqres.in",
//        "first_name": "Janet",
//        "last_name": "Weaver",
//        "avatar": "https://reqres.in/img/faces/2-image.jpg"
//    },
//    "support": {
//        "url": "https://reqres.in/#support-heading",
//        "text": "To keep ReqRes free, contributions towards server costs are appreciated!"
//    }
//}

class LoginModel:Codable{
    var data : myData!
    var support: mySupport!
    
    init(data: myData!, support: mySupport!) {
        self.data = data
        self.support = support
    }
    
}

class myData:Codable{
    var id:Int!
    var email:String!
    var firstName:String!
    var lastName:String!
    var avatar:String!
    
    init(json disctionaty: NSDictionary){
        id = disctionaty["id"] as? Int
        email = disctionaty["email"] as? String
        firstName = disctionaty["first_name"] as? String
        lastName = disctionaty["last_name"] as? String
        avatar = disctionaty["avatar"] as? String
    }
}

class mySupport:Codable{
    var url:String!
    var text:String!
    
    init(json disctionaty: NSDictionary){
        url = disctionaty["url"] as? String
        text = disctionaty["text"] as? String
    }
}
