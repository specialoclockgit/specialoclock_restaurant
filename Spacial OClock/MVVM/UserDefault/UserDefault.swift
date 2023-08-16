//
//  UserDefault.swift
//  Spacial OClock
//
//  Created by cql211 on 12/07/23.
//

import Foundation

extension UserDefaults{
    
    //MARK: Signup Resto And Bar Button Check
    var status : Int{
        get {
            UserDefaults.standard.value(forKey: "status")  as! Int
        }set{
            UserDefaults.standard.set(newValue, forKey: "status")
        }
    }
    var name : String{
        get{
            UserDefaults.standard.value(forKey: "name")  as! String
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "name")
        }
    }
    
    //MARK: Home User Dine and Drink button Check
    var dineDrinkStatus : Int{
        get {
            UserDefaults.standard.value(forKey: "dineDrinkStatus") as! Int
        }
        set{
            UserDefaults.standard.set(newValue, forKey: "dineDrinkStatus")
        }
    }
}
