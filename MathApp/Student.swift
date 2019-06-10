//
//  Student.swift
//  MathApp
//
//  Created by Hunter Boleman on 6/9/19.
//  Copyright © 2019 Hunter Boleman. All rights reserved.
//

import UIKit
import Foundation

class Student: UIViewController {
    
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
    
    //Variable Charts
    //mode_symbol         1=+ 2=- 3=* 4=%
    //mode_difficulty     1=easy 2=medium 3=hard
    
    // Outlet Test
    @IBOutlet weak var codeEntryField: UITextField!
    @IBOutlet weak var stuNumField: UITextField!
    @IBOutlet weak var lableAboveCode: UILabel!
    @IBOutlet weak var quizNumLable: UILabel!
    @IBOutlet weak var takeQuiz: UIButton!
    
    // Variables for generating code
    var numOfQuestions_add: Int = -1;
    var numOfQuestions_sub: Int = -1;
    var numOfQuestions_mul: Int = -1;
    var numOfQuestions_div: Int = -1;
    
    var difficulty_add: Int = -1;
    var difficulty_sub: Int = -1;
    var difficulty_mul: Int = -1;
    var difficulty_div: Int = -1;
    
    var year: String = ""
    var month: String = ""
    var day: String = ""
    var hour: String = ""
    var min: String = ""
    
    var shuffle: Bool = false;
    var instructorCode: Int = -1;
    var hwCode: Int = -1
    var studentCode: Int = -1
    var parityBit: Bool = false
    var stuGrade: Int = 100
    
    var checkFailed = false;
    var assembledBinCode: String = ""
    var codeInHR: String = ""
    var assembledHrCode: String = ""
    var disCodeInBin: String = ""
    var disCodeInHR: String = ""
    let leadingBuffer = 3
    let gradeResultBuffer = 5
    let properBinaryCount = 105
    let testHR = "3j222qpHVepKnm5@z8"
    let testBin = "000001010000000000000000000000010101010100100110110001001100010100101000010011010010000011110110011110110"
    
    //-------------------- Notes --------------------//
    //Function Info
    //binSortNum: used for finding differnt permetations of the most efficent option when comparing differnt generations.
    //questionsType: number for + - * %
    
    // addNum:11111111 subNum:11111111 mulNum:11111111 divNum:11111111 addDiff:11 subDiff: 11 mulDiff:11 divDiff:11
    // date:Year-to-63:1111111 Month:1111 Day-to-31:111111 Hr-to-24:11000 Min-to-60:111100 shuffle:0 teacherCode:010011100001111 74 dig before this (includes parity at end)
    //  hwCode: 01111100111 StudentCode:100000000 parity:0
    // 94 digits now
    // Need to add 3 Digit HW Code and 3 Digit Student Code
    // SAVE THE LAST 100 QUIZES IN DEFAULTS SO STUDENT CANNOT TAKE AGAIN
    
    // Button that Generates Code
    
    @IBAction func checkCode(_ sender: Any) {
        checkFailed = false
        //checkForValidInput()
        
        // --- RUNS IF INPUT IS VALID ---
        if (checkFailed == false){
            quizNumLable.text = String("Quiz Number: \(hwCode)")
            lableAboveCode.text = "Enter Code"
            quizNumLable.isHidden = false
            takeQuiz.isHidden = false
            lableAboveCode.textColor = UIColor(red:0.56, green:0.81, blue:0.48, alpha:1.0);
            disassembleHumanReadableCode(hrCode: codeEntryField.text!)
            disassembleBinaryCode(binCode: disCodeInBin)
        }
        else{
            lableAboveCode.text = "Invalid Option!"
            lableAboveCode.textColor = UIColor(red:0.89, green:0.44, blue:0.31, alpha:1.0)
            quizNumLable.text = String("Quiz Number: ")
            quizNumLable.isHidden = true
            takeQuiz.isHidden = true
        }
    }
    
