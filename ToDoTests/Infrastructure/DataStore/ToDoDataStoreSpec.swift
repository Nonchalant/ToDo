//
//  ToDoDataStoreSpec.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/22/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import Quick
import Nimble
import RealmSwift

@testable import Infrastructure

// swiftlint:disable force_unwrapping
// swiftlint:disable force_try

class ToDoDataStoreSpec: QuickSpec {

    override func spec() {
        describe("ToDoDataStore") {
            var dataStore: ToDoDataStore!
            var realm: Realm!

            beforeEach {
                dataStore = Mock.container.resolve(ToDoDataStore.self)!
            }

            context("when create") {
                var todo: ToDo!

                beforeEach {
                    realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "inMemory"))
                    try! realm.write { realm.deleteAll() }
                    dataStore = RealmToDoDataStore(realm: realm)

                    todo = ToDo(title: "create")
                }

                it("then created") {
                    let before = dataStore.find(byId: todo.id)
                    expect(before).to(beNil())

                    do {
                        try dataStore.create(with: todo)
                    } catch {
                        expect(error).to(beNil())
                    }

                    let after = dataStore.find(byId: todo.id)
                    expect(after).toNot(beNil())
                }
            }

            context("when find") {
                var todo: ToDo!

                beforeEach {
                    realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "inMemory"))
                    try! realm.write { realm.deleteAll() }
                    dataStore = RealmToDoDataStore(realm: realm)

                    todo = ToDo(id: "id", title: "find")
                    try! dataStore.create(with: todo)
                }

                it("then found") {
                    let result = dataStore.find(byId: todo.id)
                    expect(result).toNot(beNil())
                    expect(result!.id).to(equal(todo.id))
                    expect(result!.title).to(equal(todo.title))
                }
            }

            context("when findAll") {
                var todo: ToDo!

                beforeEach {
                    realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "inMemory"))
                    try! realm.write { realm.deleteAll() }
                    dataStore = RealmToDoDataStore(realm: realm)

                    todo = ToDo(title: "findAll")
                }

                it("then created") {
                    let before = dataStore.findAll()
                    expect(before.count).to(equal(0))

                    do {
                        try dataStore.create(with: todo)
                    } catch {
                        expect(error).to(beNil())
                    }

                    let after = dataStore.findAll()
                    expect(after.count).to(equal(1))
                }
            }

            context("when delete") {
                var todo: ToDo!
                var id: String!

                beforeEach {
                    realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "inMemory"))
                    try! realm.write { realm.deleteAll() }
                    dataStore = RealmToDoDataStore(realm: realm)

                    todo = ToDo(id: "id", title: "delete")
                    id = todo.id
                    try! dataStore.create(with: todo)
                }

                it("then deleted") {
                    let before = dataStore.find(byId: id)
                    expect(before).toNot(beNil())

                    do {
                        try dataStore.delete(byId: id)
                    } catch {
                        expect(error).to(beNil())
                    }

                    let after = dataStore.find(byId: id)
                    expect(after).to(beNil())
                }
            }

            context("when deleteAll") {
                var todo1: ToDo!
                var todo2: ToDo!

                beforeEach {
                    realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: "inMemory"))
                    try! realm.write { realm.deleteAll() }
                    dataStore = RealmToDoDataStore(realm: realm)

                    todo1 = ToDo(id: "id1", title: "deleteAll")
                    try! dataStore.create(with: todo1)

                    todo2 = ToDo(id: "id2", title: "deleteAll")
                    try! dataStore.create(with: todo2)
                }

                it("then deletedAll") {
                    let before = dataStore.findAll()
                    expect(before.count).to(equal(2))

                    do {
                        try dataStore.deleteAll()
                    } catch {
                        expect(error).to(beNil())
                    }

                    let after = dataStore.findAll()
                    expect(after.count).to(equal(0))
                }
            }
        }
    }
}
