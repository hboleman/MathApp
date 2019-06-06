//
//  Quiz.swift
//  MathApp
//
//  Created by Hunter Boleman on 2/20/19.
//  Copyright © 2019 Hunter Boleman. All rights reserved.
//

import UIKit

// This class controls the quiz view controler
class Quiz: UIViewController {
    
    //-------------------- CLASS SETUP START --------------------//
    
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
        start();
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
    
    //-------------------- CLASS SETUP END --------------------//
    
    // LABLES CONNECTIONS
    @IBOutlet weak var lbl_top: UILabel!
    @IBOutlet weak var lbl_bottom: UILabel!
    @IBOutlet weak var lbl_answer: UILabel!
    @IBOutlet weak var lbl_symbol: UILabel!
    @IBOutlet weak var lbl_right: UILabel!
    @IBOutlet weak var lbl_wrong: UILabel!
    @IBOutlet weak var lbl_polarity: UILabel!
    
    // Progress View Connection
    @IBOutlet weak var progviewquiz: UIProgressView!
    
    // OUTLETS
    @IBOutlet weak var out_nextquestion: UIButton!
    
    // ENTER
    @IBAction func btn_enter(_ sender: Any) {
        if (canTouch == true){
            //lbl_polarity.isHidden = false;
            // For negative
            if (lbl_polarity.isHidden == false){
                user_num = user_num * -1;
                if (user_num == numAns){
                    lbl_answer.text = "CORRECT!";
                    canTouch = false;
                    score(right: 1, wrong: 0, question: 1);
                }
                if (user_num != numAns){
                    lbl_answer.text = "WRONG!";
                    canTouch = false;
                    score(right: 0, wrong: 1, question: 1);
                }
            }
                // For non-negative
            else if (lbl_polarity.isHidden == true){
                if (user_num == numAns){
                    lbl_answer.text = "CORRECT!";
                    canTouch = false;
                    score(right: 1, wrong: 0, question: 1);
                }
                if (user_num != numAns){
                    lbl_answer.text = "WRONG!";
                    canTouch = false;
                    score(right: 0, wrong: 1, question: 1);
                }
            }
            lbl_polarity.isHidden = true;
            place = 1;
            user_num = 0;
            out_nextquestion.isHidden = false;
        }
    }
    
    // ZERO
    @IBAction func btn_zero(_ sender: Any) {
        if (canTouch == true){
            user_num = user_num * 10;
            place = place + 1;
            lbl_answer.text = String(user_num);
        }
    }
    
    // ONE
    @IBAction func btn_one(_ sender: Any) {
        if (canTouch == true){
            let ins_num: Int = 1;
            user_num = (user_num * 10) + ins_num;
            place = place + 1;
            lbl_answer.text = String(user_num);
        }
    }
    
    // TWO
    @IBAction func btn_two(_ sender: Any) {
        if (canTouch == true){
            let ins_num: Int = 2;
            user_num = (user_num * 10) + ins_num;
            place = place + 1;
            lbl_answer.text = String(user_num);
        }
    }
    
    // THREE
    @IBAction func btn_three(_ sender: Any) {
        if (canTouch == true){
            let ins_num: Int = 3;
            user_num = (user_num * 10) + ins_num;
            place = place + 1;
            lbl_answer.text = String(user_num);
        }
    }
    
    // FOUR
    @IBAction func btn_four(_ sender: Any) {
        if (canTouch == true){
            let ins_num: Int = 4;
            user_num = (user_num * 10) + ins_num;
            place = place + 1;
            lbl_answer.text = String(user_num);
        }
    }
    
    // FIVE
    @IBAction func btn_five(_ sender: Any) {
        if (canTouch == true){
            let ins_num: Int = 5;
            user_num = (user_num * 10) + ins_num;
            place = place + 1;
            lbl_answer.text = String(user_num);
        }
    }
    
    // SIX
    @IBAction func btn_six(_ sender: Any) {
        if (canTouch == true){
            let ins_num: Int = 6;
            user_num = (user_num * 10) + ins_num;
            place = place + 1;
            lbl_answer.text = String(user_num);
        }
    }
    
    // SEVEN
    @IBAction func btn_seven(_ sender: Any) {
        if (canTouch == true){
            let ins_num: Int = 7;
            user_num = (user_num * 10) + ins_num;
            place = place + 1;
            lbl_answer.text = String(user_num);
        }
    }
    
    // EIGHT
    @IBAction func btn_eight(_ sender: Any) {
        if (canTouch == true){
            let ins_num: Int = 8;
            user_num = (user_num * 10) + ins_num;
            place = place + 1;
            lbl_answer.text = String(user_num);
        }
    }
    
    // NINE
    @IBAction func btn_nine(_ sender: Any) {
        if (canTouch == true){
            let ins_num: Int = 9;
            user_num = (user_num * 10) + ins_num;
            place = place + 1;
            lbl_answer.text = String(user_num);
        }
    }
    
    // CLEAR
    @IBAction func btn_clear(_ sender: Any) {
        if (canTouch == true){
            place = 1;
            user_num = 0;
            lbl_answer.text = String(user_num);
        }
    }
    
    // NEXT QUESTION
    @IBAction func btn_nextQuestion(_ sender: Any) {
        NextQuestion();
    }
    
