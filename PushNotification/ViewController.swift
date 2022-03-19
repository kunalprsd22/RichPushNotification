//
//  ViewController.swift
//  PushNotification
//
//  Created by Admin on 16/03/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    @IBAction func register(_ sender: UIButton) {
        let content = UNMutableNotificationContent()
        content.title = "Local Notifications"
        content.subtitle =  "Good Morning"
        content.body = "While building a healthy lifestyle has been an important habit for me, I just don't have the time or the interest in joining one of those national gym chains.Instead, I have found that one of the best ways to improve and maintain my health is to simply focus on walking first thing in the morning."
        content.categoryIdentifier = "myNotificationCategory"
        
        let url = Bundle.main.url(forResource: "earthgif", withExtension: "gif")
        if let urlgif = url {
        let attachment = try! UNNotificationAttachment(identifier: "gif", url: urlgif, options: [:])
        content.attachments = [attachment]
        }

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: "localNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            print(error?.localizedDescription)
        }
    }
}

extension ViewController {
    
//    payload :
//
//    {
//        "to" : "cCKp60wctEDNvgtU_mjSDV:APA91bHiEfj9ThoTNe7Zhz-RZC0dA6Xt3Xst61lsVKcY8VV-gX8jh-5njtF7UzWDB4G49ESF2Xt6EkZI0_3jXV8qcYwLBL0aHbagvud6NlB1OoZxw-J6ApWuJYoP2cBErpPcuvYeakC3",
//        "content_available" : true,
//        "mutable_content": true,
//        "priority" : "high",
//        "data":
//        {
//            "message": "Offer!",
//            "attachment" : "http://iphoneislam.com/wp-content/uploads/2016/10/Zamen_iOS10_1-590x332.jpg",
//            "media_type":"image",
//            "type": "Category"
//        },
//        "notification":
//        {
//            "body": "Enter your message",
//            "sound": "Sound1.caf",
//           "title":"sfshfuksgfksfgksfgksfs",
//           "click_action": "myNotificationCategory"
//        }
//
//    }
    
}
