//
//  DataModel.swift
//  Concurrency
//
//  Created by Khrystyna Matasova on 07/07/2022.
//

import Foundation

struct Person: Codable, Hashable {
    let first_name: String
    let last_name: String
    let age: Int
}
