//
//  AppDelegate.swift
//  Contacts
//
//  Created by Georgiy Farafonov on 07.09.2020.
//  Copyright © 2020 Georgiy Farafonov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private var coordinator: ContactsCoordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        DatabaseClient.shared.initializeStorage(SQLStorage(path: Configurator.pathToDatabase))
        startSplashFlow()
        return true
    }
    
    private func startSplashFlow() {
        let splashVC = SplashController.instantiateFromStoryboardNamed("Splash", storyboardID: "SplashController")
        let viewModel = SplashViewModelClient(api: ContactsApiClient(client: APIClient.shared),
                                              database: DatabaseClient.shared)
        viewModel.onFinishDisplaying = { [unowned self] in
            self.startMainFlow()
        }
        splashVC.viewModel = viewModel
        window?.rootViewController = splashVC
        window?.makeKeyAndVisible()
    }
    
    private func startMainFlow() {
        let navigationVC = UINavigationController()
        window?.rootViewController = navigationVC
        coordinator = ContactsCoordinator(navigationController: navigationVC)
        coordinator.startFlow(with: ContactsListController.instantiateFromStoryboardNamed("Contacts",
                                                                                          storyboardID: "ContactsListController"))
    }

}