    // Checks inputed values or code for validity
    func checkForValidInput(){
        // --- CHECKS FOR INVALID INPUT ---
        //checks that number of questions has a valud number
        if(numOfQuestions_add < 0 && numOfQuestions_add < 255){ checkFailed = true }
        if(numOfQuestions_sub < 0 && numOfQuestions_sub < 255){ checkFailed = true }
        if(numOfQuestions_mul < 0 && numOfQuestions_mul < 255){ checkFailed = true }
        if(numOfQuestions_div < 0 && numOfQuestions_div < 255){ checkFailed = true }
        
        // checks that there is at least one question
        if (checkFailed == false){
            var total = 0
            total = numOfQuestions_add
            total = total + numOfQuestions_sub
            total = total + numOfQuestions_mul
            total = total + numOfQuestions_div
            if (total < 1){checkFailed = true}
        }
        
        // Teacher Code
        if((instructorCode < 1111 || instructorCode > 9999) && checkFailed == false){ checkFailed = true }
        
        // Homework Code
        if((hwCode < 1 || hwCode > 999) && checkFailed == false){ checkFailed = true }
        
        // Student Code Check (NEEDS AN INPUT)
        if((stuNumField.text?.isEmpty ?? nil)!){ checkFailed = true}
        if((stuNumField.text!.count > 3 || stuNumField.text!.count < 0) && checkFailed == false){ checkFailed = true }
        if((Int(stuNumField.text!)! < 1 || Int(stuNumField.text!)! > 999) && checkFailed == false){ checkFailed = true }
        
        // Parity
//        if (checkFailed == false){
//            var posCount = 0
//            for index in 0..<disCodeInBin.count{
//                if (disCodeInBin.character(at: index)! == "1"){posCount = posCount + 1}
//            }
//            let posMod = posCount % 2
//            var tempPar: Bool = false
//            if (posMod != 0){tempPar = true}
//            else {tempPar = false}
//            if (parityBit != tempPar){checkFailed = true}
//        }
    }
    
    func disassembleBinaryCode(binCode: String) {
        checkFailed = false
        var binaryCode = binCode
        var binarySnipit = ""
        
        // Pre-Check
        //if (binCode.count != properBinaryCount){checkFailed = true}
        // End Pre-Check
        
        print("disCount: \(binaryCode.count)")
        
        if (checkFailed == false){
            // Extracting Add Question Number
            binarySnipit = ""
            for index in 0..<8 {
                binarySnipit.append(binaryCode.character(at: index)!)
            }
            print(binarySnipit)
            for _ in 0..<8 {
                binaryCode.removeFirst()
            }
            numOfQuestions_add = binToInt(bin: binarySnipit); // 8
            
            // Extracting Sub Question Number
            binarySnipit = ""
            for index in 0..<8 {
                binarySnipit.append(binaryCode.character(at: index)!)
            }
            print(binarySnipit)
            for _ in 0..<8 {
                binaryCode.removeFirst()
            }
            numOfQuestions_sub = binToInt(bin: binarySnipit); // 8
            
            // Extracting Mul Question Number
            binarySnipit = ""
            for index in 0..<8 {
                binarySnipit.append(binaryCode.character(at: index)!)
            }
            print(binarySnipit)
            for _ in 0..<8 {
                binaryCode.removeFirst()
            }
            numOfQuestions_mul = binToInt(bin: binarySnipit); // 8
            
            // Extracting Div Question Number
            binarySnipit = ""
            for index in 0..<8 {
                binarySnipit.append(binaryCode.character(at: index)!)
            }
            print(binarySnipit)
            for _ in 0..<8 {
                binaryCode.removeFirst()
            }
            numOfQuestions_div = binToInt(bin: binarySnipit); // 8
            
            // Extracting Add Diff Number
            binarySnipit = ""
            for index in 0..<2 {
                binarySnipit.append(binaryCode.character(at: index)!)
            }
            print(binarySnipit)
            for _ in 0..<2 {
                binaryCode.removeFirst()
            }
            difficulty_add = binToInt(bin: binarySnipit); // 2
            
            // Extracting Sub Diff Number
            binarySnipit = ""
            for index in 0..<2 {
                binarySnipit.append(binaryCode.character(at: index)!)
            }
            print(binarySnipit)
            for _ in 0..<2 {
                binaryCode.removeFirst()
            }
            difficulty_sub = binToInt(bin: binarySnipit); // 2
            
            // Extracting Mul Diff Number
            binarySnipit = ""
            for index in 0..<2 {
                binarySnipit.append(binaryCode.character(at: index)!)
            }
            print(binarySnipit)
            for _ in 0..<2 {
                binaryCode.removeFirst()
            }
            difficulty_mul = binToInt(bin: binarySnipit); // 2
            
            // Extracting Div Diff Number
            binarySnipit = ""
            for index in 0..<2 {
                binarySnipit.append(binaryCode.character(at: index)!)
            }
            print(binarySnipit)
            for _ in 0..<2 {
                binaryCode.removeFirst()
            }
            difficulty_div = binToInt(bin: binarySnipit); // 2
            
            // Extracting Date
            binarySnipit = ""
            for index in 0..<28 {
                binarySnipit.append(binaryCode.character(at: index)!)
            }
            print(binarySnipit)
            for _ in 0..<28 {
                binaryCode.removeFirst()
            }
            setDate(dateStr: binarySnipit)  // 28
            
            // Extracting Shuffle Bool
            binarySnipit = ""
            binarySnipit.append(binaryCode.character(at: 0)!)
            binaryCode.removeFirst()
            if (binarySnipit == "1"){shuffle = true}
            else {shuffle = false} // 1
            
            // Extracting Instructor Code
            binarySnipit = ""
            for index in 0..<4 {
                binarySnipit.append(binaryCode.character(at: index)!)
            }
            print(binarySnipit)
            for _ in 0..<4 {
                binaryCode.removeFirst()
            }
            instructorCode = binToInt(bin: binarySnipit); // 4
            
            // Extracting Parity
            binarySnipit = ""
            binarySnipit.append(binaryCode.character(at: 0)!)
            binaryCode.removeFirst()
            if (binarySnipit == "1"){parityBit = true}
            else {parityBit = false} // 1
            
            checkForValidInput()
            
        }
        else if (checkFailed == true) {
            // if check failed
            lableAboveCode.textColor = UIColor(red:0.89, green:0.44, blue:0.31, alpha:1.0)
            lableAboveCode.text = "Invalid"
            quizNumLable.text = String("Quiz Number: ")
            quizNumLable.isHidden = true
            takeQuiz.isHidden = true
        }
    }
    
