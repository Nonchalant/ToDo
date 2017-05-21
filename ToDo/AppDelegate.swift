//
//  AppDelegate.swift
//  ToDo
//
//  Created by Takeshi Ihara on 5/21/17.
//  Copyright © 2017 Takeshi Ihara. All rights reserved.
//

import UIKit
import Presentation
import Utility

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setup()

        return true
    }

    // MARK: - Private

    private func setup() {
        Log.setup()
    }
}
