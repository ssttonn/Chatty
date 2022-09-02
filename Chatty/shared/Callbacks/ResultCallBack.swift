//
//  ResultCallBack.swift
//  Chatty
//
//  Created by GONOSEN on 13/08/2022.
//

import Foundation

protocol ResultDelegate{
    associatedtype T
    var genericProperty: T { get set }
    func didSuccess(result: T)
    func didFailWithError(error: Error)
}
