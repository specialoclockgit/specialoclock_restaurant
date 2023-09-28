import UIKit
import SocketIO
import CoreData
import SwiftyJSON


protocol SocketDelegate {
    func listenedData(data: JSON, response: String)
}

class SocketIOManager: NSObject {
    
    static let sharedInstance = SocketIOManager()
    let manager = SocketManager(socketURL: URL(string:socketKeys.socketBaseUrl.instance)!, config: [.log(true),.compress,.connectParams([socketKeys.userId.instance:Store.userDetails?.body?.id  ?? 0])])
    
    var socket: SocketIOClient!
    var delegate: SocketDelegate?
    
    
    override init() {
        super.init()
        socket = manager.defaultSocket
        self.loadListeners()
    }
    
    
    //MARK:- socket isConnected
    func isConnected() ->Bool{
        if self.socket.status == .connected{
            return true
        }
        else{
            return false
        }
    }
    
    func connectMySocket(){
        if socket.status != .connected{
            socket.connect()
        }
    }
    
    func loadListeners(){
        socket.on(clientEvent: .statusChange) {data, ack in
            self.socket.on(clientEvent: .reconnect) {data, ack in
                print("Reconnected")
            }
            print("Status Change")
        }
        
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
            if Store.userDetails != nil {
                self.connect_user()
            }
        }
        
        socket.on(clientEvent: .reconnectAttempt) {data, ack in
            
            print("ReConnect Attempt")
        }
        
        socket.on(clientEvent: .error) {data, ack in
            print("error")
            //self.connectMySocket()
        }
        
        socket.on(clientEvent: .disconnect) {data, ack in
            print("Disconnect")
        }
        
        self.connect_user_listen()
    }
    
    //MARK:- close socket connection
    func closeConnection() {
        socket.disconnect()
    }
}

//MARK:- custom functions
extension SocketIOManager{
    
    //MARK: - connect_user(emiiter)
    func connect_user(){
        let params:parameters = [socketKeys.userId.instance: Store.userDetails?.body?.id  ?? 0]
        socket.emit(socketEmitters.contecterUser.instance, params)
    }
    
    //MARK: - connect_user(lisner)
    func connect_user_listen(){
        socket.on(socketListeners.connectUserListerner.instance) { arrOfAny, ack in
            print("user connected",arrOfAny)
        }
    }
    
    //MARK: - Send Messsage(emitter)
    func send_message_emitter(receiverId: Int, message:String){
        let param :parameters = ["senderId": Store.userDetails?.body?.id ?? 0,"receiverId": receiverId,"messageType" : 0,"message" : message]
         socket.emit(socketEmitters.sendMessage.instance,param)
    }
    
    //MARK: - Send Messsage(lisner)
    func sendMessageLisner(onSucuss:@escaping(getmessageModal)->()){
     socket.off(socketListeners.sendMessagelistner.instance)
        socket.on(socketListeners.sendMessagelistner.instance){
            arrofAny , ack in
            print("user connected",arrofAny)
            do{
                if let message = arrofAny.first as? String{
                    CommonUtilities.shared.showAlert(message: message, isSuccess: .success)
                }else{
                    let jsonData = try JSONSerialization.data(withJSONObject: arrofAny[0], options: [])
                    let listData = try JSONDecoder().decode(getmessageModal.self, from: jsonData)
                    onSucuss(listData)
                }
            }catch{
                print("Error \(error)")
            }
        }
    }
    
