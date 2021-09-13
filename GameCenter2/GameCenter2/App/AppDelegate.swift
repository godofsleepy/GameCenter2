//
//  AppDelegate.swift
//  GameCenter2
//
//  Created by Rumah Coding on 13/09/21.
//

import UIKit
import RealmSwift

class AppDelegate: UIResponder, UIApplicationDelegate {
    var realm: Realm!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        realm = try! Realm()
        return true
    }
}
