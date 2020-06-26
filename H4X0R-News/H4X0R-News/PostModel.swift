//
//  PostModel.swift
//  H4X0R-News
//
//  Created by omrobbie on 26/06/20.
//  Copyright © 2020 omrobbie. All rights reserved.
//

import Foundation

struct Post: Identifiable {

    let id: String
    let title: String
}

let posts = [
    Post(id: "1", title: "Item 1"),
    Post(id: "2", title: "Item 2"),
    Post(id: "3", title: "Item 3"),
]