    //MARK: - Meassge List(emitter)
    func messageListemitter(user2id:Int){
        let parm:parameters = [socketKeys.userId.instance:Store.userDetails?.body?.id ?? 0,socketKeys.user2Id.instance:user2id]
        print("All chat",parm)
          socket.emit(socketEmitters.getMessage.instance,parm)
    }
    
    
    //MARK: -  Message List(lisner)
    func messageListlisner(onSucuss:@escaping([getmessageModal])->()){
        socket.on(socketListeners.getMessagelistner.instance){
            arrofAny , ack in
            print("user connected",arrofAny)
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: arrofAny[0], options: [])
                let listData = try JSONDecoder().decode([getmessageModal].self, from: jsonData)
                onSucuss(listData)
            }catch{
                print("Error \(error)")
            }
        }
    }
    
    //MARK: - BLOCK CHECK (EMITER)
    func Block(user2ID:Int){
        let param:parameters = [socketKeys.userId.instance:Store.userDetails?.body?.id ?? 0, "user2Id":user2ID]
        socket.emit(socketEmitters.blockuser.rawValue,param)
    }
    
    //MARK: - BLOCK CHECK (LISTNER)
    
    func blocktheListener(onSucess:@escaping(String)->()){
            socket.on(socketListeners.blockuserlistner.instance) { arrOfAny, ack in
                      print(arrOfAny)
                      if let data = arrOfAny.first as? [String:Any]{
                          if let status = data["success_message"] as? String{
                              onSucess(status)
                          }
                      }
                  }
        }
    
//    func blockListner(onSucess:@escaping(BlockStatusModel)->()){
//        socket.on(socketListeners.blockuserlistner.instance){
//            arrofAny , ack in
//            do {
//                let jsonData = try JSONSerialization.data(withJSONObject: arrofAny[0], options: [])
//                let listData = try JSONDecoder().decode(BlockStatusModel.self, from: jsonData)
//                onSucess(listData)
//            }
//            catch{
//                print("Error \(error)")
//            }
//        }
//
//    }
    //AUDIO CALL 
    
    // MARK: -  ChatList(lisner)
    func chatListLisner(onSucess:@escaping([ChatListModal])->()){
        socket.on(socketListeners.chatListinglistner.instance){
            arrofAny , ack in
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: arrofAny[0], options: [])
                let listData = try JSONDecoder().decode([ChatListModal].self, from: jsonData)
                onSucess(listData)
            }
            catch{
                print("Error \(error)")
            }
        }

    }
    
   // MARK: -  ChatList(emiter)
    func chatListEmitter(){
        let param = ["userId":Store.userDetails?.body?.id ?? 0]
        socket.emit(socketEmitters.chat_listing.instance,param)
    }
    
    
    //MARK: -  checkblockuser(emiiter)
    func checkBlockEmmiter(user2id:Int) {
        let parm:parameters = [socketKeys.userId.instance:Store.userDetails?.body?.id ?? 0 ,"user2Id":user2id]
        print("All chat params is",parm)
        socket.emit(socketEmitters.isblockuser.instance,parm)

    }
    //MARK: -  checkBlock(Lisner)
    func checkBlockListener(onSuccess: @escaping (Int, Int) -> Void) {
        socket.on(socketListeners.isblicklistner.instance) { arrOfAny, _ in
            print(arrOfAny)
            if let data = arrOfAny.first as? [String: Any] {
                if let blockByMe = data["blockByMe"] as? Int, let blockByOther = data["blockByOther"] as? Int {
                    onSuccess(blockByMe, blockByOther)
                }
            }
        }
    }
    





    
//    func checkBlockListener(onSucess:@escaping(BlockStatusModel)->()){
//        socket.on("is_blocked") { arrOfAny, ack in
//
//            print(arrOfAny)
//            do {
//                let jsonData = try JSONSerialization.data(withJSONObject: arrOfAny[0], options: [])
//                let listData = try JSONDecoder().decode(BlockStatusModel.self, from: jsonData)
//                onSucess(listData)
//            }
//            catch{
//                print("Error \(error)")
//            }
//        }
//    }
    
    //MARK: - CLEAR CHAT(Emitter)
    func clearChatEmit(user2id:Int) {
        let parm:parameters = ["userId":Store.userDetails?.body?.id ?? 0 ,"user2Id":user2id]
        socket.emit(socketEmitters.clearchat.instance,parm)

    }
    //MARK: -  CLEAR CHAT(Lisner)
    func clarChatLisner(onSucess:@escaping()->()){
        socket.on(socketListeners.clearchatlistener.instance) { arrOfAny, ack in
            print(arrOfAny)
            onSucess()
            
        }
    }
}
