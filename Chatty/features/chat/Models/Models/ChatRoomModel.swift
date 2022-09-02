//
//  ChatRoomModel.swift
//  Chatty
//
//  Created by GONOSEN on 20/08/2022.
//

import Foundation

enum RoomType: String{
    case none, individual, group
}

struct ChatRoomModel: Model{
    typealias T = ChatRoomEntity
    var _entity: ChatRoomEntity?
    private let _lastMessage: MessageModel
    
    init(){
        _entity = ChatRoomEntity()
        _lastMessage = MessageModel()
    }
    
    var id: String {
        _entity?.id ?? ""
    }
    
    var roomName: String{
        _entity?.name ?? ""
    }
    
    var totalUnreadMessages: Int{
        _entity?.total_unread_message ?? 0
    }
    
    var roomType: RoomType{
        RoomType.init(rawValue: entity?.type ?? "none") ?? RoomType.none
    }
    
    var lastMessage: MessageModel{
        _lastMessage
    }
}
