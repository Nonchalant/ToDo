//
//  ToDoRepositorySpec.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/22/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import RxBlocking
import RealmSwift

@testable import Domain
@testable import Infrastructure

// swiftlint:disable force_unwrapping
// swiftlint:disable function_body_length

class ToDoRepositorySpec: QuickSpec {

    override func spec() {
        describe("ToDoRepository") {
            var repository: ToDoRepository!
            var dataStore: MockToDoDataStore!

            class MockToDoDataStore: ToDoDataStore {
                private(set) var calledCreateCount = 0
                fileprivate var calledFindCount = 0
                private(set) var calledFindAllCount = 0
                private(set) var calledDeleteCount = 0
                private(set) var calledDeleteAllCount = 0

                func create(with todo: Infrastructure.ToDo) throws {
                    calledCreateCount += 1
                }

                func find(byId id: String) -> Infrastructure.ToDo? {
                    calledFindCount += 1
                    return ToDoFactory.todo
                }

                func findAll() -> [Infrastructure.ToDo] {
                    calledFindAllCount += 1
                    return ToDoFactory.todos
                }

                func delete(byId id: String) throws {
                    calledDeleteCount += 1
                }

                func deleteAll() throws {
                    calledDeleteAllCount += 1
                }
            }

            beforeEach {
                repository = Mock.container.resolve(ToDoRepository.self)!
            }

            context("when create") {
                beforeEach {
                    dataStore = MockToDoDataStore()
                    repository = ToDoRepositoryImpl(dataStore: dataStore)
                }

                it("then created") {
                    do {
                        expect(dataStore.calledCreateCount).to(equal(0))

                        try repository.create(with: "title").toBlocking().first()

                        expect(dataStore.calledCreateCount).to(equal(1))
                    } catch {
                        expect(error).to(beNil())
                    }
                }
            }

            context("when find") {
                context("when todo is existed") {
                    beforeEach {
                        dataStore = MockToDoDataStore()
                        repository = ToDoRepositoryImpl(dataStore: dataStore)
                    }

                    it("then found") {
                        do {
                            expect(dataStore.calledFindCount).to(equal(0))

                            let result = try repository.find(byId: "id").toBlocking().first()
                            expect(result).toNot(beNil())
                            expect(result!).toNot(beNil())
                            expect(result!!.id).to(equal(ToDoFactory.todo.id))
                            expect(result!!.title).to(equal(ToDoFactory.todo.title))

                            expect(dataStore.calledFindCount).to(equal(1))
                        } catch {
                            expect(error).to(beNil())
                        }
                    }
                }

                context("when todo is not existed") {
                    class NoToDoDataStore: MockToDoDataStore {
                        override func find(byId id: String) -> Infrastructure.ToDo? {
                            calledFindCount += 1
                            return nil
                        }

                    }

                    beforeEach {
                        dataStore = NoToDoDataStore()
                        repository = ToDoRepositoryImpl(dataStore: dataStore)
                    }

                    it("then found") {
                        do {
                            expect(dataStore.calledFindCount).to(equal(0))

                            let result = try repository.find(byId: "id").toBlocking().first()
                            expect(result).toNot(beNil())
                            expect(result!).to(beNil())

                            expect(dataStore.calledFindCount).to(equal(1))
                        } catch {
                            expect(error).to(beNil())
                        }
                    }
                }
            }

            context("when findAll") {
                beforeEach {
                    dataStore = MockToDoDataStore()
                    repository = ToDoRepositoryImpl(dataStore: dataStore)
                }

                it("then found all") {
                    do {
                        expect(dataStore.calledFindAllCount).to(equal(0))

                        let result = try repository.findAll().toBlocking().first()
                        expect(result).toNot(beNil())
                        for (index, todo) in result!.enumerated() {
                            expect(todo.id).to(equal(ToDoFactory.todos[index].id))
                            expect(todo.title).to(equal(ToDoFactory.todos[index].title))
                        }

                        expect(dataStore.calledFindAllCount).to(equal(1))
                    } catch {
                        expect(error).to(beNil())
                    }
                }
            }

            context("when delete") {
                beforeEach {
                    dataStore = MockToDoDataStore()
                    repository = ToDoRepositoryImpl(dataStore: dataStore)
                }

                it("then deleted") {
                    do {
                        expect(dataStore.calledDeleteCount).to(equal(0))

                        _ = try repository.delete(byId: "id").toBlocking().first()

                        expect(dataStore.calledDeleteCount).to(equal(1))
                    } catch {
                        expect(error).to(beNil())
                    }
                }
            }

            context("when deleteAll") {
                beforeEach {
                    dataStore = MockToDoDataStore()
                    repository = ToDoRepositoryImpl(dataStore: dataStore)
                }

                it("then deleted all") {
                    do {
                        expect(dataStore.calledDeleteAllCount).to(equal(0))

                        _ = try repository.deleteAll().toBlocking().first()

                        expect(dataStore.calledDeleteAllCount).to(equal(1))
                    } catch {
                        expect(error).to(beNil())
                    }
                }
            }
        }
    }
}
