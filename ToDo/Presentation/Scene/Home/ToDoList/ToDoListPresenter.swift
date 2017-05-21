//
//  ToDoListPresenter.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/27/17.
//  Copyright (c) 2017 Takeshi Ihara. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Domain

class ToDoListPresenter: Presentable {

    // MARK: - Typealias

    typealias State = UserState
    typealias Event = UserEvent

    // MARK: - State

    enum UserState {
        case initial
        case prepared(viewModel: ToDoListViewModel)
        case tapedAdd
        case added
        case deleted
        case failed(error: Error)
    }

    // MARK: - User Event

    enum UserEvent {
        case prepare
        case tapAdd
        case add(title: String)
        case delete(index: Int)
    }

    // MARK: - Stream

    let viewReflecter = BehaviorSubject<State>(value: .initial)
    let eventReceiver = PublishSubject<Event>()

    // MARK: - Property

    private let useCase: ToDoUseCase
    private let disposeBag = DisposeBag()

    // MARK: - Initializer

    init(useCase: ToDoUseCase) {
        self.useCase = useCase

        eventReceiver
            .flatMap { [weak self] event -> Observable<State> in
                guard let weakSelf = self else {
                    return Observable<State>.just(.failed(error: .unknown))
                }

                switch event {
                case .prepare:
                    return weakSelf.useCase.findAll()
                        .flatMap {
                            Observable<State>.just(.prepared(viewModel: ToDoListViewModel(items: $0)))
                        }
                        .catchError {
                            Observable<State>.just(.failed(error: Error.create(with: $0)))
                        }
                case .tapAdd:
                    return Observable<State>.just(.tapedAdd)
                case .add(let title):
                    return weakSelf.useCase.create(with: title)
                        .flatMap {
                            weakSelf.useCase.findAll()
                        }
                        .flatMap {
                            Observable<State>.of(.added, .prepared(viewModel: ToDoListViewModel(items: $0)))
                        }
                        .catchError {
                            Observable<State>.just(.failed(error: Error.create(with: $0)))
                        }
                case .delete(let index):
                    return weakSelf.useCase.delete(index: index)
                        .flatMap {
                            weakSelf.useCase.findAll()
                        }
                        .flatMap {
                            Observable<State>.of(.deleted, .prepared(viewModel: ToDoListViewModel(items: $0)))
                        }
                        .catchError {
                            Observable<State>.just(.failed(error: Error.create(with: $0)))
                        }
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
