//
//  ViewController.swift
//  FlyBeacon
//
//  Created by Dav on 11/23/14.
//  Copyright (c) 2014 Sekai No. All rights reserved.
//

import UIKit

class ViewController: UIViewController, JMFSKModemDelegate {
    var fskConfig : JMFSKModemConfiguration?
    var fskModem : JMFSKModem?

    @IBOutlet weak var sendBUtton: UIButton!
    @IBAction func sendButtonTapped(sender: AnyObject) {
        let string : String! = "Hello."
        fskModem?.sendData(string!.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: false))
        println("Sent data: \(string)")
    }
    @IBOutlet weak var heardLabel: UILabel!
    @IBOutlet weak var listenSwitch: UISwitch!
    @IBAction func listenSwitchChanged(sender: AnyObject) {
        if (listenSwitch.on) {
            fskModem?.delegate = self
            println("Listening ON")
        } else {
            fskModem?.delegate = nil
            println("Listening OFF")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fskConfig = JMFSKModemConfiguration.highSpeedConfiguration()
        fskModem = JMFSKModem(configuration: fskConfig)
        
        println("Initialized modem: \(fskModem)")
        fskModem?.connect()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK : JMFSKModemDelegate
    
    func modem(modem: JMFSKModem!, didReceiveData data: NSData!) {
        let message : NSString! = NSString(data: data, encoding: NSASCIIStringEncoding)
        println("Heard: \(message)")
        heardLabel.text = message
    }
    
    func modemDidConnect(modem: JMFSKModem!) {
        println("Modem connected.")
    }
    
    func modemDidDisconnect(modem: JMFSKModem!) {
        println("Modem disconnected.")
    }

}

