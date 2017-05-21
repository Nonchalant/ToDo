//
//  ToDoListViewController.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/27/17.
//  Copyright (c) 2017 Takeshi Ihara. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Domain
import Utility

class ToDoListViewController: UIViewController, ErrorAlertShowable {

    // MARK: - TypeAlias

    typealias Event = ToDoListPresenter.Event

    // MARK: - IBOutlet

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.todo.register(ToDoListCell.self)
        }
    }

    // MARK: - Property

    var presenter: ToDoListPresenter!
    private let dataSource = ToDoListDataSource()
    private let disposeBag = DisposeBag()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUIBindings()
        setupEventBindings()
        setupTableViewBindings()
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
                    case .initial, .added, .deleted:
                        break
                    case .prepared(let viewModel):
                        weakSelf.dataSource.load(viewModel.items)
                    case .tapedAdd:
                        let alert = UIAlertBuilder.add(okAction: { title in
                            weakSelf.presenter.send(with: .add(title: title))
                        })
                        weakSelf.present(alert, animated: true)
                    case .failed(let error):
                        weakSelf.showErrorAlert(error)
                    }
                }
            )
            .addDisposableTo(disposeBag)
    }

    private func setupEventBindings() {
        rx.viewWillAppear
            .map {
                Event.prepare
            }
            .bind(to: presenter.eventReceiver)
            .addDisposableTo(disposeBag)

        navigationItem.rightBarButtonItem?.rx.tap
            .map {
                Event.tapAdd
            }
            .bind(to: presenter.eventReceiver)
            .addDisposableTo(disposeBag)
    }

    private func setupTableViewBindings() {
        tableView.rx.setDelegate(dataSource).addDisposableTo(disposeBag)

        dataSource.element
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(disposeBag)

        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(ToDoItem.self)) { return $0 }
            .do(onNext: { [weak self] (indexPath, _) in
                self?.tableView.deselectRow(at: indexPath, animated: true)
            })
            .subscribe(onNext: { [weak self] (indexPath, item) in
                guard let weakSelf = self else {
                    return
                }

                let alert = UIAlertBuilder.confirm(title: "Delete", message: item.title, okAction: {
                    weakSelf.presenter.send(with: .delete(index: indexPath.row))
                })
                weakSelf.present(alert, animated: true)
            })
            .addDisposableTo(disposeBag)
    }
}
