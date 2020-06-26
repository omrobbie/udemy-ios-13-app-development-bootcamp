//
//  PostData.swift
//  H4X0R-News
//
//  Created by omrobbie on 26/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation

struct Results: Decodable {

    let hits: [Post]
}

struct Post: Decodable, Identifiable {

    let objectID: String
    let points: Int
    let title: String
    let url: String?

    var id: String {
        return objectID
    }
}
