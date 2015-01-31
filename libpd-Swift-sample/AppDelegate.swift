//
//  AppDelegate.swift
//  libpd-Swift-sample
//
//  Created by Hidehisa YOKOYAMA on 2015/01/31.
//  Copyright (c) 2015年 Hidehisa YOKOYAMA. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var audioController: PdAudioController?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //libpd
        audioController = PdAudioController()
        if let c = audioController {
            //let s = PdAudioController_Bridging().configurePlaybackWithSampleRate(44100, numberChannels: 2, inputEnabled: true, mixingEnabled: true, audioController: c)
            let s = PdAudioController_Bridging().configureAmbientWithSampleRate(44100, numberChannels: 2, mixingEnabled: true, audioController: c)
            switch s {
            case .OK:
                break //success
            case .Error:
                println("unrecoverable error: failed to initialize audio components")
            case .PropertyChanged:
                println("some properties have changed to run correctly (not fatal)")
            default:
                break //do nothing, make compiler happy ;)
            }
        } else {
            println("could not get PdAudioController")
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        audioController?.active = false
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        audioController?.active = true
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

