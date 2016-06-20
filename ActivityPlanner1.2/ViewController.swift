//
//  ViewController.swift
//  ActivityPlanner1.2
//
//  Created by Alkesten on 2016-05-13.
//  Copyright © 2016 Alkesten. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var activityText: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var activityTable: UITableView!
    var session: WCSession!
    var activities = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if(WCSession.isSupported()){
            self.session = WCSession.defaultSession()
            self.session.delegate = self
            self.session.activateSession()
        } else {
            print("WatchConnectivity is not supported on this device")
        }
        
        self.activityTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.activityTable.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Send message from phone to watch
    @IBAction func AddActivityToWatch(sender: AnyObject) {
        let textToAdd = activityText.text!
        //session.sendMessage(["a" : activities], replyHandler: nil, errorHandler: nil
        if(WCSession.isSupported() && textToAdd != ""){
            session.sendMessage(["a" : textToAdd], replyHandler: nil, errorHandler: { error in
                print("error: \(error)")
            self.activities.append(textToAdd)
            })
        }
    }
    @IBAction func sendActivity(sender: AnyObject) {
        let textToAdd = activityText.text!
        if(WCSession.isSupported() && textToAdd != ""){
            session.sendMessage(["a" : textToAdd], replyHandler: nil, errorHandler: { error in print ("error: \(error)")
            })
        }
    }
    
    //Phone listens to message from watch
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
        self.messageLabel.text = message["b"]! as? String
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = self.activityTable.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        cell.textLabel!.text = self.activities[indexPath.row]
        
        return cell
    }

}



