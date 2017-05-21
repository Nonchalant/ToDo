//
//  ToDoExtension.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/28/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import UIKit

public struct ToDoExtension<Base> {
    public let base: Base
    init (_ base: Base) {
        self.base = base
    }
}

public protocol ToDoExtensionCompatible {
    associatedtype Compatible
    static var todo: Compatible.Type { get }
    var todo: Compatible { get }
}

extension ToDoExtensionCompatible {
    public static var todo: ToDoExtension<Self>.Type {
        return ToDoExtension<Self>.self
    }

    public var todo: ToDoExtension<Self> {
        return ToDoExtension(self)
    }
}

extension UIView: ToDoExtensionCompatible {}
