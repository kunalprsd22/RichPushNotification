//
//  AppDelegate.swift
//  PushNotification
//
//  Created by Admin on 16/03/22.
//

import UIKit
import Firebase
import UserNotifications
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        registerForPushNotification()
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate, MessagingDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        NSLog("User Info didReceive = ",response.notification.request.content.userInfo)
        let actionIdentifier = response.actionIdentifier
        if actionIdentifier == "like" {
            print("calling like")
        }
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        NSLog("User Info didReceive = ",userInfo)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print(token)
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("fcmToken", fcmToken)
    }
    
    func registerForPushNotification() {
        setNotificationCategory()
        let center  = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
            guard error == nil else {
                return
            }
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                    //                    NotificationCenter.default.post(name: .notficationIdentifier, object: [true])
                }
            } else {
                //                NotificationCenter.default.post(name: .notficationIdentifier, object: [false])
            }
        }
    }
    
    func setNotificationCategory() {
        
        //creating actions
        let likeAction = UNNotificationAction(identifier: "like", title:"Like", options: .foreground)
        let snoozeAction = UNNotificationAction(identifier: "snooze", title: "Snooze", options: .destructive)
    
        let customViewCategory1 = UNNotificationCategory(identifier: "myNotificationCategory", actions: [likeAction,snoozeAction], intentIdentifiers: [], options: [])

        UNUserNotificationCenter.current().setNotificationCategories([customViewCategory1])
    }
    
}

