//
//  Post.swift
//  A3
//
//  Created by Vin Bui on 10/31/23.
//

import Foundation

struct Post: Decodable {
        let id: String
        var likes: [String]
        let message: String
        let time: Date
}

