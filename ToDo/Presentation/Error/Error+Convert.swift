//
//  Error+Convert.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/27/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import Foundation
import Domain

extension Error {
    static func create(with error: Swift.Error) -> Error {
        switch error {
        case let domainError as Domain.Error:
            return create(error: domainError)
        default:
            return .unknown
        }
    }

    private static func create(error: Domain.Error) -> Error {
        switch error {
        case .connection:
            return .connection
        case .translation:
            return .unknown
        case .notFound:
            return .response(message: "リソースが見つかりませんでした")
        default:
            return .unknown
        }
    }
}
