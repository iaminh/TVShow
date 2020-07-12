//
//  AppDelegate.swift
//  TVShow
//
//  Created by Chu Anh Minh on 5/27/19.
//  Copyright © 2019 MinhChu. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    private lazy var appNavigationController = UINavigationController()
    private lazy var appRouter = Router(navigationController: self.appNavigationController)
    private lazy var homeModule = HomeModule(router: appRouter, dataProvider: DataProvider())
    lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        let parseConfig = ParseClientConfiguration {
            $0.applicationId = "UvBvjdPeATFfYW9PeMjuoyX0ZGkD9XVY6NJAwshV"
            $0.clientKey = "rxbpcYTOYya1NXcMbyaXNdLOCNs2VwY86OZ6w9ZE"
            $0.server = "https://parseapi.back4app.com/"
        }
        
        Parse.initialize(with: parseConfig)
        
        window?.rootViewController = homeModule.toPresentable()
        window?.makeKeyAndVisible()
        
        return true
    }
    
}

