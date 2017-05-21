//
//  UIAlertBuilder.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/28/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import UIKit

struct UIAlertBuilder {
    static func add(okAction: ((String) -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: "ToDo", message: "", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "OK", style: .default) { _ in
            guard let title = alert.textFields?.first?.text else {
                return
            }
            okAction?(title)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        alert.addAction(addAction)
        alert.addAction(cancelAction)
        alert.addTextField(configurationHandler: nil)

        return alert
    }

    static func error(error: Error, fallback: ((Error) -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: nil, message: error.message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { _ in
            fallback?(error)
        }

        alert.addAction(alertAction)

        return alert
    }

    static func confirm(title: String? = nil,
                        message: String? = nil,
                        okAction: (() -> Void)? = nil,
                        cancelAction: (() -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            okAction?()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            cancelAction?()
        }

        alert.addAction(okAction)
        alert.addAction(cancelAction)

        return alert
    }
}
