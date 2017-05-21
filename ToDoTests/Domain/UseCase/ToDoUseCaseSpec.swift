//
//  ToDoUseCaseSpec.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/22/17.
//  Copyright (c) 2017 Takeshi Ihara. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import RxBlocking

@testable import Domain

// swiftlint:disable force_unwrapping
// swiftlint:disable force_try

class ToDoUseCaseSpec: QuickSpec {

    override func spec() {
        describe("ToDoUseCase") {
            var useCase: ToDoUseCase!

            class MockRepository: ToDoRepository {
                func create(with title: String) -> Single<Void> {
                    return Single.just()
                }

                func find(byId id: String) -> Single<ToDo?> {
                    return Single.just(ToDoFactory.item)
                }

                func findAll() -> Single<[ToDo]> {
                    return Single.just(ToDoFactory.items)
                }

                func delete(byId id: String) -> Single<Void> {
                    return Single.just()
                }

                func deleteAll() -> Single<Void> {
                    return Single.just()
                }
            }

            beforeEach {
                useCase = ToDoUseCaseImpl(repository: MockRepository())
            }

            context("when create") {
                context("when success") {
                    beforeEach {
                        useCase = ToDoUseCaseImpl(repository: MockRepository())
                    }

                    it("then created") {
                        do {
                            try useCase.create(with: "title").toBlocking().first()
                        } catch let error {
                            expect(error).to(beNil())
                        }
                    }
                }

                context("when failure") {
                    class FailCreateRepository: MockRepository {
                        override func create(with title: String) -> Single<Void> {
                            return Single.error(Error.unknown)
                        }
                    }

                    beforeEach {
                        useCase = ToDoUseCaseImpl(repository: FailCreateRepository())
                    }

                    it("then created") {
                        do {
                            try useCase.create(with: "title").toBlocking().first()
                        } catch let error {
                            expect(error).toNot(beNil())
                            expect(error as? Domain.Error).to(equal(.unknown))
                        }
                    }
                }
            }

            context("when findAll") {
                context("when success") {
                    beforeEach {
                        useCase = ToDoUseCaseImpl(repository: MockRepository())
                    }

                    it("then foundAll") {
                        do {
                            let result = try useCase.findAll().toBlocking().first()
                            expect(result).toNot(beNil())
                            expect(result!).to(equal(ToDoItemFactory.items))
                        } catch let error {
                            expect(error).to(beNil())
                        }
                    }
                }

                context("when failure") {
                    class FailFindAllRepository: MockRepository {
                        override func findAll() -> Single<[ToDo]> {
                            return Single.error(Error.unknown)
                        }
                    }

                    beforeEach {
                        useCase = ToDoUseCaseImpl(repository: FailFindAllRepository())
                    }

                    it("then error") {
                        do {
                            let result = try useCase.findAll().toBlocking().first()
                            expect(result).toNot(beNil())
                        } catch let error {
                            expect(error).toNot(beNil())
                            expect(error as? Domain.Error).to(equal(.unknown))
                        }
                    }
                }
            }

            context("when delete") {
                context("when success") {
                    beforeEach {
                        useCase = ToDoUseCaseImpl(repository: MockRepository())
                        _ = try! useCase.findAll().toBlocking().first()
                    }

                    it("then deleted") {
                        do {
                            try useCase.delete(index: 0).toBlocking().first()
                        } catch let error {
                            expect(error).to(beNil())
                        }
                    }
                }

                context("when failure") {
                    class FailDeleteRepository: MockRepository {
                        override func delete(byId id: String) -> Single<Void> {
                            return Single.error(Error.unknown)
                        }
                    }

                    beforeEach {
                        useCase = ToDoUseCaseImpl(repository: FailDeleteRepository())
                        _ = try! useCase.findAll().toBlocking().first()
                    }

                    it("then error") {
                        do {
                            try useCase.delete(index: 0).toBlocking().first()
                        } catch let error {
                            expect(error).toNot(beNil())
                            expect(error as? Domain.Error).to(equal(.unknown))
                        }
                    }
                }
            }
        }
    }
}
