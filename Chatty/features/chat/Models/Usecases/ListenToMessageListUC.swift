//
//  ListenToMessageListUC.swift
//  Chatty
//
//  Created by sstonn on 28/08/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

protocol ListenToMessageListUCDelegate{
    func onNewMessageCame(_ host: ListenToMessageListUC, addedMessage: MessageModel)
    func onMessageUpdated(_ host: ListenToMessageListUC, updatedMessage: MessageModel)
    func onMessageDeleted(_ host: ListenToMessageListUC, deletedMessage: MessageModel)
    func onFetchingMessages(_ host: ListenToMessageListUC)
    func didFailWithError(_ host: ListenToMessageListUC, error: Error)
}

struct ListenToMessageListUC: Usecase{
    typealias T = ListenToMessageListParams
    var delegate: ListenToMessageListUCDelegate?
    private lazy var listener: ListenerRegistration? = nil
    
    mutating func call(params: ListenToMessageListParams) {
        self.delegate?.onFetchingMessages(self)
        guard let roomId = params.roomId else {
            self.delegate?.didFailWithError(self, error: fatalError("No room id"))
            return
        }
        let query = Firestore.firestore().collection("messages").whereField("room_id", isEqualTo: roomId)
        listener = query.addSnapshotListener{[self] (snapshot, error) in
            if let error = error {
                self.delegate?.didFailWithError(self, error: error)
                return
            }
            snapshot?.documentChanges.forEach{ doc in
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: doc.document.data(), options: .prettyPrinted)
                    var messageEntity = try JSON.decoder.decode(MessageEntity.self, from: jsonData)
                    messageEntity.id = doc.document.documentID
                    var messageModel = MessageModel()
                    messageModel.withEntity(entity: messageEntity)
                    messageModel.isIncomingMessage = FirebaseAuth.Auth.auth().currentUser?.uid != messageEntity.senderId
                    switch doc.type{
                    case.added:
                        delegate?.onNewMessageCame(self, addedMessage: messageModel)
                    case .modified:
                        delegate?.onMessageUpdated(self, updatedMessage: messageModel)
                    case .removed:
                        delegate?.onMessageDeleted(self, deletedMessage: messageModel)
                    }
                }catch{
                    self.delegate?.didFailWithError(self, error: error)
                }
            }
        }
    }
    
    mutating func dispose() {
        listener?.remove()
    }
}

struct ListenToMessageListParams: UsecaseParams{
    var roomId: String?    
}