    // NEGATIVE NUMBER
    @IBAction func btn_polarity(_ sender: Any) {
        if (lbl_polarity.isHidden == true){
            lbl_polarity.isHidden = false;
        }
        else {
            lbl_polarity.isHidden = true;
        }
    }
    
    
    
    
    // Function used to rotate the question and re-enable touch on the keypad
    func NextQuestion(){
        if (mode_symbol == 1){ // +
            lbl_symbol.text = "+";
            //Easy
            if (mode_difficulty == 1){
                temp1 = Int.random(in: 1 ... 15)
                temp2 = Int.random(in: 1 ... 15)
            }
            
            //Medium
            if (mode_difficulty == 2){
                temp1 = Int.random(in: 20 ... 99)
                temp2 = Int.random(in: 1 ... 99)
            }
            
            //Hard
            if (mode_difficulty == 3){
                temp1 = Int.random(in: 50 ... 9999)
                temp2 = Int.random(in: 50 ... 9999)
            }
            
            num1 = temp1;
            num2 = temp2;
            numAns = num1 + num2;
        }
            
        else if (mode_symbol == 2){ // -
            lbl_symbol.text = "-";
            //Easy
            if (mode_difficulty == 1){
                temp1 = Int.random(in: 1 ... 15)
                temp2 = Int.random(in: 1 ... 20)
            }
            
            //Medium
            if (mode_difficulty == 2){
                temp1 = Int.random(in: 20 ... 99)
                temp2 = Int.random(in: 1 ... 130)
            }
            
            //Hard
            if (mode_difficulty == 3){
                temp1 = Int.random(in: 50 ... 9999)
                temp2 = Int.random(in: 50 ... 9999)
            }
            
            num1 = temp1;
            num2 = temp2;
            numAns = num1 - num2;
        }
            
        else if (mode_symbol == 3){ // X
            lbl_symbol.text = "x";
            //Easy
            if (mode_difficulty == 1){
                repeat {
                    temp1 = Int.random(in: 1 ... 20)
                    temp2 = Int.random(in: 1 ... 4)
                } while ((temp1 % temp2) != 0)
            }
            
            //Medium
            if (mode_difficulty == 2){
                temp1 = Int.random(in: 10 ... 50)
                temp2 = Int.random(in: 1 ... 10)
            }
            
            //Hard
            if (mode_difficulty == 3){
                temp1 = Int.random(in: 50 ... 9990)
                temp2 = Int.random(in: 15 ... 9990)
            }
            
            num1 = temp1;
            num2 = temp2;
            numAns = num1 * num2;
        }
            
        else if (mode_symbol == 4){ // %
            lbl_symbol.text = "%";
            //Easy
            if (mode_difficulty == 1){
                repeat {
                    temp1 = Int.random(in: 4 ... 20)
                    temp2 = Int.random(in: 1 ... (temp1 / 2))
                } while ((temp1 % temp2) != 0)
            }
            
            //Medium
            if (mode_difficulty == 2){
                repeat {
                    temp1 = Int.random(in: 10 ... 100)
                    temp2 = Int.random(in: 1 ... (temp1 / 2))
                } while ((temp1 % temp2) != 0)
            }
            
            //Hard
            if (mode_difficulty == 3){
                repeat {
                    temp1 = Int.random(in: 50 ... 9999)
                    temp2 = Int.random(in: 15 ... (temp1 / 2))
                } while ((temp1 % temp2) != 0)
            }
            
            num1 = temp1;
            num2 = temp2;
            numAns = num1 / num2;
        }
        
        // Transfer new numbers to lables
        lbl_top.text = String(num1);
        lbl_bottom.text = String(num2);
        lbl_answer.text = "";
        
        // Set place value to 1 which allows an entered number to be in the correct number column.
        place = 1;
        
        // Holds the value for the number the user sees.
        user_num = 0;
        
        // Hide the "Next Question" button until question is answered.
        out_nextquestion.isHidden = true;
        
        // Allows the keypad to be enabled again.
        canTouch = true;
        
        // End condition triggers when question has reached the max allowed.
        if (score_Qcurrent >= score_Qmax) {
            canTouch = false;
            lbl_bottom.text = "";
            lbl_answer.text = "DONE!";
            lbl_symbol.text = "";
        }
    }
    
    
    // Function sets all variables for a new quiz.
    func start(){
        // Set Variables
        num1 = 0;
        num2 = 0;
        numAns = 0;
        
        place = 1;
        user_num = 0;
        
        score_right = 0;
        score_wrong = 0;
        score_Qcurrent = 0;
        score_Qmax = 10;
        
        canTouch = true;
        out_nextquestion.isHidden = true;
        
        NextQuestion();
        progviewquiz.progress = Float(0);
    }
    
    
    // Function is used in "Next Question" to manipulate the viewable values.
    func score(right: Int, wrong: Int, question: Int){
        score_right = score_right + right;
        score_wrong = score_wrong + wrong;
        score_Qcurrent = score_Qcurrent + question;
        
        lbl_right.text = "Right: " + String(score_right);
        lbl_wrong.text = "Wrong: " + String(score_wrong);
        let score_percentage: Float = (Float(score_Qcurrent) / Float(score_Qmax));
        progviewquiz.setProgress(score_percentage, animated: true);
    }
}
