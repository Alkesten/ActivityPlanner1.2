//
//  InterfaceController.swift
//  WatchApp Extension
//
//  Created by Alkesten on 2016-05-13.
//  Copyright © 2016 Alkesten. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate {

    @IBOutlet var activityLabel: WKInterfaceLabel!
    var session: WCSession!
    var activities = [String]()
    var counter: Int = 0
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if(WCSession.isSupported()){
            self.session = WCSession.defaultSession()
            session.self.delegate = self
            self.session.activateSession()
        } else {
            print("WatchConnectivity is not supported on this device")
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    //Send message to from watch to phone
    @IBAction func SendMessageToPhone() {
        if(WCSession.isSupported()){
            session.sendMessage(["b": "hello"], replyHandler: nil, errorHandler: { error in
                print("error: \(error)")
            })
        }
    }
    
    @IBAction func ShowNextActivity() {
        if(activities.count > counter){
            activityLabel.setText(activities[counter])
            counter++
        } else if(activities.count == counter){
            counter = 0
            activityLabel.setText("End of the day")
        }
        
    }
    
    //Watch listens for message from phone
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
       let textToAdd = (message["a"]! as? String)
        activities.append(textToAdd!)
    }

}
