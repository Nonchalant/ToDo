//
//  Error+Convert.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/29/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import Foundation
import Domain

extension Error {
    static func create(with error: Swift.Error) -> Domain.Error {
        switch error {
        case let infrastructureError as Error:
            return create(error: infrastructureError)
        default:
            return .unknown
        }
    }

    private static func create(error: Error) -> Domain.Error {
        switch error {
        case .notFound:
            return .notFound
        default:
            return .unknown
        }
    }
}