    func setDate(dateStr: String){
        
    }
    
    func binToInt(bin: String) -> Int {
        let test = bin
        var swapStr = ""
        var cnt = 0
        //swap string
        for index in 0..<test.count {
            swapStr.append(contentsOf: String(test.character(at: ((test.count - index) - 1))!))
        }
        
        
        for index in 0..<swapStr.count {
            if(swapStr.character(at: index) == "1"){
                if (index == 0 && swapStr.character(at: index) == "1"){
                    cnt = cnt + 1
                }
                else {
                    cnt = cnt + (2 ^^ (index))
                }
            }
        }
        
        print("BinToInt: \(test)")
        
        return 1
    }
    
    func disassembleHumanReadableCode(hrCode: String){
        var fullBinString = ""
        
        for index in 0..<hrCode.count{
            let hrChar = String(hrCode.character(at: index)!)
            let codeStr = codeConversionCharToBin(str: hrChar)
            fullBinString.append(contentsOf: codeStr)
        }
        
        let origBinStr = fullBinString
        
        // Remove extra zeros at end
        for _ in 0..<leadingBuffer {
            fullBinString.removeLast()
        }
        
        disCodeInBin = fullBinString
        
        print("Reassembled Binary Code:")
        print(fullBinString)
        print("Orig Binary Code:")
        print(origBinStr)
        print("DisassembleHR Code: \(fullBinString)")
        print("DisassembleHR Count: \(fullBinString.count)")
    }
    
    func assembleBinaryCode(){
        assembledBinCode = ""
        
        let teachCode: String = padStringInt( num: instructorCode, length: 15, padding: "0")
        let homewkCode: String = padStringInt( num: hwCode, length: 11, padding: "0")
        let stuCode: String = padStringInt(num: studentCode, length: 9, padding: "0")
        let grade: String = padStringInt(num: stuGrade, length: 8, padding: "0")
        // makes 43
        
        var wholeString: String = ""
        //wholeString.append(contentsOf: " NUM ") // should be 32
        
        wholeString.append(contentsOf: teachCode)
        wholeString.append(contentsOf: homewkCode)
        wholeString.append(contentsOf: grade)
        wholeString.append(contentsOf: stuCode)
        // grade: 01100100
        
        // For Parity
        var posCount = 0
        for index in 0..<wholeString.count{
            if (wholeString.character(at: index)! == "1"){posCount = posCount + 1}
        }
        let posMod = posCount % 2
        if (posMod != 0){parityBit = true}
        else {parityBit = false}
        var parityValue: String = ""
        if (parityBit){parityValue = "1"}
        else{parityValue = "0"}
        // End Parity
        wholeString.append(contentsOf: parityValue)
        
        print("Whole String: \(wholeString)")
        print("Count: \(wholeString.count)")
        assembledBinCode = wholeString
    }
    
