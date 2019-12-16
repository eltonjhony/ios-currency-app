//
//  AppDelegate.swift
//  eur-currency-app
//
//  Created by Elton Jhony Romao de Oliveira on 12/12/19.
//  Copyright © 2019 EurCurrencyApp. All rights reserved.
//

import UIKit
import Swinject
import eur_currency_networking

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let navController = UINavigationController()

        let appContainer = AppContainer()
        appContainer.setupDependencies()
        AppCoordinator(container: appContainer.container, presenter: navController).start()

        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
        return true
    }
    
}

