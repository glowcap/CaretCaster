//
//  AppDelegate.swift
//  CaretCaster
//
//  Created by Daymein Gregorio on 2019/04/02.
//  Copyright © 2019 Daymein Gregorio. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    self.window = UIWindow(frame: UIScreen.main.bounds)
    
    UINavigationBar.appearance().barTintColor = ThemeColors.caret
    
    let first = HomeViewController()
    let nav1 = UINavigationController(rootViewController: first)
    nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named:"IconNav1"), tag: 1)
    nav1.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
    nav1.title = "Home"
    
    let second = UIViewController()
    let nav2 = UINavigationController(rootViewController: second)
    second.view.backgroundColor = .white
    nav2.viewControllers = [second]
    nav2.tabBarItem = UITabBarItem(title: "Casts", image: UIImage(named:"castsTabIcon"), tag: 2)
    nav2.tabBarItem.largeContentSizeImage = UIImage(named:"castsTabIconADA")
    
    let third = UIViewController()
    third.view.backgroundColor = .white
    third.tabBarItem = UITabBarItem(title: "", image: UIImage(), tag: 3)
    third.tabBarItem.isEnabled = false
    
    let fourth = UIViewController()
    let nav4 = UINavigationController(rootViewController: fourth)
    fourth.view.backgroundColor = .white
    nav4.viewControllers = [fourth]
    nav4.tabBarItem = UITabBarItem(title: "Browse", image: UIImage(named:"IconNav4"), tag: 4)
    
    let fifth = UIViewController()
    let nav5 = UINavigationController(rootViewController: fifth)
    fifth.view.backgroundColor = .white
    nav5.viewControllers = [fifth]
    nav5.tabBarItem = UITabBarItem(title: "TBA", image: UIImage(named:"IconNav5"), tag: 5)
    
    let tabBarVC = CCTabBarController()
    tabBarVC.viewControllers = [nav1, nav2, third, nav4, nav5]
    
    self.window?.rootViewController = tabBarVC
    self.window?.makeKeyAndVisible()
    
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    self.saveContext()
  }

  // MARK: - Core Data stack

  lazy var persistentContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "CaretCaster")
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
          if let error = error as NSError? {
              fatalError("Unresolved error \(error), \(error.userInfo)")
          }
      })
      return container
  }()

  // MARK: - Core Data Saving support

  func saveContext () {
      let context = persistentContainer.viewContext
      if context.hasChanges {
          do {
              try context.save()
          } catch {
              let nserror = error as NSError
              fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
          }
      }
  }

}

