//
//  Entity.swift
//  Chatty
//
//  Created by GONOSEN on 20/08/2022.
//

import Foundation

protocol Entity: Encodable, Decodable{
    var id: String? { get set }
}
