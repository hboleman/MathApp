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
        
        
    }
    
    func binaryConversion(str: String) -> String {
        // Binary String Values
        // binSortNum 0000 questions type:11001100 difficulty:110011001 date:Year-to-32:100000 Month:1100 Day-to-31:11111 Hr-to-24:11000 Min-to-60:111100
        // 2 = 000000
        if (str == "000000"){return "2"}
        else if (str == "2"){return "000000"}
        // 3 = 000001
        if (str == "000001"){return "3"}
        else if (str == "3"){return "000001"}
        // 4 = 000010
        if (str == "000010"){return "4"}
        else if (str == "4"){return "000010"}
        // 5 = 000011
        if (str == "000011"){return "5"}
        else if (str == "5"){return "000011"}
        // 6 = 000100
        if (str == "000100"){return "6"}
        else if (str == "6"){return "000100"}
        // 7 = 000101
        if (str == "000101"){return "7"}
        else if (str == "7"){return "000101"}
        // 8 = 000110
        if (str == "000110"){return "8"}
        else if (str == "8"){return "000110"}
        // 9 = 000111
        if (str == "000111"){return "9"}
        else if (str == "9"){return "000111"}
        // a = 001000
        if (str == "001000"){return "a"}
        else if (str == "a"){return "001000"}
        // b = 001001
        if (str == "001001"){return "b"}
        else if (str == "b"){return "001001"}
        // c = 001010
        if (str == "001010"){return "c"}
        else if (str == "c"){return "001010"}
        // d = 001011
        if (str == "001011"){return "d"}
        else if (str == "d"){return "001011"}
        // e = 001100
        if (str == "001100"){return "e"}
        else if (str == "e"){return "001100"}
        // f = 001101
        if (str == "001101"){return "f"}
        else if (str == "f"){return "001101"}
        // g = 001110
        if (str == "001110"){return "g"}
        else if (str == "g"){return "001110"}
        // h = 001111
        if (str == "001111"){return "h"}
        else if (str == "h"){return "001111"}
        // j = 010000
        if (str == "010000"){return "j"}
        else if (str == "j"){return "010000"}
        // k = 010001
        if (str == "010001"){return "k"}
        else if (str == "k"){return "010001"}
        // m = 010010
        if (str == "010010"){return "m"}
        else if (str == "m"){return "010010"}
        // n = 010011
        if (str == "010011"){return "n"}
        else if (str == "n"){return "010011"}
        // p = 010100
        if (str == "010100"){return "p"}
        else if (str == "p"){return "010100"}
        // q = 010101
        if (str == "010101"){return "q"}
        else if (str == "q"){return "010101"}
        // r = 010110
        if (str == "010110"){return "r"}
        else if (str == "r"){return "010110"}
        // s = 010111
        if (str == "010111"){return "s"}
        else if (str == "s"){return "010111"}
        // t = 011000
        if (str == "011000"){return "t"}
        else if (str == "t"){return "011000"}
        // u = 011001
        if (str == "011001"){return "u"}
        else if (str == "u"){return "011001"}
        // v = 011010
        if (str == "011010"){return "v"}
        else if (str == "v"){return "011010"}
        // w = 011011
        if (str == "011011"){return "w"}
        else if (str == "w"){return "011011"}
        // x = 011100
        if (str == "011100"){return "x"}
        else if (str == "x"){return "011100"}
        // y = 011101
        if (str == "011101"){return "y"}
        else if (str == "y"){return "011101"}
        // z = 011110
        if (str == "011110"){return "z"}
        else if (str == "z"){return "011110"}
        // A = 011111
        if (str == "011111"){return "A"}
        else if (str == "A"){return "011111"}
        // B = 100000
        if (str == "100000"){return "B"}
        else if (str == "B"){return "100000"}
        // C = 100001
        if (str == "100001"){return "C"}
        else if (str == "C"){return "100001"}
        // D = 100010
        if (str == "100010"){return "D"}
        else if (str == "D"){return "100010"}
        // E = 100011
        if (str == "100011"){return "E"}
        else if (str == "E"){return "100011"}
        // F = 100100
        if (str == "100100"){return "F"}
        else if (str == "F"){return "100100"}
        // G = 100101
        if (str == "100101"){return "G"}
        else if (str == "G"){return "100101"}
        // H = 100110
        if (str == "100110"){return "H"}
        else if (str == "H"){return "100110"}
        // J = 100111
        if (str == "100111"){return "J"}
        else if (str == "J"){return "100111"}
        // K = 101000
        if (str == "101000"){return "K"}
        else if (str == "K"){return "101000"}
        // M = 101001
        if (str == "101001"){return "M"}
        else if (str == "M"){return "101001"}
        // N = 101010
        if (str == "101010"){return "N"}
        else if (str == "N"){return "101010"}
        // P = 101011
        if (str == "101011"){return "P"}
        else if (str == "P"){return "101011"}
        // Q = 101100
        if (str == "101100"){return "Q"}
        else if (str == "Q"){return "101100"}
        // R = 101101
        if (str == "101101"){return "R"}
        else if (str == "R"){return "101101"}
        // S = 101110
        if (str == "101110"){return "S"}
        else if (str == "S"){return "101110"}
        // T = 101111
        if (str == "101111"){return "T"}
        else if (str == "T"){return "101111"}
        // U = 110000
        if (str == "110000"){return "U"}
        else if (str == "U"){return "110000"}
        // V = 110001
        if (str == "110001"){return "V"}
        else if (str == "V"){return "110001"}
        // W = 110010
        if (str == "110010"){return "W"}
        else if (str == "W"){return "110010"}
        // X = 110011
        if (str == "110011"){return "X"}
        else if (str == "X"){return "110011"}
        // Y = 110100
        if (str == "110100"){return "Y"}
        else if (str == "Y"){return "110100"}
        // Z = 110101
        if (str == "110101"){return "Z"}
        else if (str == "Z"){return "110101"}
        // @ = 110110
        if (str == "110110"){return "@"}
        else if (str == "@"){return "110110"}
        // & = 110111
        if (str == "110111"){return "&"}
        else if (str == "&"){return "110111"}
        // ? = 111000
        if (str == "111000"){return "?"}
        else if (str == "?"){return "111000"}
        // ! = 111001
        if (str == "111001"){return "!"}
        else if (str == "!"){return "111001"}
        // - = 111010
        if (str == "111010"){return "-"}
        else if (str == "-"){return "111010"}
        // # = 111011
        if (str == "111011"){return "#"}
        else if (str == "#"){return "111011"}
        // % = 111100
        if (str == "111100"){return "%"}
        else if (str == "%"){return "111100"}
        // + = 111101
        if (str == "111101"){return "+"}
        else if (str == "+"){return "111101"}
        // < = 111110
        if (str == "111110"){return "<"}
        else if (str == "<"){return "111110"}
        // > = 111111
        if (str == "111111"){return ">"}
        else if (str == ">"){return "111111"}
        // 64 total characters that are unambigious
        return ""
    }
    
    func charToInt(char: String) -> Int {
        if (char == "0"){return 0;}
        else if (char == "1"){return 1;}
        else if (char == "2"){return 2;}
        else if (char == "3"){return 3;}
        else if (char == "4"){return 4;}
        else if (char == "5"){return 5;}
        else if (char == "6"){return 6;}
        else if (char == "7"){return 7;}
        else if (char == "8"){return 8;}
        else if (char == "9"){return 9;}
        else {return -1}
    }
    
    func IntTochar(num: Int) -> String {
        if (num == 0){return "0"}
        else if (num == 1){return "1";}
        else if (num == 2){return "2";}
        else if (num == 3){return "3";}
        else if (num == 4){return "4";}
        else if (num == 5){return "5";}
        else if (num == 6){return "6";}
        else if (num == 7){return "7";}
        else if (num == 8){return "8";}
        else if (num == 9){return "9"}
        else {return "-1"}
    }
 
}

//------------------------------ String Extension ------------------------------//

extension String {
    
    func index(at position: Int, from start: Index? = nil) -> Index? {
        let startingIndex = start ?? startIndex
        return index(startingIndex, offsetBy: position, limitedBy: endIndex)
    }
    
    func character(at position: Int) -> Character? {
        guard position >= 0, let indexPosition = index(at: position) else {
            return nil
        }
        return self[indexPosition]
    }
}
