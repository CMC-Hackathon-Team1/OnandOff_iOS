//
//  AppDelegate.swift
//  OnandOff
//
//  Created by SangWoo's MacBook on 2022/12/31.
//

import UIKit
import KakaoSDKCommon
import AuthenticationServices
import GoogleSignIn
import UserNotifications
import Firebase


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        KakaoSDK.initSDK(appKey: "ae1a0ec9bf2a22467f3c77957ae9fffb")
        
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if error != nil || user == nil {
                // Show the app's signed-out state.
            } else {
                // Show the app's signed-in state.
            }
        }
        
        self.registerForPushNotifications()
        
        FirebaseApp.configure()
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self

        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        var handled: Bool
        handled = GIDSignIn.sharedInstance.handle(url)
        if handled {
            return true
        }
        
        return false
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    //MARK: - RemotePushNotification
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
                print("Permission granted: \(granted)")
                self.getNotificationSettings()
            }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("디바이스 토큰 정상 발급 완료")
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register(deviceToken): \(error)")
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    // 포그라운드에서 받았을 때
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let content = notification.request.content
        print("title: \(content.title)")
        print("body: \(content.body)")
        completionHandler([.badge , .banner, .sound])
    }
    // 백그라운드에서 받았을 때
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let content = response.notification.request.content
        print("title: \(content.title)")
        print("body: \(content.body)")
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        // FCM 토큰 발급!
        guard let fcmToken else { return }
        print("fcmToken 정상 발급 : \(fcmToken)")
        UserDefaults.standard.set(fcmToken, forKey: "fcmToken")
    }
}
