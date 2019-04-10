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
    
    let first = HomeViewController()
    let nav1 = UINavigationController(rootViewController: first)
    nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named:"IconNav1"), tag: 1)
    
    let nav2 = UINavigationController()
    let second = UIViewController()
    second.view.backgroundColor = .red
    nav2.viewControllers = [second]
    nav2.tabBarItem = UITabBarItem(title: "Casts", image: UIImage(named:"IconNav2"), tag: 2)
    
    let nav3 = UINavigationController()
    let third = UIViewController()
    third.view.backgroundColor = .blue
    nav3.viewControllers = [third]
    nav3.tabBarItem = UITabBarItem(title: "Browse", image: UIImage(named:"IconNav3"), tag: 3)
    
    let nav4 = UINavigationController()
    let fourth = UIViewController()
    fourth.view.backgroundColor = .yellow
    nav4.viewControllers = [fourth]
    nav4.tabBarItem = UITabBarItem(title: "TBA", image: UIImage(named:"IconNav3"), tag: 4)
    
    let tabs = UITabBarController()
    tabs.viewControllers = [nav1, nav2, nav3, nav4]
    
    self.window?.rootViewController = tabs
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

