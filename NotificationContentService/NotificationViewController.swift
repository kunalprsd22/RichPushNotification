//
//  NotificationViewController.swift
//  NotificationContentService
//
//  Created by Admin on 19/03/22.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    
    @IBOutlet var label: UILabel?
    var counter = 0
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    func didReceive(_ notification: UNNotification) {
        self.label?.text = notification.request.content.body
    }
    
    @objc func timerAction() {
        counter += 1
        label?.text = "\(counter)"+"  sfnaklfnas lkfnaskl \n naslkf na working  "
    }
    
    
    @IBAction func click(_ sender: UIButton) {
        print("calling")
        self.label?.text = "Click work"
        // extensionContext?.performNotificationDefaultAction()
    }
    
}
