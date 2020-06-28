//
//  Category.swift
//  Todoey
//
//  Created by omrobbie on 28/06/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class CategoryRealm: Object {

    @objc dynamic var name: String = ""
    let items = List<ItemRealm>()
}
