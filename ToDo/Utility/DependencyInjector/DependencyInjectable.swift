//
//  DependencyInjector.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/21/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import Foundation
import Swinject

public protocol DependencyInjectable {
    func inject(container: Container)
}
