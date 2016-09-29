//
//  ViewController.swift
//  libpd-Swift-sample
//
//  Created by Hidehisa YOKOYAMA on 2015/01/31.
//  Copyright (c) 2015 Hidehisa YOKOYAMA. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PdListener {
    var dispatcher: PdDispatcher?

    @IBOutlet weak var labelCounter: UILabel!
    
//MARK: - LIFE CYCLE OF VIEW CONTROLLER METHOD

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let v = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String //バージョン番号
        let b = Bundle.main.infoDictionary?["CFBundleVersion"] as? String //ビルド番号
        let d = UserDefaults.standard
        d.set(v, forKey: ConstantValues.kUserDefaultSettingsBundleVersion) //バージョン番号
        d.set(b, forKey: ConstantValues.kUserDefaultSettingsBundleBuild) //ビルド番号
        d.synchronize()
        
        //libpd
        dispatcher = PdDispatcher()
        dispatcher?.add(self, forSource: "bang_bang")
        dispatcher?.add(self, forSource: "counter")
        PdBase.setDelegate(dispatcher)
        MyCounter_setup() //external
        
        if PdBase.openFile("sample.pd", path: Bundle.main.resourcePath) == nil {
            print("Failed to open patch!")
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.labelCounter.text = "0"
        PdBase.sendBang(toReceiver: "tuning_fork_off") //libpd
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//MARK: - ACTION EVENT METHOD
    
    @IBAction func buttonOnPressed(_ sender: AnyObject) {
        PdBase.sendBang(toReceiver: "tuning_fork_on") //libpd
    }

    @IBAction func buttonOffPressed(_ sender: AnyObject) {
        PdBase.sendBang(toReceiver: "tuning_fork_off") //libpd
    }
    
//MARK: - PdListener CALLBACK

    func receiveBang(fromSource source: String!) {
        if source == "bang_bang" {
            print("receive bang!")
        }
    }
    
    func receive(_ received: Float, fromSource source: String!) {
        if source == "counter" {
            self.labelCounter.text = "\(Int(received))"
        }
    }
}