    func assembleHumanReadableCode(binCode: String){
        var formingFullString = ""
        var codeToCrunch = binCode
        var strOfSix = ""
        
        while (codeToCrunch.count > 0) {
            if (codeToCrunch.count > 6){
                strOfSix = ""
                for index in 0..<6 {
                    strOfSix.append(codeToCrunch.character(at: index)!)
                }
                print(codeToCrunch)
                for _ in 0..<6 {
                    codeToCrunch.removeFirst()
                }
                print(codeToCrunch)
                print("of6: \(strOfSix)")
            }
            else {
                strOfSix = ""
                for index in 0..<codeToCrunch.count {
                    strOfSix.append(codeToCrunch.character(at: index)!)
                }
                print(codeToCrunch)
                for _ in 0..<codeToCrunch.count {
                    codeToCrunch.removeFirst()
                }
                print(codeToCrunch)
                print("ofX: \(strOfSix)")
            }
            
            let codeCharacter = codeConversionBinToChar(str: strOfSix)
            formingFullString.append(contentsOf: codeCharacter)
            print("HR: \(codeCharacter)")
        }
        
        print("FULL CODE: \(formingFullString)")
        
        assembledHrCode = formingFullString
    }
    
    func getDate(yr: String, mo: String, d: String, h: String, m: String) -> String{
        var temp: String = ""
        
        // Year
        let tempYr = padStringInt(num: Int(yr)!, length: 7, padding: "0")
        temp.append(contentsOf: tempYr)
        // Month
        let tempMo = padStringInt(num: Int(mo)!, length: 4, padding: "0")
        temp.append(contentsOf: tempMo)
        // Day
        let tempD = padStringInt(num: Int(d)!, length: 6, padding: "0")
        temp.append(contentsOf: tempD)
        // Hour
        let tempH = padStringInt(num: Int(h)!, length: 5, padding: "0")
        temp.append(contentsOf: tempH)
        // Minute
        let tempM = padStringInt(num: Int(m)!, length: 6, padding: "0")
        temp.append(contentsOf: tempM)
        
        return temp
    }
    
    // Returns a padded string to specified length and paddign character
    func padStringStr(str: String, length: Int, padding: String) -> String {
        let diff: Int = length - str.count
        var temp: String = ""
        if (diff > 0){
            for index in 0..<diff {
                temp.append(contentsOf: padding)
            }
            temp.append(contentsOf: str)
        }
        else {
            // If no need to pad, just send variable
            temp.append(contentsOf: str)
        }
        return temp
    }
    
    // Taked in an Int and feeds it to the string padder
    func padStringInt(num: Int, length: Int, padding: String) -> String{
        let tempStr = intToBin(number: num)
        let str: String = padStringStr(str: tempStr, length: length, padding: padding)
        return str
    }
    
    //------------------ Utilities ------------------//
    
    // Converts an Int to binary as a String
    func intToBin(number: Int) -> String{
        var num = number
        var str: String = ""
        
        while (num > 1) {
            str.append(contentsOf: (String(num%2)))
            num = num / 2
        }
        if (num > 0){
            str.append(contentsOf: "1")
            num = num - 1;
        }
        
        var strSwap: String = ""
        var count: Int = (str.count - 1)
        for _ in 0..<str.count {
            strSwap.append(contentsOf: String(str.character(at: count)!))
            count = count - 1;
        }
        return strSwap
    }
    
