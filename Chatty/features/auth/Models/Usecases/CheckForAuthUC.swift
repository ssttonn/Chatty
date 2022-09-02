//
//  CheckForAuthUC.swift
//  Chatty
//
//  Created by sstonn on 27/08/2022.
//

import Foundation
import FirebaseAuth

protocol CheckForAuthUsecaseDelegate{
    func didChangeAuthState(_ host: CheckForAuthUC,loggedIn: Bool)
}

struct CheckForAuthUC: Usecase{
    typealias T = NoParam
    var delegate: CheckForAuthUsecaseDelegate?
    
    func call(params: NoParam) {
        delegate?.didChangeAuthState(self, loggedIn: FirebaseAuth.Auth.auth().currentUser != nil)
    }
}


