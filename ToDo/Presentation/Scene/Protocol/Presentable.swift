//
//  Presentable.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/27/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import Foundation
import RxSwift

protocol Presentable {
    associatedtype State
    associatedtype Event

    var viewReflecter: BehaviorSubject<State> { get }
    var eventReceiver: PublishSubject<Event> { get }
    func send(with event: Event)
}
