//
//  ToDoDataStore.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/22/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

protocol ToDoDataStore {
    func create(with todo: ToDo) throws
    func find(byId id: String) -> ToDo?
    func findAll() -> [ToDo]
    func delete(byId id: String) throws
    func deleteAll() throws
}

struct RealmToDoDataStore: ToDoDataStore {
    private let realm: Realm!

    init(realm: Realm) {
        self.realm = realm
    }

    func create(with todo: ToDo) throws {
        do {
            try realm.write {
                realm.add(todo)
            }
        } catch {
            throw Error.unknown
        }
    }

    func find(byId id: String) -> ToDo? {
        return realm.objects(ToDo.self).filter({ $0.id == id }).first
    }

    func findAll() -> [ToDo] {
        return Array(realm.objects(ToDo.self))
    }

    func delete(byId id: String) throws {
        guard let todo = find(byId: id) else {
            throw Error.notFound
        }

        do {
            try realm.write {
                realm.delete(todo)
            }
        } catch {
            throw Error.unknown
        }
    }

    func deleteAll() throws {
        for todo in findAll() {
            do {
                try realm.write {
                    realm.delete(todo)
                }
            } catch {
                throw Error.unknown
            }
        }
    }
}
