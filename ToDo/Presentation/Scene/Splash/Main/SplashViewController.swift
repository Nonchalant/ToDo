//
//  SplashViewController.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/28/17.
//  Copyright (c) 2017 Takeshi Ihara. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SplashViewController: UIViewController {

    // MARK: - TypeAlias

    typealias Event = SplashPresenter.Event

    // MARK: - Constants

    private struct Constants {
        static let duration: TimeInterval = 0.1
    }

    // MARK: - Property

    var presenter: SplashPresenter!
    private let disposeBag = DisposeBag()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUIBindings()
        setupEventBindings()
    }

    // MARK: - Private

    private func setupUIBindings() {
        presenter.viewReflecter
            .asDriver(onErrorDriveWith: .empty())
            .drive(
                onNext: { [weak self] state in
                    guard let weakSelf = self else {
                        return
                    }

                    switch state {
                    case .initial:
                        break
                    case .goMain:
                        weakSelf.performSegue(withIdentifier: Storyboard.home.segueIdentifier, sender: nil)
                    }
                }
            )
            .addDisposableTo(disposeBag)
    }

    private func setupEventBindings() {
        rx.viewWillAppear
            .flatMap {
                Observable<Int>.timer(Constants.duration, scheduler: MainScheduler.instance)
            }
            .map { _ -> Event in
                .prepare
            }
            .bind(to: presenter.eventReceiver)
            .addDisposableTo(disposeBag)
    }
}
