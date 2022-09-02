//
//  LoginManager.swift
//  Chatty
//
//  Created by GONOSEN on 12/08/2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol LoginUsecaseDelegate{
    func didLoginSuccessfully(_ host: LoginWithEmailAndPasswordUC)
    func onProgressing(_ host: LoginWithEmailAndPasswordUC)
    func didFailWithError(_ host: LoginWithEmailAndPasswordUC,error: Error)
}

struct LoginWithEmailAndPasswordUC: Usecase{
    typealias T = LoginUsecaseParams
    var delegate: LoginUsecaseDelegate?
    
    func call(params: LoginUsecaseParams) {
        delegate?.onProgressing(self)
        FirebaseAuth.Auth.auth().signIn(withEmail: params.email, password: params.password){ result, error in
            if error != nil{
                delegate?.didFailWithError(self, error: error!)
                return
            }
            delegate?.didLoginSuccessfully(self)
        }
    }
}

struct LoginUsecaseParams: UsecaseParams{
    var email: String
    var password: String
}
