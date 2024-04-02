import UIKit
import SocketIO
import CoreData
import SwiftyJSON


protocol SocketDelegate {
    func listenedData(data: JSON, response: String)
}

class SocketIOManager: NSObject {
    
    static let sharedInstance = SocketIOManager()
    let manager = SocketManager(socketURL: URL(string:socketKeys.socketBaseUrl.instance)!, config: [.log(true),.compress,.connectParams([socketKeys.userId.instance:Store.userDetails?.id ?? 0])])
    
    var socket: SocketIOClient!
    var delegate: SocketDelegate?
    
    
    override init() {
        super.init()
        socket = manager.defaultSocket
        self.loadListeners()
        self.connectMySocket()
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
            if Store.userDetails != nil{
                self.connect_user()
            }
            
        }
        
        socket.on(clientEvent: .reconnectAttempt) {data, ack in
            
            print("ReConnect Attempt")
        }
        
        socket.on(clientEvent: .error) {data, ack in
            print("error")
            self.connectMySocket()
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
        let params:parameters = [socketKeys.userId.instance: Store.userDetails?.id  ?? 0]
        socket.emit(socketEmitters.contecterUser.instance, params)
    }
    
    //MARK: - connect_user(lisner)
    func connect_user_listen(){
        socket.on(socketListeners.connectUserListerner.instance) { arrOfAny, ack in
            print("user connected",arrOfAny)
        }
    }
    
    //MARK: - Send Messsage(emitter)
    func send_message_emitter(user2Id:Int,msg_type:Int,message:String){
        let param:parameters = [socketKeys.senderId.instance:Store.userDetails?.id ?? 0,socketKeys.receiverId.instance:user2Id,socketKeys.message.instance:message,socketKeys.messageType.instance:msg_type,socketKeys.type.instance:"user"]
        socket.emit(socketEmitters.sendMessage.instance,param)
    }
    
    //MARK: - Send Messsage(lisner)
    
    func sendMessageLisner(onSucuss:@escaping(MessageListModel)->()){
        socket.off(socketListeners.sendMessagelistner.instance)
        socket.on(socketListeners.sendMessagelistner.instance){
            arrofAny , ack in
            print("user connected",arrofAny)
            do{
                if let message = arrofAny.first as? String{

                    CommonUtilities.shared.showAlert(message: message, isSuccess: .success)
                }else{
                    let jsonData = try JSONSerialization.data(withJSONObject: arrofAny[0], options: [])
                    let listData = try JSONDecoder().decode(MessageListModel.self, from: jsonData)
                    onSucuss(listData)
                }
            }catch{
                print("Error \(error)")
            }
        }
    }
    
    //MARK: - Meassge List(emitter)
    func messageListemitter(user2id:Int,limit:Int,offset:Int){
        let parm:parameters = [socketKeys.senderId.instance:Store.userDetails?.id ?? 0,socketKeys.receiverId.instance:user2id]
//,socketKeys.limit.instance:limit,socketKeys.offset.instance:offset
        socket.emit(socketEmitters.getMessage.instance,parm)
    }
    
    
    //MARK: -  Message List(lisner)
    func messageListlisner(onSucuss:@escaping([MessageListModel])->()){
        socket.on(socketListeners.getMessagelistner.instance){
            arrofAny , ack in
            print("user connected",arrofAny)
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: arrofAny[0], options: [])
                let listData = try JSONDecoder().decode([MessageListModel].self, from: jsonData)
                onSucuss(listData)
            }catch{
                print("Error \(error)")
            }
        }
    }
    
    //MARK: - Clear Chat (emitter)
    func clearChatemitter(user2id:Int){
        let parm:parameters = [socketKeys.senderId.instance:Store.userDetails?.id ?? 0,socketKeys.receiverId.instance:user2id]
        socket.emit(socketEmitters.clearchat.instance,parm)
    }
    
    //MARK: - Clear Chat (Lisner)
    func clearChatListener(onSucess:@escaping()->()){
        socket.on(socketListeners.clearchatlistener.instance) { arrOfAny, ack in
            print(arrOfAny)
            onSucess()
            
        }
    }
    
    // MARK: -  ChatList(lisner)
//    func chatListLisner(onSucess:@escaping([ChatListModel])->()){
//        socket.on(socketListeners.chatListing.instance){
//            arrofAny , ack in
//            do {
//                let jsonData = try JSONSerialization.data(withJSONObject: arrofAny[0], options: [])
//                let listData = try JSONDecoder().decode([ChatListModel].self, from: jsonData)
//                onSucess(listData)
//            }
//            catch{
//                print("Error \(error)")
//            }
//        }
//
//    }
    
    // MARK: -  ChatList(emiter)
//    func chatListEmitter(){
//        let param = ["user_id":Store.userDetails?.body?.id ?? 0]
//        socket.emit(socketEmitters.chatListing.instance,param)
//        
//    }
    
    
}












