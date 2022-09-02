//
//  Usecase.swift
//  Chatty
//
//  Created by GONOSEN on 13/08/2022.
//

import Foundation

protocol Usecase{
    associatedtype T where T: UsecaseParams
    mutating func call(params: T)
    mutating func dispose()
}

extension Usecase {
    func dispose(){
        return
    }
}

protocol UsecaseParams: Encodable{}

protocol UsecaseDelegate{
    associatedtype H where H: Usecase
    func didFailWithError(_ host: H, error: Error)
    func onProgressing(_ host: H)
}

struct NoParam: UsecaseParams{}
