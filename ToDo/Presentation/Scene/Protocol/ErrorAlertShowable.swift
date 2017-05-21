//
//  ErrorAlertShowable.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/28/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

protocol ErrorAlertShowable {
    func showErrorAlert(_ error: Error, fallback: ((Error) -> Void)?)
}

extension ErrorAlertShowable where Self: UIViewController {
    func showErrorAlert(_ error: Error, fallback: ((Error) -> Void)? = nil) {
        let alert = UIAlertBuilder.error(error: error, fallback: fallback)
        self.present(alert, animated: true)
    }
}
