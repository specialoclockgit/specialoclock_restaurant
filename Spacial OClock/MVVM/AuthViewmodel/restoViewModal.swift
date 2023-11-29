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
    
    //MARK: - CURRENT PAST BOOKING API
    func resto_currentPast_API(type:Int,genre:String,onsuccess: @escaping (([rstoCurrentModalBody]?)->())){
        let param = ["type":type, "genre":"1"] as [String:Any]
        WebService.service(API.booking_history, param: param, service: .post) {
            (modaldata: rstoCurrentModal, Data , json) in
            onsuccess(modaldata.body)
        }
    }
    
    //MARK: - GET NOTIFICATION LIST
    func getNotificationList(onsuccess: @escaping (([notificationListModalBody]?)->())){
        WebService.service(API.fetch_notifications, service: .get) {
            (modaldata: notificationListModal, Data , json) in
            onsuccess(modaldata.body)
        }
    }
    
    //MARK: - PRIVACY POLICY
    func privacypolicyApi(onSuccess : @escaping ((TermsconditionModelBody?)->())){
        WebService.service(API.privacypolicy ,service: .get, showHud: true) {
            (modaldata: TermsconditionModel , Data, Json) in
            onSuccess(modaldata.body)
        }
    }
    //MARK: - TERMS & CONDITION
    func termsandconditionApi(onSuccess : @escaping ((TermsconditionModelBody?)->())){
        WebService.service(API.termsAndCondition ,service: .get, showHud: true) {
            (modaldata: TermsconditionModel , Data, Json) in
            onSuccess(modaldata.body)
        }
    }
    
    //MARK: - Menu
    func getMenuapi(onsuccess: @escaping (([MenuListingModelBody]?)->())){
        WebService.service(API.menu_listing, service: .get) {
            (modaldata: MenuListingModel, Data , json) in
            onsuccess(modaldata.body)
        }
    }
    
    //MARK: - MENU
    func ProductListingapi(menuid: Int,onsuccess: @escaping (([ProductListingModelBody]?)->())){
        let param: parameters = ["cuisine_id":menuid]
        WebService.service(API.menu_product_listing, param: param,service: .post) {
            (modaldata: ProductListingModel, Data , json) in
            onsuccess(modaldata.body)
        }
    }
    
    //MARK: - OFFER MENU
    func offerListingapi(restaurentbarid : Int,onsuccess: @escaping (([getOfferListModalBody]?)->())){
        let param = ["restrorant_bar_id":restaurentbarid]
        WebService.service(API.offer_listing,param: param,service: .post) {
            (modaldata: getOfferListModal, Data , json) in
            onsuccess(modaldata.body)
        }
    }
    
    //MARK: - REVIEW LISTING
    func reviewListing(restoid:Int,onsuccess: @escaping (([ReviewListingModelBody]?)->())){
        let param = ["resto_id":restoid]
        WebService.service(API.review_listing, param: param,service: .post) {
            (modaldata: ReviewListingModel, Data , json) in
            onsuccess(modaldata.body)
        }
    }
    
    //MARK: - GET INVOICE LIST
    func get_Invoice(onsuccess: @escaping (([getInvoiceListModalBody]?)->())){
        WebService.service(API.fetch_invoices, service: .get) {
            (modaldata: getInvoiceListModal, Data , json) in
            onsuccess(modaldata.body)
        }
    }
    
    //MARK: - CARD LISTING
    func cardListing(onsuccess: @escaping (([CardListingModelBody]?)->())){
        WebService.service(API.card_listing, service: .get) {
            (modaldata: CardListingModel, Data , json) in
            onsuccess(modaldata.body)
        }
    }
    
    //MARK: - INVOICE DETAIL API
    func get_Invoice_Detail(invoice_number:String,onsuccess: @escaping ((invoiceDetailModalBody?)->())){
        let param = ["invoice_number":invoice_number]
        WebService.service(API.fetch_invoice_detail, param: param,service: .post) {
            (modaldata: invoiceDetailModal, Data , json) in
            onsuccess(modaldata.body)
        }
    }
    
    //MARK: - INVOICE PAYMENT API
    func invoice_Payment_aPI(amount:Int,invoiceNumber:String,onsuccess: @escaping ((paymentModalBody?)->())){
        let param = ["amount":amount, "invoice_number":invoiceNumber] as [String:Any]
        WebService.service(API.payment_sheet, param: param, service: .post) {
            (modaldata: paymentModal, Data , json) in
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