    // Converts binary into Human Readable Characters
    func codeConversionBinToChar(str: String) -> String {
        
        var codeStr = str
        
        // If num less than 6, padd it to 6
        if (str.count < 6){
            codeStr = padStringStr(str: str, length: 6, padding: "0")
        }
        
        // Binary String Values
        // 2 = 000000
        if (codeStr == "000000"){return "2"}
            // 3 = 000001
        else if (codeStr == "000001"){return "3"}
            // 4 = 000010
        else if (codeStr == "000010"){return "4"}
            // 5 = 000011
        else if (codeStr == "000011"){return "5"}
            // 6 = 000100
        else if (codeStr == "000100"){return "6"}
            // 7 = 000101
        else if (codeStr == "000101"){return "7"}
            // 8 = 000110
        else if (codeStr == "000110"){return "8"}
            // 9 = 000111
        else if (codeStr == "000111"){return "9"}
            // a = 001000
        else if (codeStr == "001000"){return "a"}
            // b = 001001
        else if (codeStr == "001001"){return "b"}
            // c = 001010
        else if (codeStr == "001010"){return "c"}
            // d = 001011
        else if (codeStr == "001011"){return "d"}
            // e = 001100
        else if (codeStr == "001100"){return "e"}
            // f = 001101
        else if (codeStr == "001101"){return "f"}
            // g = 001110
        else if (codeStr == "001110"){return "g"}
            // h = 001111
        else if (codeStr == "001111"){return "h"}
            // j = 010000
        else if (codeStr == "010000"){return "j"}
            // k = 010001
        else if (codeStr == "010001"){return "k"}
            // m = 010010
        else if (codeStr == "010010"){return "m"}
            // n = 010011
        else if (codeStr == "010011"){return "n"}
            // p = 010100
        else if (codeStr == "010100"){return "p"}
            // q = 010101
        else if (codeStr == "010101"){return "q"}
            // r = 010110
        else if (codeStr == "010110"){return "r"}
            // s = 010111
        else if (codeStr == "010111"){return "s"}
            // t = 011000
        else if (codeStr == "011000"){return "t"}
            // u = 011001
        else if (codeStr == "011001"){return "u"}
            // v = 011010
        else if (codeStr == "011010"){return "v"}
            // w = 011011
        else if (codeStr == "011011"){return "w"}
            // x = 011100
        else if (codeStr == "011100"){return "x"}
            // y = 011101
        else if (codeStr == "011101"){return "y"}
            // z = 011110
        else if (codeStr == "011110"){return "z"}
            // A = 011111
        else if (codeStr == "011111"){return "A"}
            // B = 100000
        else if (codeStr == "100000"){return "B"}
            // C = 100001
        else if (codeStr == "100001"){return "C"}
            // D = 100010
        else if (codeStr == "100010"){return "D"}
            // E = 100011
        else if (codeStr == "100011"){return "E"}
            // F = 100100
        else if (codeStr == "100100"){return "F"}
            // G = 100101
        else if (codeStr == "100101"){return "G"}
            // H = 100110
        else if (codeStr == "100110"){return "H"}
            // J = 100111
        else if (codeStr == "100111"){return "J"}
            // K = 101000
        else if (codeStr == "101000"){return "K"}
            // M = 101001
        else if (codeStr == "101001"){return "M"}
            // N = 101010
        else if (codeStr == "101010"){return "N"}
            // P = 101011
        else if (codeStr == "101011"){return "P"}
            // Q = 101100
        else if (codeStr == "101100"){return "Q"}
            // R = 101101
        else if (codeStr == "101101"){return "R"}
            // S = 101110
        else if (codeStr == "101110"){return "S"}
            // T = 101111
        else if (codeStr == "101111"){return "T"}
            // U = 110000
        else if (codeStr == "110000"){return "U"}
            // V = 110001
        else if (codeStr == "110001"){return "V"}
            // W = 110010
        else if (codeStr == "110010"){return "W"}
            // X = 110011
        else if (codeStr == "110011"){return "X"}
            // Y = 110100
        else if (codeStr == "110100"){return "Y"}
            // Z = 110101
        else if (codeStr == "110101"){return "Z"}
            // @ = 110110
        else if (codeStr == "110110"){return "@"}
            // & = 110111
        else if (codeStr == "110111"){return "&"}
            // ? = 111000
        else if (codeStr == "111000"){return "?"}
            // ! = 111001
        else if (codeStr == "111001"){return "!"}
            // - = 111010
        else if (codeStr == "111010"){return "-"}
            // # = 111011
        else if (codeStr == "111011"){return "#"}
            // % = 111100
        else if (codeStr == "111100"){return "%"}
            // + = 111101
        else if (codeStr == "111101"){return "+"}
            // < = 111110
        else if (codeStr == "111110"){return "<"}
            // > = 111111
        else if (codeStr == "111111"){return ">"}
        // 64 total characters that are unambigious
        return ""
    }
    
