//
//  ListenToRoomListUC.swift
//  Chatty
//
//  Created by GONOSEN on 20/08/2022.
//

import Foundation
import FirebaseFirestore

protocol ListenToRoomListUCDelegate{
    func onRoomChatAdded(_ host: ListenToRoomListUC, addedRoom: ChatRoomModel)
    func onRoomChatUpdated(_ host: ListenToRoomListUC, updatedRoom: ChatRoomModel)
    func onRoomChatDeleted(_ host: ListenToRoomListUC, deletedRoom: ChatRoomModel)
    func onProgressing(_ host: ListenToRoomListUC)
    func didFailWithError(_ host: ListenToRoomListUC, error: Error)
}

struct ListenToRoomListUC: Usecase{
    typealias T = ListenToRoomListParams
    var delegate: ListenToRoomListUCDelegate?
    private lazy var listener: ListenerRegistration? = nil
    
    mutating func call(params: ListenToRoomListParams) {
        delegate?.onProgressing(self)
        guard let userId = params.userId else{
            self.delegate?.didFailWithError(self, error: fatalError("No user id"))
            return
        }
        let query = Firestore.firestore().collection("rooms").whereField("participant_ids", arrayContains: userId)
        if let roomName = params.roomName {
            query.whereField("name", isEqualTo: roomName)
        }
        listener = query.addSnapshotListener{[self] (querySnapshot, error) in
            if let error = error {
                self.delegate?.didFailWithError(self, error: error)
                return
            }
            querySnapshot?.documentChanges.forEach{ diffDoc in
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: diffDoc.document.data(), options: .prettyPrinted)
                    var roomEntity = try JSON.decoder.decode(ChatRoomEntity.self, from: jsonData)
                    roomEntity.id = diffDoc.document.documentID
                    var roomModel = ChatRoomModel()
                    roomModel.withEntity(entity: roomEntity)
                    switch diffDoc.type{
                    case .added:
                        delegate?.onRoomChatAdded(self, addedRoom: roomModel)
                    case .modified:
                        delegate?.onRoomChatUpdated(self, updatedRoom: roomModel)
                    case .removed:
                        delegate?.onRoomChatDeleted(self, deletedRoom: roomModel)
                    }
                    
                } catch {
                    self.delegate?.didFailWithError(self, error: error)
                }
            }
        }
    }
    
    mutating func dispose() {
        listener?.remove()
    }
}

struct ListenToRoomListParams: UsecaseParams{
    var userId: String?
    var roomName: String?
}

