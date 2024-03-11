//
//  restoViewModal.swift
//  Spacial OClock
//
//  Created by cqlios on 28/11/23.
//

import Foundation

class restoViewModal : NSObject{
    
    //MARK: - HOME RESTO LIST API
    func homeRestoAPI(restobarID:Int,date:String,onsuccess: @escaping ((homeModalBody?)->())){
        var param = parameters()
        param = ["restrorant_bar_id":restobarID]
        if date != ""{
            param["date"] = date
        }
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
    func getMenuapi(resotbarid:Int, onsuccess: @escaping (([MenuListingModelBody]?)->())){
        let param = ["restrorant_bar_id":resotbarid]
        WebService.service(API.menu_listing, param: param,service: .post) {
            (modaldata: MenuListingModel, Data , json) in
            onsuccess(modaldata.body)
        }
    }
    
    //MARK: - MENU
    func ProductListingapi(menuid: Int,restobarId: Int, onsuccess: @escaping (([ProductListingModelBody]?)->())){
        let param: parameters = ["restrorant_bar_id":restobarId, "menu_id":menuid]
        WebService.service(API.my_menu_products, param: param,service: .post) {
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
    
    //MARK: - Restaurent details
    func restaurentDetails(onsuccess: @escaping ((RestaurentDetailsModelBody?)->())){
        WebService.service(API.get_business_details, service: .get) {
            (modaldata: RestaurentDetailsModel, Data , json) in
            onsuccess(modaldata.body)
        }
    }
    
    //MARK: - EDIT RESTAURENT
    func editRestaurent(isSingleImage:Bool,isImageSelected:Bool,restrorant_id:Int,profile_image:[FileuploadModelBody],name:String,image:[FileuploadModelBody],location:String,open_time:String,category_id:Int,themes_restrorant_id:String,short_description:String,closetime:String,onsuccess: @escaping (()->())){
        
            editRestaurentFunction(isSingleImage:isSingleImage,isImageSelected:isImageSelected,restrorant_id: restrorant_id, profile_image: profile_image, name: name, image: image, location: location, open_time: open_time, category_id: category_id, themes_restrorant_id: themes_restrorant_id, short_description: short_description, closetime: closetime) { data in
                onsuccess()
            }
        
      
    }
    func editRestaurentFunction(isSingleImage:Bool,isImageSelected:Bool,restrorant_id:Int,profile_image:[FileuploadModelBody],name:String,image:[FileuploadModelBody],location:String,open_time:String,category_id:Int,themes_restrorant_id:String,short_description:String,closetime:String,onsuccess: @escaping ((EditRestaurentModelBody?)->())){
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(profile_image)
            let jsonString = String(data: jsonData, encoding: .utf8)
            guard let json = jsonString else{return}
            
            let jsonDataimage = try jsonEncoder.encode(image)
            let jsonStringimage = String(data: jsonDataimage, encoding: .utf8)
            guard let jsonimage = jsonStringimage else{return}
            
            var param: parameters = ["restrorant_id":restrorant_id,"name":name , "location":location, "open_time":open_time,"category_id":category_id,"themes_restrorant_id":themes_restrorant_id,"short_description":short_description,"close_time":closetime]
            if isSingleImage == true {
                param["profile_image"] = json
            }
            
            if image.count !=  0{
                param["image"] = jsonimage
            }
            
            print(param)
            WebService.service(API.edit_business,param:param, service: .post) {
                (modaldata: EditRestaurentModel, Data , json) in
                onsuccess(modaldata.body)
            }
        } catch {
            print("error--\(error.localizedDescription)")
        }
    }

    //MARK: - HOME RESTO LIST DETAIL API
    func homeRestoDetailAPI(restoid:Int,onsuccess: @escaping ((restoDetailModalsBody?)->())){
        let param = ["booking_id":restoid]
        WebService.service(API.restro_BookingDetail, param: param, service: .post) {
            (modaldata: restoDetailModals, Data , json) in
            onsuccess(modaldata.body)
        }
    }

    //MARK: - MENU PRODUCT API
    func Complete_bookingAPI(bookingid:String, onsuccess: @escaping ((CommonModel?)->())){
        let param = ["booking_id":bookingid] as [String:Any]
        print(param)
        WebService.service(API.complete_booking, param: param, service: .post) {
            (modaldata: CommonModel, Data , json) in
            onsuccess(modaldata)
        }
    }

    //MARK: - REPORT USER API
    func homeReportUser(restoid:String, reason: String, onsuccess: @escaping ((ForgotpasswordModel?)->())) {
        let param = ["booking_id": restoid, "reason": reason] as [String : Any]
        WebService.service(API.report_booking, param: param, service: .post) {
            (modaldata: ForgotpasswordModel, Data , json) in
            onsuccess(modaldata)
        }
    }
    
    //MARK: Reply to user review API
    func replyReviewAPI(review_id:Int ,reply:String,onSuccess: @escaping(()->())){
        if reply.trimmingCharacters(in: .whitespaces).isEmpty == true {
            CommonUtilities.shared.showAlert(message: "Please enter your reply", isSuccess: .error)
        }else {
            let params : parameters = ["review_id":review_id,"reply":reply]
            WebService.service(.reply_review,param: params,service: .post) {(resp:CommonModel, data, json) in
                onSuccess()
            }
        }
    }

    //MARK: - CURRENT PAST BOOKING API
//    func currentPast_API(type:Int,genre:String,onsuccess: @escaping (([currentPastModalBody]?)->())){
//        let param = ["type":type, "genre":"1"] as [String:Any]
//        WebService.service(API.booking_history, param: param, service: .post) {
//            (modaldata: currentPastModal, Data , json) in
//            onsuccess(modaldata.body)
//        }
//    }
    
}

