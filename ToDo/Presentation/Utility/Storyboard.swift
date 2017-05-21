//
//  Storyboard.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/28/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import Foundation

enum Storyboard: String {
    case splash = "Splash"
    case home   = "Home"

    var segueIdentifier: String {
        return self.rawValue
    }
}
