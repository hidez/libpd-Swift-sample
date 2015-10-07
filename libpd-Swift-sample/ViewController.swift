//
//  ViewController.swift
//  libpd-Swift-sample
//
//  Created by Hidehisa YOKOYAMA on 2015/01/31.
//  Copyright (c) 2015年 Hidehisa YOKOYAMA. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PdListener {
    var dispatcher: PdDispatcher?

    @IBOutlet weak var labelCounter: UILabel!
    
//MARK: - LIFE CYCLE OF VIEW CONTROLLER METHOD

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let v = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String //バージョン番号
        let b = NSBundle.mainBundle().infoDictionary?["CFBundleVersion"] as? String //ビルド番号
        let d = NSUserDefaults.standardUserDefaults()
        d.setObject(v, forKey: ConstantValues.kUserDefaultSettingsBundleVersion) //バージョン番号
        d.setObject(b, forKey: ConstantValues.kUserDefaultSettingsBundleBuild) //ビルド番号
        d.synchronize()
        
        //libpd
        dispatcher = PdDispatcher()
        dispatcher?.addListener(self, forSource: "bang_bang")
        dispatcher?.addListener(self, forSource: "counter")
        PdBase.setDelegate(dispatcher)
        MyCounter_setup() //external
        let patch: UnsafeMutablePointer = PdBase.openFile("sample.pd", path: NSBundle.mainBundle().resourcePath)
        if patch == nil {
            print("Failed to open patch!")
            // Gracefully handle failure...
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        self.labelCounter.text = "0"
        PdBase.sendBangToReceiver("tuning_fork_off") //libpd
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//MARK: - ACTION EVENT METHOD
    
    @IBAction func buttonOnPressed(sender: AnyObject) {
        PdBase.sendBangToReceiver("tuning_fork_on") //libpd
    }

    @IBAction func buttonOffPressed(sender: AnyObject) {
        PdBase.sendBangToReceiver("tuning_fork_off") //libpd
    }
    
//MARK: - PdListener CALLBACK

    func receiveBangFromSource(source: String!) {
        if source == "bang_bang" {
            print("receive bang!")
        }
    }

    func receiveFloat(received: Float, fromSource source: String!) {
        if source == "counter" {
            self.labelCounter.text = "\(Int(received))"
        }
    }
}

