//
//  UbernetApp.swift
//  Ubernet
//
//  Created by Fabio Fiorita on 24/05/22.
//

import SwiftUI
import Firebase

@main
struct UbernetApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            let fbAuth = FirebaseManager()
            OnboardingView()
                .environmentObject(fbAuth)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}
