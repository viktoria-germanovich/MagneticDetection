//
//  AppDelegate.swift
//  MagneticDetection
//
//  Created by Viktoryia Hermanovich on 05/04/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var router: AppRouter?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let viewModel =  HomeViewModelImpl()
        let rootVC = HomeViewController(viewModel: viewModel)
        
        let navVC = UINavigationController(rootViewController: rootVC)
        router = AppRouter(navigationController: navVC)
        viewModel.router = router
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        
        UINavigationBar.appearance().tintColor = .appPrimary
        return true
    }
}

