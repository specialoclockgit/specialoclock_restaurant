//
//  HomeViewModel.swift
//  Spacial OClock
//
//  Created by cqlios1 on 30/08/23.
//

import Foundation
import UIKit

class HomeViewModel : NSObject {
    
    var homeData: HomeListBody?
    
    //MARK: - CUISINE GET LIST
    func homeApi(type:Int, country: String, state:String, onsuccess: @escaping ((HomeListBody?)->())){
        let param:parameters = ["type":type, "country":country, "state": state]
        
        WebService.service(API.home, param: param, service: .post) {
            (modaldata: HomeListModel, Data , json) in
            onsuccess(modaldata.body)
        }
    }
}
