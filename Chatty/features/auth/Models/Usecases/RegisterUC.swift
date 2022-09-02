//
//  RegisterManager.swift
//  Chatty
//
//  Created by GONOSEN on 12/08/2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol RegisterUCDelegate{
    func didRegisterSuccessfully(_ host: RegisterUC)
    func onProgressing(_ host: RegisterUC)
    func didFailWithError(_ host: RegisterUC, error: Error)
}


struct RegisterUC: Usecase{
    typealias T = RegisterUCParams
    var delegate: RegisterUCDelegate?
    
    func call(params: RegisterUCParams) {
        delegate?.onProgressing(self)
        FirebaseAuth.Auth.auth().createUser(withEmail: params.email, password: params.password){ result, error in
            if error != nil{
                delegate?.didFailWithError(self, error: error!)
                return
            }
            if let user = result?.user{
                var dicParams = params.dictionary
                dicParams.removeValue(forKey: "password")
                Firestore.firestore().collection("users").document(user.uid).setData(dicParams){ error in
                    if error != nil{
                        delegate?.didFailWithError(self, error: error!)
                        return
                    }
                    delegate?.didRegisterSuccessfully(self)
                }
            }
        }
    }
}


struct RegisterUCParams: UsecaseParams{
    let email: String
    let password: String
    let username: String
}
