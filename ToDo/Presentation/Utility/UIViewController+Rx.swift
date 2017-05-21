//
//  UIViewController+Rx.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/27/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    var viewWillAppear: Observable<Void> {
        return sentMessage(#selector(UIViewController.viewWillAppear(_:))).map { _ in () }.shareReplay(1)
    }

    var viewDidAppear: Observable<Void> {
        return sentMessage(#selector(UIViewController.viewDidAppear(_:))).map { _ in () }.shareReplay(1)
    }

    var viewWillDisappear: Observable<Void> {
        return sentMessage(#selector(UIViewController.viewWillDisappear(_:))).map { _ in () }.shareReplay(1)
    }

    var viewDidDisappear: Observable<Void> {
        return sentMessage(#selector(UIViewController.viewDidDisappear(_:))).map { _ in () }.shareReplay(1)
    }

    var dismiss: Observable<Void> {
        return sentMessage(#selector(UIViewController.dismiss(animated:completion:))).map { _ in () }.shareReplay(1)
    }
}
