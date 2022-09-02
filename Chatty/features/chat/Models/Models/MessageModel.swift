//
//  MessageModel.swift
//  Chatty
//
//  Created by GONOSEN on 20/08/2022.
//

import Foundation

enum MessageType: String{
    case normalText
}

struct MessageModel: Model{
    typealias T = MessageEntity
    var _entity: MessageEntity?
    
    var messageContent: String {
        _entity?.content ?? ""
    }
    
    var isIncomingMessage: Bool = false
    
}
