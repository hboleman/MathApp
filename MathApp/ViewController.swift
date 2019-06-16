//
//  ViewController.swift
//  MathApp
//
//  Created by Hunter Boleman on 1/24/19.
//  Copyright © 2019 Hunter Boleman. All rights reserved.
//

import UIKit

/* CODE REFRENCES
 Color Refrence
 myRed = UIColor(red:0.89, green:0.44, blue:0.31, alpha:1.0);
 myBlue = UIColor(red:0.19, green:0.62, blue:0.79, alpha:1.0);
 myGreen = UIColor(red:0.56, green:0.81, blue:0.48, alpha:1.0);
 
 Variable Charts
 mode_symbol         1=+ 2=- 3=* 4=%
 mode_difficulty     1=easy 2=medium 3=hard
 END CODE REFRENCES*/

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Allow for code to run going into or out of background foreground
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil);
        notificationCenter.addObserver(self, selector: #selector(appCameToForeground), name: UIApplication.willEnterForegroundNotification, object: nil);
    }
    
    @objc func appMovedToBackground() {
        print("ENT_BKRND")
    }
    
    @objc func appCameToForeground() {
        print("ENT_FORRND")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("VC:ViewWillApp");
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("VC:ViewDidApp");
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("VC:ViewWillDis");
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("VC:ViewDidDis");
    }
    
    //-------------------- CLASS SETUP END --------------------//
}
