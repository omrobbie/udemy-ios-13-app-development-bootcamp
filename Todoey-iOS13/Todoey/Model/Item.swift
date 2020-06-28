//
//  Item.swift
//  Todoey
//
//  Created by omrobbie on 27/06/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

//- With FileManager
//class Item: Encodable, Decodable {
//
//    var title: String = ""
//    var done: Bool = false
//}

class ItemRealm: Object {

    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?

    var parentCategory = LinkingObjects(fromType: CategoryRealm.self, property: "items")
}
