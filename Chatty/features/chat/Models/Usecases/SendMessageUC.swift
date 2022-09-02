//
//  SendMessageUC.swift
//  Chatty
//
//  Created by sstonn on 28/08/2022.
//

import Foundation
import FirebaseFirestore

protocol SendMessageUCDelegate{
    func didSendMessageSuccessfully(_ host: SendMessageUC)
    func onSending(_ host: SendMessageUC)
    func didFailWithError(_ host: SendMessageUC, error: Error)
}

struct SendMessageUC : Usecase{
    typealias T = SendMessageUCParams
    var delegate: SendMessageUCDelegate?
    
    mutating func call(params: SendMessageUCParams) {
        delegate?.onSending(self)
        let data = params.entity.dictionary
        Firestore.firestore().collection("messages").addDocument(data: data){[self] (error) in
            if error != nil{
                delegate?.didFailWithError(self, error: error!)
                return
            }
            delegate?.didSendMessageSuccessfully(self)
        }
    }
}

struct SendMessageUCParams: UsecaseParams{
    let entity: MessageEntity
}
