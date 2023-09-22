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
    
    //MARK: - CUISINE RESTO LIST
    func cusinsRestoAPI(cuisineid:Int,onsuccess: @escaping (([CussinesRestoModalBody]?)->())){
        let param:parameters = ["cuisine_id":cuisineid]
        WebService.service(API.menu_product_listing, param: param, service: .post) {
            (modaldata: CussinesRestoModal, Data , json) in
            onsuccess(modaldata.body)
        }
    }
    
    //MARK: - THEME LIST GET
    func themeGetList(themeID:Int,onsuccess: @escaping (([themeListModalBody]?)->())){
        let param:parameters = ["themes_restrorant_id":themeID]
        WebService.service(API.theme_UserRestro, param: param, service: .post) {
            (modaldata: themeListModal, Data , json) in
            onsuccess(modaldata.body)
        }
    }
    
    //MARK: - PRODUCT DETIALS
    func productDetialAPI(product_id:Int,onsuccess: @escaping ((productDetailModalBody?)->())){
        let param:parameters = ["product_id":product_id ]
        WebService.service(API.product_details, param: param, service: .post) {
            (modaldata: productDetailModal, Data , json) in
            onsuccess(modaldata.body)
        }
    }
    
    //MARK: - FAV LIST
    func favListAPI(onsuccess: @escaping (([favListModalBody]?)->())){
        WebService.service(API.liked_listing, service: .post) {
            (modaldata: favListModal, Data , json) in
            onsuccess(modaldata.body)
        }
    }
    
    //MARK: - RESTO LIKE
    func resto_likeAPI(Restoid:Int,status:Int,onsuccess: @escaping ((CommonBody?)->())){
        let param = ["product_id":Restoid, "value":status]
        WebService.service(API.restoLIke,param: param, service: .post) {
            (modaldata: CommonModel, Data , json) in
            onsuccess(modaldata.body)
        }
    }
    
}
