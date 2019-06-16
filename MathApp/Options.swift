//
//  Options.swift
//  MathApp
//
//  Created by Hunter Boleman on 2/20/19.
//  Copyright © 2019 Hunter Boleman. All rights reserved.
//

import UIKit

// This class controls the options view controler
class Options: UIViewController {
    
    //-------------------- CLASS SETUP END --------------------//
    
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
    var mode_difficulty: Int = 0;
    
    var modesActive: [Bool] = Array(repeating: false, count: 4)
    var questionCount: Int = 10;
    
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
            defaults.set(1, forKey: "mode_difficulty");
            defaults.set("TEST", forKey: "nil_test");
            
            modesActive[0] = true
            defaults.set(modesActive, forKey: "modesActive")
            defaults.set(10, forKey: "questionCount")
            
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
        mode_difficulty = defaults.integer(forKey: "mode_difficulty");
        
        modesActive = defaults.array(forKey: "modesActive") as! [Bool]
        questionCount = defaults.integer(forKey: "questionCount")
        
        // Makes the options reflect the current set value
        color_plus()
        color_minus()
        color_multiply()
        color_divide()
        if (mode_difficulty == 1){color_easy()}
        else if (mode_difficulty == 2){color_medium()}
        else if (mode_difficulty == 3){color_hard()}
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
        defaults.set(mode_difficulty, forKey: "mode_difficulty");
        
        defaults.set(modesActive, forKey: "modesActive")
        defaults.set(10, forKey: "questionCount")
        
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
    
    //-------------------- CLASS SETUP END --------------------//
    
    // Outlets
    @IBOutlet weak var out_plus: UIButton!
    @IBOutlet weak var out_minus: UIButton!
    @IBOutlet weak var out_multiply: UIButton!
    @IBOutlet weak var out_divide: UIButton!
    @IBOutlet weak var out_easy: UIButton!
    @IBOutlet weak var out_medium: UIButton!
    @IBOutlet weak var out_hard: UIButton!
    
    
    
    // OPTIONS PLUS
    @IBAction func btn_mode_plus(_ sender: Any) {
        if (notLast(index: 0)) {
        if (modesActive[0] == true) {modesActive[0] = false}
        else {modesActive[0] = true}
        color_plus();
        }
    }
    // Function used to color plus
    func color_plus(){
        if (modesActive[0] == true){ out_plus.setTitleColor(UIColor(red:0.89, green:0.44, blue:0.31, alpha:1.0), for: .normal)}
        else {out_plus.setTitleColor(UIColor(red:0.19, green:0.62, blue:0.79, alpha:1.0), for: .normal)}
    }
    
    // OPTIONS MINUS
    @IBAction func btn_mode_minus(_ sender: Any) {
        if (notLast(index: 1)) {
        if (modesActive[1] == true) {modesActive[1] = false}
        else {modesActive[1] = true}
        color_minus();
        }
    }
    // Function used to color minus
    func color_minus(){
        if (modesActive[1] == true){ out_minus.setTitleColor(UIColor(red:0.89, green:0.44, blue:0.31, alpha:1.0), for: .normal)}
        else {out_minus.setTitleColor(UIColor(red:0.19, green:0.62, blue:0.79, alpha:1.0), for: .normal)}
    }
    
    // OPTIONS MULTIPLY
    @IBAction func btn_mode_multiply(_ sender: Any) {
        if (notLast(index: 2)) {
        if (modesActive[2] == true) {modesActive[2] = false}
        else {modesActive[2] = true}
        color_multiply();
        }
    }
    // Function used to color multiply
    func color_multiply(){
        if (modesActive[2] == true){ out_multiply.setTitleColor(UIColor(red:0.89, green:0.44, blue:0.31, alpha:1.0), for: .normal)}
        else {out_multiply.setTitleColor(UIColor(red:0.19, green:0.62, blue:0.79, alpha:1.0), for: .normal)}
    }
    
    // OPTIONS DIVIDE
    @IBAction func btn_mode_divide(_ sender: Any) {
        if (notLast(index: 3)) {
        if (modesActive[3] == true) {modesActive[3] = false}
        else {modesActive[3] = true}
        color_divide();
        }
    }
    // Function used to color divide
    func color_divide(){
        if (modesActive[3] == true){ out_divide.setTitleColor(UIColor(red:0.89, green:0.44, blue:0.31, alpha:1.0), for: .normal)}
        else {out_divide.setTitleColor(UIColor(red:0.19, green:0.62, blue:0.79, alpha:1.0), for: .normal)}
    }
    
    @IBAction func btn_easy(_ sender: Any) {
        mode_difficulty = 1;
        color_easy();
    }
    func color_easy(){
        out_easy.setTitleColor(UIColor(red:0.89, green:0.44, blue:0.31, alpha:1.0), for: .normal)
        out_medium.setTitleColor(UIColor(red:0.19, green:0.62, blue:0.79, alpha:1.0), for: .normal)
        out_hard.setTitleColor(UIColor(red:0.19, green:0.62, blue:0.79, alpha:1.0), for: .normal)
    }
    
    @IBAction func btn_medium(_ sender: Any) {
        mode_difficulty = 2;
        color_medium();
    }
    func color_medium(){
        out_easy.setTitleColor(UIColor(red:0.19, green:0.62, blue:0.79, alpha:1.0), for: .normal)
        out_medium.setTitleColor(UIColor(red:0.89, green:0.44, blue:0.31, alpha:1.0), for: .normal)
        out_hard.setTitleColor(UIColor(red:0.19, green:0.62, blue:0.79, alpha:1.0), for: .normal)
    }
    
    @IBAction func btn_hard(_ sender: Any) {
        mode_difficulty = 3;
        color_hard();
    }
    func color_hard(){
        out_easy.setTitleColor(UIColor(red:0.19, green:0.62, blue:0.79, alpha:1.0), for: .normal)
        out_medium.setTitleColor(UIColor(red:0.19, green:0.62, blue:0.79, alpha:1.0), for: .normal)
        out_hard.setTitleColor(UIColor(red:0.89, green:0.44, blue:0.31, alpha:1.0), for: .normal)
    }
    
    func notLast(index: Int) -> Bool {
        // For enabling
        if (modesActive[index] == false){return true}
        // For disabling
        var count = 0
        for index in 0..<modesActive.count{if (modesActive[index] == true){count = count + 1}}
        if (count > 1 && modesActive[index] == true){return true}
        else {return false}
    }
    
}
