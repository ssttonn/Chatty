//
//  ChatRoomEntity.swift
//  Chatty
//
//  Created by GONOSEN on 20/08/2022.
//

import Foundation


struct ChatRoomEntity: Entity{
    var id: String?
    let name: String?
    let last_message_id: String?
    let participant_ids: [String]?
    let room_name: String?
    let total_unread_message: Int?
    let type: String?
    let updated_at: Int?
    let created_at: Int?
    
    init(){
        id = ""
        name = ""
        last_message_id = ""
        participant_ids = []
        room_name = ""
        total_unread_message = 0
        type = "none"
        updated_at = 0
        created_at = 0
    }
}
