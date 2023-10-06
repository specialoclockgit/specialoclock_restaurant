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
    func homeApi(type:Int, country: String, state:String, lat:Double, long:Double, onsuccess: @escaping ((HomeListBody?)->())){
        let param:parameters = ["type":type, "country":country, "state": state, "latitude":lat, "longitude":long]
        print(param)
        WebService.service(API.home, param: param, service: .post) {
            (modaldata: HomeListModel, Data , json) in
            self.homeData = modaldata.body
            onsuccess(modaldata.body)
        }
    }
    
    //MARK: - CUISINE RESTO LIST
    func cusinsRestoAPI(cuisineid:Int,onsuccess: @escaping (([CussinesRestoModalBody]?)->())){
        let param:parameters = ["cuisine_id":cuisineid]
        WebService.service(API.fetch_restos_by_cusine, param: param, service: .post) {
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
    
    //MARK: - LOCATION BY RESTO API
    func locationByRestoAPI(country:String,city:String,type:String,onsuccess: @escaping ((locationByRestoModalBody?)->())){
        let param:parameters = ["country":country, "city":city, "type":"1"]
        WebService.service(API.fetch_restos_by_location, param: param, service: .post) {
            (modaldata: locationByRestoModal, Data , json) in
            onsuccess(modaldata.body)
        }
    }
    
    //MARK: - PRODUCT DETIALS
    func restoDetial_API(resto_id:Int,onsuccess: @escaping ((productDetailModalBody?)->())){
        let param:parameters = ["resto_id":resto_id ]
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
    
    //MARK: - HOME THEME RESTO LIST API
    func restoThemelistAPI(restoid:Int,onsuccess: @escaping (([themeRestolistModalBody]?)->())){
        let param = ["theme_id":restoid]
        WebService.service(API.fetch_restos_by_theme, param: param, service: .post) {
            (modaldata: themeRestolistModal, Data , json) in
            onsuccess(modaldata.body)
        }
    }
    
    //MARK: - REVIEE ADD API
    func addReviewAPI(restoid:Int, rating:Double,review:String , onsuccess: @escaping ((createReviewModalBody?)->())){
        let param = ["restrorant_bar_id":restoid , "rating":rating, "review":review] as [String:Any]
        WebService.service(API.write_review, param: param, service: .post) {
            (modaldata: createReviewModal, Data , json) in
            onsuccess(modaldata.body)
        }
    }
}
