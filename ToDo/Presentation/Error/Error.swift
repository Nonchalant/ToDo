//
//  Error.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/27/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import Foundation

enum Error: Swift.Error {
    case response(message: String)
    case connection
    case cancelled
    case unknown

    var message: String {
        switch self {
        case .response(let message):
            return message
        case .connection:
            return "サーバーとの通信に失敗しました。通信環境をご確認の上、もう一度お試しください。"
        case .cancelled:
            return "通信をキャンセルしました。"
        case .unknown:
            return "原因不明なエラーが発生しました。"
        }
    }
}

extension Error: Equatable {
    public static func == (lhs: Error, rhs: Error) -> Bool {
        switch (lhs, rhs) {
        case let (.response(l0), .response(r0)):
            return l0 == r0
        case (.connection, .connection),
             (.cancelled, .cancelled),
             (.unknown, .unknown):
            return true
        default:
            return false
        }
    }
}
