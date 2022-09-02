//
//  ChatRoom.swift
//  Chatty
//
//  Created by GONOSEN on 14/08/2022.
//

import Foundation

enum RoomType{
    case individual, group
}


struct ChatRoom{
    private let name: String
    private let last_message_id: String
    private 
    private var pLastMessage: Message
    var roomName: String{
        name
    }
    
    var lastMessage: Message{
        get{
            pLastMessage
        }
        set(newMessage){
            pLastMessage = newMessage
        }
    }
}
