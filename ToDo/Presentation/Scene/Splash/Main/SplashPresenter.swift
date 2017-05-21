//
//  SplashPresenter.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/28/17.
//  Copyright (c) 2017 Takeshi Ihara. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SplashPresenter: Presentable {

    // MARK: - TypeAlias

    typealias State = UserState
    typealias Event = UserEvent

    // MARK: - User State

    enum UserState {
        case initial
        case goMain
    }

    // MARK: - User Event

    enum UserEvent {
        case prepare
    }

    // MARK: - Stream

    let viewReflecter = BehaviorSubject<State>(value: .initial)
    let eventReceiver = PublishSubject<Event>()

    // MARK: - Property

    private let disposeBag = DisposeBag()

    // MARK: - Initializer

    init() {
        eventReceiver
            .flatMap { event -> Observable<State> in
                switch event {
                case .prepare:
                    return Observable.just(.goMain)
                }
            }
            .bind(to: viewReflecter)
            .addDisposableTo(disposeBag)
    }

    // MARK: - Public

    func send(with event: Event) {
        eventReceiver.onNext(event)
    }
}
