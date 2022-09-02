//
//  Model.swift
//  Chatty
//
//  Created by GONOSEN on 20/08/2022.
//

import Foundation

protocol Model: Equatable{
    associatedtype T: Entity
    var _entity: T? { get set }
}

