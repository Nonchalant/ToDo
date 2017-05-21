//
//  ToDoUseCase.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/22/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import Foundation
import RxSwift

public protocol ToDoUseCase {
    func create(with title: String) -> Observable<Void>
    func findAll() -> Observable<[ToDoItem]>
    func delete(index: Int) -> Observable<Void>
}

class ToDoUseCaseImpl: ToDoUseCase {
    private let repository: ToDoRepository!
    private var todos: [ToDo] = []

    init(repository: ToDoRepository) {
        self.repository = repository
    }

    func create(with title: String) -> Observable<Void> {
        return repository.create(with: title).asObservable()
    }

    func findAll() -> Observable<[ToDoItem]> {
        return repository.findAll().asObservable()
            .do(onNext: { [weak self] todos in
                self?.todos = todos
            })
            .map { $0.map { ToDoItemTranslator.translate(base: $0) } }
    }

    func delete(index: Int) -> Observable<Void> {
        guard let id = todos.dropFirst(index).first?.id else {
            return Observable.error(Error.notFound)
        }
        return repository.delete(byId: id).asObservable()
    }
}
