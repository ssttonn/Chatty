//
//  MessageEntity.swift
//  Chatty
//
//  Created by GONOSEN on 20/08/2022.
//

import Foundation

struct MessageEntity: Entity{
    var id: String?
    let content: String?
    let roomId: String?
    let senderId: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case content
        case roomId = "room_id"
        case senderId = "sender_id"
    }
}
