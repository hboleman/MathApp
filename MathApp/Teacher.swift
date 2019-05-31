//
//  Teaching.swift
//  MathApp
//
//  Created by Hunter Boleman on 2/20/19.
//  Copyright © 2019 Hunter Boleman. All rights reserved.
//

import UIKit

// This class controls the Teaching View Controler
class Teacher: UIViewController {
    //************************************************************************
    //**************************CLASS_SETUP_START*****************************
    //************************************************************************
    
    // Make UserDefautls Accessable
    let defaults = UserDefaults.standard
    
    // Populate local variables with UserData information
    var num1: Int = 0;
    var num2: Int = 0;
    var numAns: Int = 0;
    var temp1: Int = 0;
    var temp2: Int = 0;
    var place: Int = 0;
    var user_num: Int = 0;
    var score_right: Int = 0;
    var score_wrong: Int = 0;
    var score_Qcurrent: Int = 0;
    var score_Qmax: Int = 0;
    var canTouch: Bool = true;
    var mode_symbol: Int = 0;
    var mode_difficulty: Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Allow for code to run going into or out of background foreground
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil);
        notificationCenter.addObserver(self, selector: #selector(appCameToForeground), name: UIApplication.willEnterForegroundNotification, object: nil);
        
        // If defaults have not been setup, set them up
        if (defaults.string(forKey: "nil_test") == nil){
            defaults.set(0, forKey: "num1");
            defaults.set(0, forKey: "num2");
            defaults.set(0, forKey: "numAns");
            defaults.set(0, forKey: "temp1");
            defaults.set(0, forKey: "temp2");
            defaults.set(1, forKey: "place");
            defaults.set(0, forKey: "user_num");
            defaults.set(0, forKey: "score_right");
            defaults.set(0, forKey: "score_wrong");
            defaults.set(0, forKey: "score_Qcurrent");
            defaults.set(0, forKey: "score_Qmax");
            defaults.set(true, forKey: "canTouch");
            defaults.set(1, forKey: "mode_symbol");
            defaults.set(1, forKey: "mode_difficulty");
            defaults.set("TEST", forKey: "nil_test");
            defaults.synchronize();
        }
        // Populate local variables with UserData information
        num1 = defaults.integer(forKey: "num1");
        num2 = defaults.integer(forKey: "num2");
        numAns = defaults.integer(forKey: "numAns");
        temp1 = defaults.integer(forKey: "temp1");
        temp2 = defaults.integer(forKey: "temp2");
        place = defaults.integer(forKey: "place");
        user_num = defaults.integer(forKey: "user_num");
        score_right = defaults.integer(forKey: "score_right");
        score_wrong = defaults.integer(forKey: "score_wrong");
        score_Qcurrent = defaults.integer(forKey: "score_Qcurrent");
        score_Qmax = defaults.integer(forKey: "score_Qmax");
        canTouch = defaults.bool(forKey: "canTouch");
        mode_symbol = defaults.integer(forKey: "mode_symbol");
        mode_difficulty = defaults.integer(forKey: "mode_difficulty");
    }
    
    func save_defaults(){
        defaults.set(num1, forKey: "num1");
        defaults.set(num2, forKey: "num2");
        defaults.set(numAns, forKey: "numAns");
        defaults.set(temp1, forKey: "temp1");
        defaults.set(temp2, forKey: "temp2");
        defaults.set(place, forKey: "place");
        defaults.set(user_num, forKey: "user_num");
        defaults.set(score_right, forKey: "score_right");
        defaults.set(score_wrong, forKey: "score_wrong");
        defaults.set(score_Qcurrent, forKey: "score_Qcurrent");
        defaults.set(score_Qmax, forKey: "score_Qmax");
        defaults.set(canTouch, forKey: "canTouch");
        defaults.set(mode_symbol, forKey: "mode_symbol");
        defaults.set(mode_difficulty, forKey: "mode_difficulty");
        defaults.synchronize();
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
        save_defaults();
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("VC:ViewDidDis");
    }
    
    //************************************************************************
    //**************************CLASS_SETUP_COMPLETE**************************
    //************************************************************************
    
    //Variable Charts
    //mode_symbol         1=+ 2=- 3=* 4=%
    //mode_difficulty     1=easy 2=medium 3=hard
    
    // Outlet Test
    @IBOutlet weak var out_test: UILabel!
    
    // Variables for generating code
    var numOfQuestions_add: Int = 1;
    var numOfQuestions_sub: Int = 1;
    var numOfQuestions_mul: Int = 1;
    var numOfQuestions_div: Int = 1;
    
    var difficulty_add: Int = 1;
    var difficulty_sub: Int = 1;
    var difficulty_mul: Int = 1;
    var difficulty_div: Int = 1;
    
    var shuffle: Bool = false;
    
    var dueDate: String = "Y19M03D02H16M10";
    
    var instructorCode: Int = 1234;
    
    // Test Button
    @IBAction func btn_test(_ sender: Any) {
        
        // Binary String Values
        // binSortNum 0000 questions type:11001100 difficulty:110011001 date:Year-to-32:100000 Month:1100 Day-to-31:11111 Hr-to-24:11000 Min-to-60:111100
//loc 0 // 2 = 000
        // 3 = 001
        // 4 = 010
        // 5 = 011
        // 6 = 100
        // 7 = 101
        // 8 = 110
        // 9 = 111
        // a = 000
        // b = 001
        // c = 010
        // d = 011
        // e = 100
        // f = 101
        // g = 110
        // h = 111
        // j = 000
        // k = 001
        // m = 010
        // n = 011
        // p = 100
        // q = 101
        // r = 110
        // s = 111
        // t = 000
        // u = 001
        // v = 010
        // w = 011
        // x = 100
        // y = 101
        // z = 110
        // A = 111
        // B = 000
        // C = 001
        // D = 010
        // E = 011
        // F = 100
        // G = 101
        // H = 110
        // J = 111
        // K = 000
        // M = 001
        // N = 010
        // P = 011
        // Q = 100
        // R = 101
        // S = 110
        // T = 111
        // U = 000
        // V = 001
        // W = 010
        // X = 011
        // Y = 100
        // Z = 101
        // @ = 110
        // & = 111
        // ? = 000
        // ! = 001
        // - = 010
        // # = 011
        // % = 100
        // + = 101
        // < = 110
        // > = 111
        // 64 total characters that are unambigious
    }
    
    

 
}
