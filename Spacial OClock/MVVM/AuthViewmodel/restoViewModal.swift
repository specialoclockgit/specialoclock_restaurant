//
//  restoViewModal.swift
//  Spacial OClock
//
//  Created by cqlios on 28/11/23.
//

import Foundation

class restoViewModal : NSObject{
    
    //MARK: - HOME RESTO LIST API
    func homeRestoAPI(restobarID:Int,onsuccess: @escaping ((homeModalBody?)->())){
        let param = ["restrorant_bar_id":restobarID]
        WebService.service(API.restro_home, param: param, service: .post) {
            (modaldata: homeModal, Data , json) in
            onsuccess(modaldata.body)
        }
    }

    //MARK: - HOME RESTO LIST DETAIL API
//    func homeRestoDetailAPI(restoid:Int,onsuccess: @escaping ((restoDetailModalBody?)->())){
//        let param = ["booking_id":restoid]
//        WebService.service(API.restro_BookingDetail, param: param, service: .post) {
//            (modaldata: restoDetailModal, Data , json) in
//            onsuccess(modaldata.body)
//        }
//    }

//    func homeReportUser(restoid:String, reason: String, onsuccess: @escaping ((ForgotpasswordModel?)->())) {
//        let param = ["booking_id": restoid, "reason": reason] as [String : Any]
//
//        WebService.service(API.report_booking, param: param, service: .post) {
//            (modaldata: ForgotpasswordModel, Data , json) in
//            onsuccess(modaldata)
//        }
//    }

    //MARK: - CURRENT PAST BOOKING API
//    func currentPast_API(type:Int,genre:String,onsuccess: @escaping (([currentPastModalBody]?)->())){
//        let param = ["type":type, "genre":"1"] as [String:Any]
//        WebService.service(API.booking_history, param: param, service: .post) {
//            (modaldata: currentPastModal, Data , json) in
//            onsuccess(modaldata.body)
//        }
//    }

}

