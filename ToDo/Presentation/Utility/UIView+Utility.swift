//
//  UIView+Utility.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/28/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import UIKit
import Utility

extension ToDoExtension where Base: UIView {
    static var className: String {
        let type = Mirror(reflecting: self).subjectType
        guard let name = String(describing: type).components(separatedBy: CharacterSet(charactersIn: "<>.")).dropFirst().first else {
            return ""
        }
        return name
    }
}
