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
    func homeApi(type:Int, country: String, city:String, state:String, lat:Double, long:Double,timezone:String, onsuccess: @escaping ((HomeListBody?)->())){
        let param:parameters = ["type":type, "country":country, "state": "", "latitude":lat,"city":city, "longitude":long, "timezone":timezone]
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
    func locationByRestoAPI(country:String,city:String,type:String,onsuccess: @escaping (([locationByRestoModalBody]?)->())){
        let param:parameters = ["country":country, "city":city, "type":"1"]
        WebService.service(API.fetch_restos_by_location, param: param, service: .post) {
            (modaldata: locationByRestoModal, Data , json) in
            onsuccess(modaldata.body)
        }
    }
    
    //MARK: - PRODUCT DETIALS
    func restoDetial_API(resto_id:Int,currentdate:String,onsuccess: @escaping ((productDetailModalBody?)->())){
        let param:parameters = ["resto_id":resto_id, "date": currentdate]
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
    
    //MARK: - MENU PRODUCT API
    func menuProductAPI(restoid:Int, menutypeid:Int , onsuccess: @escaping ((menuProductModalBody?)->())){
        let param = ["resto_id":restoid , "menu_type_id":menutypeid] as [String:Any]
        print(param)
        WebService.service(API.fetch_data_by_menutype, param: param, service: .post) {
            (modaldata: menuProductModal, Data , json) in
            onsuccess(modaldata.body)
        }
    }
    
    //MARK: - BOOKING RESTO API
    func booking_API(bookingDate:String, slotid:Int , numberofPeople:String,restoid:Int ,offerid:String ,  onsuccess: @escaping ((bookingRestoModalBody?)->())){
        let param = ["booking_date":bookingDate, "slot_id":slotid, "number_of_people":numberofPeople, "restrorant_bar_id":restoid, "offer_id":offerid] as [String:Any]
        WebService.service(API.booking, param: param, service: .post) {
            (modaldata: bookingRestoModal, Data , json) in
            onsuccess(modaldata.body)
        }
    }
    
    //MARK: - GET SLOTS API
    func getslots_API(date:String, restrorant_bar_id:Int, restoid:Int ,offer_id:String ,onsuccess: @escaping ((getSlotsModalBody?)->())){
        let param = [ "offer_id":offer_id, "menu_id":restoid, "restrorant_bar_id":restrorant_bar_id, "date":date] as [String:Any]
        WebService.service(API.time_slots, param: param, service: .post) {
            (modaldata: getSlotsModal, Data , json) in
            onsuccess(modaldata.body)
        }
    }
    
    //MARK: - CURRENT PAST BOOKING API
    func currentPast_API(type:Int,genre:String,onsuccess: @escaping (([currentPastModalBody]?)->())){
        let param = ["type":type, "genre":"0"] as [String:Any]
        WebService.service(API.booking_history, param: param, service: .post) {
            (modaldata: currentPastModal, Data , json) in
            onsuccess(modaldata.body)
        }
    }
    
    //MARK: - BOOKING DETAIL API
    func bookingDetail_API(bookingId:Int,onsuccess: @escaping ((bookingDetailModalBody?)->())){
        let param = ["booking_id":bookingId] as [String:Any]
        WebService.service(API.restro_BookingDetail, param: param, service: .post) {
            (modaldata: bookingDetailModal, Data , json) in
            onsuccess(modaldata.body)
        }
    }
    
    //MARK: - CANCEL BOOKING API
    func cancelBookig_API(bookingId:String, reson:String, onsuccess: @escaping ((CommonModel?)->())){
        let param = ["booking_id":bookingId, "reason":reson] as [String:Any]
        WebService.service(API.cancel_booking, param: param, service: .post) {
            (modaldata: CommonModel, Data , json) in
            onsuccess(modaldata)
        }
    }
    
    //MARK: - FETCH AVAILABLE API
    func fetchAvialbleAPI(date:String, restrorant_bar_id:Int,offerid:String, slot_id:Int,onsuccess: @escaping ((AvalSlotModalBody?)->())){
        let param = ["date":date, "slot_id":slot_id, "restrorant_bar_id":restrorant_bar_id, "offer_id":offerid] as [String:Any]
        print("============",param)
        WebService.service(API.fetch_available_slots, param: param, service: .post) {
            (modaldata: AvalSlotModal, Data , json) in
            onsuccess(modaldata.body)
        }
    }
    
    //MARK: - FETCH ALL MENU API
    func allMenu_API(resto_bar_id:Int,onsuccess: @escaping (([allMenuModalBody]?)->())){
        let param = ["resto_bar_id":resto_bar_id] as [String:Any]
        print("============",param)
        WebService.service(API.fetch_menu_gallery, param: param, service: .post) {
            (modaldata: allMenuModal, Data , json) in
            onsuccess(modaldata.body)
        }
    }
    
    //MARK: - FETCH CATEGORY BY RESTO LIST API
    func categoryBYResto(categoryID:Int,onsuccess: @escaping (([CategoryByRModalBody]?)->())){
        let param = ["category_id":categoryID] as [String:Any]
        print("============",param)
        WebService.service(API.fetch_restos_by_category, param: param, service: .post) {
            (modaldata: CategoryByRModal, Data , json) in
            onsuccess(modaldata.body)
        }
    }
    
    
}
