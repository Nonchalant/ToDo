//
//  ToDoListPresenterSpec.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/29/17.
//  Copyright (c) 2017 Takeshi Ihara. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import RxTest

@testable import Presentation
@testable import Domain

// swiftlint:disable force_unwrapping
// swiftlint:disable function_body_length

class ToDoListPresenterSpec: QuickSpec {

    override func spec() {
        describe("ToDoListPresenter") {
            var presenter: ToDoListPresenter!
            var viewModel: ToDoListViewModel!
            var scheduler: TestScheduler!
            var disposeBag: DisposeBag!

            struct MockUseCaseImpl: ToDoUseCase {
                private let scheduler: TestScheduler
                init(scheduler: TestScheduler) {
                    self.scheduler = scheduler
                }

                func create(with title: String) -> Observable<Void> {
                    return scheduler.createColdObservable([
                        next(100, ())
                    ]).asObservable()
                }

                func findAll() -> Observable<[ToDoItem]> {
                    return scheduler.createColdObservable([
                        next(100, ToDoItemFactory.items)
                    ]).asObservable()
                }

                func delete(index: Int) -> Observable<Void> {
                    return scheduler.createColdObservable([
                        next(100, ())
                    ]).asObservable()
                }
            }

            beforeEach {
                scheduler = TestScheduler(initialClock: 0)
                presenter = ToDoListPresenter(useCase: MockUseCaseImpl(scheduler: scheduler))
                disposeBag = DisposeBag()
            }

            context("when prepare") {
                beforeEach {
                    viewModel = ToDoListViewModel(items: ToDoItemFactory.items)
                }

                it("then prepared") {
                    let observer = scheduler.createObserver(ToDoListPresenter.State.self)
                    let xs = scheduler.createColdObservable([
                        next(100, ToDoListPresenter.Event.prepare)
                    ])

                    scheduler.scheduleAt(100) {
                        xs
                            .bind(to: presenter.eventReceiver)
                            .addDisposableTo(disposeBag)
                    }

                    scheduler.scheduleAt(200) {
                        presenter.viewReflecter
                            .subscribe(observer)
                            .addDisposableTo(disposeBag)
                    }

                    scheduler.start()

                    expect(observer.events.count).to(equal(2))
                    expect(observer.events[0].time).to(equal(200))
                    expect(observer.events[1].time).to(equal(300))

                    let initial = observer.events[0].value.element

                    expect(initial).toNot(beNil())
                    expect(initial!).to(equal(ToDoListPresenter.State.initial))

                    let subject = observer.events[1].value.element

                    expect(subject).toNot(beNil())
                    expect(subject!).to(equal(ToDoListPresenter.State.prepared(viewModel: viewModel)))
                }
            }

            context("when tapAdd") {
                it("then tapedAdd") {
                    let observer = scheduler.createObserver(ToDoListPresenter.State.self)
                    let xs = scheduler.createColdObservable([
                        next(100, ToDoListPresenter.Event.tapAdd)
                    ])

                    scheduler.scheduleAt(100) {
                        xs
                            .bind(to: presenter.eventReceiver)
                            .addDisposableTo(disposeBag)
                    }

                    scheduler.scheduleAt(200) {
                        presenter.viewReflecter
                            .subscribe(observer)
                            .addDisposableTo(disposeBag)
                    }

                    scheduler.start()

                    expect(observer.events.count).to(equal(2))
                    expect(observer.events[0].time).to(equal(200))
                    expect(observer.events[1].time).to(equal(200))

                    let initial = observer.events[0].value.element

                    expect(initial).toNot(beNil())
                    expect(initial!).to(equal(ToDoListPresenter.State.initial))

                    let subject = observer.events[1].value.element

                    expect(subject).toNot(beNil())
                    expect(subject!).to(equal(ToDoListPresenter.State.tapedAdd))
                }
            }

            context("when add") {
                beforeEach {
                    viewModel = ToDoListViewModel(items: ToDoItemFactory.items)
                }

                it("then added and prepared") {
                    let observer = scheduler.createObserver(ToDoListPresenter.State.self)
                    let xs = scheduler.createColdObservable([
                        next(100, ToDoListPresenter.Event.add(title: "title"))
                    ])

                    scheduler.scheduleAt(100) {
                        xs
                            .bind(to: presenter.eventReceiver)
                            .addDisposableTo(disposeBag)
                    }

                    scheduler.scheduleAt(200) {
                        presenter.viewReflecter
                            .subscribe(observer)
                            .addDisposableTo(disposeBag)
                    }

                    scheduler.start()

                    expect(observer.events.count).to(equal(3))
                    expect(observer.events[0].time).to(equal(200))
                    expect(observer.events[1].time).to(equal(400))
                    expect(observer.events[2].time).to(equal(400))

                    let initial = observer.events[0].value.element

                    expect(initial).toNot(beNil())
                    expect(initial!).to(equal(ToDoListPresenter.State.initial))

                    let intermediate = observer.events[1].value.element

                    expect(intermediate).toNot(beNil())
                    expect(intermediate!).to(equal(ToDoListPresenter.State.added))

                    let subject = observer.events[2].value.element

                    expect(subject).toNot(beNil())
                    expect(subject!).to(equal(ToDoListPresenter.State.prepared(viewModel: viewModel)))
                }
            }

            context("when delete") {
                beforeEach {
                    viewModel = ToDoListViewModel(items: ToDoItemFactory.items)
                }

                it("then deleted and prepared") {
                    let observer = scheduler.createObserver(ToDoListPresenter.State.self)
                    let xs = scheduler.createColdObservable([
                        next(100, ToDoListPresenter.Event.delete(index: 0))
                    ])

                    scheduler.scheduleAt(100) {
                        xs
                            .bind(to: presenter.eventReceiver)
                            .addDisposableTo(disposeBag)
                    }

                    scheduler.scheduleAt(200) {
                        presenter.viewReflecter
                            .subscribe(observer)
                            .addDisposableTo(disposeBag)
                    }

                    scheduler.start()

                    expect(observer.events.count).to(equal(3))
                    expect(observer.events[0].time).to(equal(200))
                    expect(observer.events[1].time).to(equal(400))
                    expect(observer.events[2].time).to(equal(400))

                    let initial = observer.events[0].value.element

                    expect(initial).toNot(beNil())
                    expect(initial!).to(equal(ToDoListPresenter.State.initial))

                    let intermediate = observer.events[1].value.element

                    expect(intermediate).toNot(beNil())
                    expect(intermediate!).to(equal(ToDoListPresenter.State.deleted))

                    let subject = observer.events[2].value.element

                    expect(subject).toNot(beNil())
                    expect(subject!).to(equal(ToDoListPresenter.State.prepared(viewModel: viewModel)))
                }
            }
        }
    }
}
