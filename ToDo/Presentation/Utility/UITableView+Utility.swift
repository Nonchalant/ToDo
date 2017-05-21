//
//  UITableView+Utility.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/28/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import UIKit
import Utility

extension ToDoExtension where Base: UITableView {
    func deselectAllSelectedRows(animated: Bool) {
        base.indexPathsForSelectedRows?.forEach {
            base.deselectRow(at: $0, animated: animated)
        }
    }

    func dequeueReusableCell<T: UITableViewCell>(of: T.Type, for indexPath: IndexPath) -> T where T: ToDoExtensionCompatible {
        guard let cell = base.dequeueReusableCell(withIdentifier: T.todo.className, for: indexPath) as? T else {
            fatalError("cannot dequeue \(T.self)")
        }
        return cell
    }

    func register<T: UITableViewCell>(_ cellClass: T.Type) where T: ToDoExtensionCompatible {
        base.register(cellClass, forCellReuseIdentifier: cellClass.todo.className)
    }
}
