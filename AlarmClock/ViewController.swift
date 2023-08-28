//
//  ViewController.swift
//  JetkiteClockTask2
//
//  Created by Kerem Alemdar on 28.08.2023.
//

import UIKit
import UserNotifications
class ViewController: UIViewController {
    
    @IBOutlet weak var timeField: UIDatePicker!
    
    @IBOutlet weak var roundedCornerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        roundedCornerButton.layer.cornerRadius = 15
        roundedCornerButton.layer.masksToBounds = true
    }
    @IBAction func didTapTest() {
        // test notification
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: {success, error in
            if success {
                //schedule test
                self.scheduleTest()
            }
            else if error != nil {
                print("error occured")
            }
        })
        
    }
    
    
    func scheduleTest () {
        let content = UNMutableNotificationContent()
        content.title = "Good Morning"
        content.body = "Wake Up!"
        content.sound = UNNotificationSound(named: UNNotificationSoundName("tone.mp3"))
        let targetDate = Date().addingTimeInterval(10)
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: false)
        
        let request = UNNotificationRequest(identifier: "Some_Long_id", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil{
                print("something went wrong")
            }
        })
    }
    
    @IBAction func setAlarm(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Alert", message: "Alarm has been set", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default){
            (action:UIAlertAction!) in
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
        
        let content = UNMutableNotificationContent()
        content.title = "Good Morning"
        content.body = "Wake Up!"
        content.sound = UNNotificationSound(named: UNNotificationSoundName("tone.mp3"))
        let targetDate = timeField.date
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: targetDate), repeats: false)
            
            let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
                if error != nil {
                    print("Something went wrong")
                }
            })
        }
    }

