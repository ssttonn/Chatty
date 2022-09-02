//
//  AuthDataSource.swift
//  Chatty
//
//  Created by GONOSEN on 13/08/2022.
//

import Foundation

protocol AuthDataSource{
    func login(email: String, password: String, completion: ResultDelegate where ResultDelegate.T == Bool)
    func register(email: String, password: String)
}
