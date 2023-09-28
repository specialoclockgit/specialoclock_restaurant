import Foundation
import SwiftUI

enum socketKeys : String {
    case socketBaseUrl = "http://202.164.42.227:9999"
    case userId = "user_id"
    case senderId = "sender_id"
    case receiverId = "receiver_id"
    case messageType = "message_type"
    case message = "message"
    case type = "type"
    case user2Id = "other_user_id"
    case reason = "reason"
    case limit = "limit"
    case offset = "offset"
    case room_id = "room_id"
    
    var instance : String {
        return self.rawValue
    }
}
enum socketEmitters:String {
    //MARK: EMITTERS
    case userId = "userId"
    case user2Id = "user2Id"
    case contecterUser = "connect_user"
    case sendMessage = "send_message"
    case getMessage = "get_message_list"
    case disconnected = "disconnected"
    case chat_listing = "chat_listing"
    case clearchat = "clear_chat"
    case blockuser = "block_user"
    case call_to_user = "call_to_user"
    case isblockuser = "is_Blocked"
    var instance : String {
        return self.rawValue
    }
}
enum socketListeners : String{
    //MARK: - LISTNER
    case connectUserListerner = "connect_user"
    case sendMessagelistner = "send_message"
    case getMessagelistner = "get_message_list"
    case chatListinglistner = "chatListing"
    case userDisconnectlistner = "userDisconnect"
    case clearchatlistener = "clear_chat"
    case blockuserlistner =  "block_user_listner"
    case isblicklistner = "is_blocked"
    
    var instance : String {
        return self.rawValue
    }
}






