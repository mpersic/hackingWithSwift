//
//  InterfaceController.swift
//  Project37 WatchKit Extension
//
//  Created by COBE on 29/06/2021.
//

import WatchConnectivity
import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var welcomeLabel: WKInterfaceLabel!
    @IBOutlet var hideButton: WKInterfaceButton!
    
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }

    @IBAction func hideWelcomeText() {
        welcomeLabel.setHidden(true)
        hideButton.setHidden(true)
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        WKInterfaceDevice().play(.click)
    }
}