    // Converts Human Readable Characters into Binary
    func codeConversionCharToBin(str: String) -> String {
        
        var codeStr = str
        
        // Binary String Values
        // 2 = 000000
        if (codeStr == "2"){return "000000"}
            // 3 = 000001
        else if (codeStr == "3"){return "000001"}
            // 4 = 000010
        else if (codeStr == "4"){return "000010"}
            // 5 = 000011
        else if (codeStr == "5"){return "000011"}
            // 6 = 000100
        else if (codeStr == "6"){return "000100"}
            // 7 = 000101
        else if (codeStr == "7"){return "000101"}
            // 8 = 000110
        else if (codeStr == "8"){return "000110"}
            // 9 = 000111
        else if (codeStr == "9"){return "000111"}
            // a = 001000
        else if (codeStr == "a"){return "001000"}
            // b = 001001
        else if (codeStr == "b"){return "001001"}
            // c = 001010
        else if (codeStr == "c"){return "001010"}
            // d = 001011
        else if (codeStr == "d"){return "001011"}
            // e = 001100
        else if (codeStr == "e"){return "001100"}
            // f = 001101
        else if (codeStr == "f"){return "001101"}
            // g = 001110
        else if (codeStr == "g"){return "001110"}
            // h = 001111
        else if (codeStr == "h"){return "001111"}
            // j = 010000
        else if (codeStr == "j"){return "010000"}
            // k = 010001
        else if (codeStr == "k"){return "010001"}
            // m = 010010
        else if (codeStr == "m"){return "010010"}
            // n = 010011
        else if (codeStr == "n"){return "010011"}
            // p = 010100
        else if (codeStr == "p"){return "010100"}
            // q = 010101
        else if (codeStr == "q"){return "010101"}
            // r = 010110
        else if (codeStr == "r"){return "010110"}
            // s = 010111
        else if (codeStr == "s"){return "010111"}
            // t = 011000
        else if (codeStr == "t"){return "011000"}
            // u = 011001
        else if (codeStr == "u"){return "011001"}
            // v = 011010
        else if (codeStr == "v"){return "011010"}
            // w = 011011
        else if (codeStr == "w"){return "011011"}
            // x = 011100
        else if (codeStr == "x"){return "011100"}
            // y = 011101
        else if (codeStr == "y"){return "011101"}
            // z = 011110
        else if (codeStr == "z"){return "011110"}
            // A = 011111
        else if (codeStr == "A"){return "011111"}
            // B = 100000
        else if (codeStr == "B"){return "100000"}
            // C = 100001
        else if (codeStr == "C"){return "100001"}
            // D = 100010
        else if (codeStr == "D"){return "100010"}
            // E = 100011
        else if (codeStr == "E"){return "100011"}
            // F = 100100
        else if (codeStr == "F"){return "100100"}
            // G = 100101
        else if (codeStr == "G"){return "100101"}
            // H = 100110
        else if (codeStr == "H"){return "100110"}
            // J = 100111
        else if (codeStr == "J"){return "100111"}
            // K = 101000
        else if (codeStr == "K"){return "101000"}
            // M = 101001
        else if (codeStr == "M"){return "101001"}
            // N = 101010
        else if (codeStr == "N"){return "101010"}
            // P = 101011
        else if (codeStr == "P"){return "101011"}
            // Q = 101100
        else if (codeStr == "Q"){return "101100"}
            // R = 101101
        else if (codeStr == "R"){return "101101"}
            // S = 101110
        else if (codeStr == "S"){return "101110"}
            // T = 101111
        else if (codeStr == "T"){return "101111"}
            // U = 110000
        else if (codeStr == "U"){return "110000"}
            // V = 110001
        else if (codeStr == "V"){return "110001"}
            // W = 110010
        else if (codeStr == "W"){return "110010"}
            // X = 110011
        else if (codeStr == "X"){return "110011"}
            // Y = 110100
        else if (codeStr == "Y"){return "110100"}
            // Z = 110101
        else if (codeStr == "Z"){return "110101"}
            // @ = 110110
        else if (codeStr == "@"){return "110110"}
            // & = 110111
        else if (codeStr == "&"){return "110111"}
            // ? = 111000
        else if (codeStr == "?"){return "111000"}
            // ! = 111001
        else if (codeStr == "!"){return "111001"}
            // - = 111010
        else if (codeStr == "-"){return "111010"}
            // # = 111011
        else if (codeStr == "#"){return "111011"}
            // % = 111100
        else if (codeStr == "%"){return "111100"}
            // + = 111101
        else if (codeStr == "+"){return "111101"}
            // < = 111110
        else if (codeStr == "<"){return "111110"}
            // > = 111111
        else if (codeStr == ">"){return "111111"}
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

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ^^ : PowerPrecedence
func ^^ (radix: Int, power: Int) -> Int {
    return Int(pow(Double(radix), Double(power)))
}
