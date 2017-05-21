//
//  ToDo.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/22/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class ToDo: Object {
    dynamic private(set) var id: String = ""
    dynamic private(set) var title: String = ""

    init(id: String = UUID().uuidString, title: String) {
        self.id = id
        self.title = title
        super.init()
    }

    required init() {
        super.init()
    }

    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }

    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
}
