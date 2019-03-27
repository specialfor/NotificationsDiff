//
//  ViewController.swift
//  NotificationsDiff
//
//  Created by Volodymyr Hryhoriev on 3/27/19.
//  Copyright © 2019 Volodymyr Hryhoriev. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        testIOS10Notifications()
    }
    
    private func testIOS10Notifications() {
        let center = UNUserNotificationCenter.current()
        
        center.delegate = self
        
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (isGranted, error) in
            print("Is granted? \(isGranted)")
        }
        
        let action = UNNotificationAction(identifier: "action1", title: "Kek", options: [])
        
        let category = UNNotificationCategory(identifier: "cheburek", actions: [action], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "", options: .customDismissAction)
        center.setNotificationCategories([category])
        
        let content = UNMutableNotificationContent()
        content.title = "iOS 10"
        content.subtitle = "Cheburek"
        content.body = "Body"
        content.categoryIdentifier = "cheburek"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request) { (error) in
            print("Error \(error)")
        }
    }
    
    private func testIOS9Notifications() {
        let category = UIMutableUserNotificationCategory()
        category.identifier = "cheburek"
        
        let action1 = UIMutableUserNotificationAction()
        action1.identifier = "action1"
        action1.title = "action1"
        
        let action2 = UIMutableUserNotificationAction()
        action2.identifier = "action2"
        action2.title = "action2"
        
        category.setActions([action1, action2], for: .default)
        category.setActions([action1], for: .minimal)
        
        let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: [category])
        UIApplication.shared.registerUserNotificationSettings(settings)
        
        let loc = UILocalNotification()
        loc.alertBody = "Body"
        loc.alertTitle = "iOS 9"
        loc.category = "cheburek"
        loc.fireDate = Date(timeIntervalSince1970: (Date().timeIntervalSince1970 + 3.0))
//        loc.repeatInterval = .minute
        UIApplication.shared.scheduleLocalNotification(loc)
        
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (timer) in
            UIApplication.shared.cancelLocalNotification(loc)
        })
    }
    
    
    // MARK: - UNUserNotificationCenterDelegate

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Receive \(response.actionIdentifier)")
        completionHandler()
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        print("Open settings")
    }
}

