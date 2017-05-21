//
//  SplashPresenterSpec.swift
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

// swiftlint:disable force_unwrapping

class SplashPresenterSpec: QuickSpec {

    override func spec() {
        describe("SplashPresenter") {
            var presenter: SplashPresenter!
            var scheduler: TestScheduler!
            var disposeBag: DisposeBag!

            beforeEach {
                scheduler = TestScheduler(initialClock: 0)
                presenter = Mock.container.resolve(SplashPresenter.self)
                disposeBag = DisposeBag()
            }

            context("when prepare") {
                it("then goMain") {
                    let observer = scheduler.createObserver(SplashPresenter.State.self)
                    let xs = scheduler.createColdObservable([
                        next(100, SplashPresenter.Event.prepare)
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
                    expect(initial!).to(equal(SplashPresenter.State.initial))

                    let subject = observer.events[1].value.element

                    expect(subject).toNot(beNil())
                    expect(subject!).to(equal(SplashPresenter.State.goMain))
                }
            }
        }
    }
}
