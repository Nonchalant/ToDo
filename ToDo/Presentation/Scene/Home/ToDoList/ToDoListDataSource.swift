//
//  ToDoListDataSource.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/28/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Domain

class ToDoListDataSource: NSObject, UITableViewDataSource, UITableViewDelegate, RxTableViewDataSourceType, SectionedViewDataSourceType {
    typealias Element = [ToDoItem]

    fileprivate var items: Element = []
    private var elementSubject: PublishSubject<Element> = PublishSubject<Element>()

    var element: Observable<Element> {
        return elementSubject.asObservable()
    }

    func load(_ element: Element) {
        elementSubject.onNext(element)
    }

    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.todo.dequeueReusableCell(of: ToDoListCell.self, for: indexPath)
        cell.textLabel?.text = items[indexPath.row].title
        return cell
    }

    // MARK: - RxTableViewDataSourceType

    func tableView(_ tableView: UITableView, observedEvent: Event<Element>) {
        UIBindingObserver(UIElement: self) { (dataSource, element) in
            dataSource.items = element
            tableView.reloadData()
        }.on(observedEvent)
    }

    // MARK: - SectionedViewDataSourceType

    func model(at indexPath: IndexPath) throws -> Any {
        return items[indexPath.row]
    }
}
