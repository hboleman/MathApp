//
//  Student.swift
//  MathApp
//
//  Created by Hunter Boleman on 6/9/19.
//  Copyright © 2019 Hunter Boleman. All rights reserved.
//

import UIKit
import Foundation
import GameplayKit

class Student: UIViewController {
    
    //-------------------- Class Setup --------------------//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfDefaultsNeedSetup()
        // Populate local variables with UserData information
        studentCode = defaults.integer(forKey: "stuNum")
        stuNumField.text = String(studentCode)
        shuffle = defaults.bool(forKey: "shuffle")
    }
    
    func save_defaults(){
        defaults.set(shuffle, forKey: "shuffle");
        defaults.set(studentCode, forKey: "stuNum")
        defaults.synchronize();
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("VC:ViewWillDis");
        save_defaults();
    }
    
    //-------------------- Outlets --------------------//
    
    @IBOutlet weak var codeEntryField: UITextField!
    @IBOutlet weak var stuNumField: UITextField!
    @IBOutlet weak var lableAboveCode: UILabel!
    @IBOutlet weak var quizNumLable: UILabel!
    @IBOutlet weak var takeQuiz: UIButton!
    
    //-------------------- Variables --------------------//
    // For reading code
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
    
    // For code logic
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
    
    var hwArray: [(question: Int, difficulty: Int)] = []
    
    // Debug
    let debugIn: Bool = false
    let debugBinSeperation: Bool = false
    
    //-------------------- Actions --------------------//
    
    // Validates that the code sent as input is valid as a code, and not past due date
    @IBAction func checkCode(_ sender: Any) {
        // Reset input failed flag
        checkFailed = false
        
        // Validation check is run after extraction.
        
        // Run if data is valid
            quizNumLable.text = String("Quiz Number: \(hwCode)")
            lableAboveCode.text = "Enter Code"
            quizNumLable.isHidden = false
            takeQuiz.isHidden = false
            lableAboveCode.textColor = UIColor(red:0.56, green:0.81, blue:0.48, alpha:1.0);
            disassembleHumanReadableCode(hrCode: codeEntryField.text!)
            disassembleBinaryCode(binCode: disCodeInBin)
    }
    
    //-------------------- Other Functions --------------------//
    
    // Checks inputed values or code for validity
    func checkForValidInput(){
        //checks that number of questions has a valud number
        if(numOfQuestions_add < 0 && numOfQuestions_add > 255){ checkFailed = true }
        if(numOfQuestions_sub < 0 && numOfQuestions_sub > 255){ checkFailed = true }
        if(numOfQuestions_mul < 0 && numOfQuestions_mul > 255){ checkFailed = true }
        if(numOfQuestions_div < 0 && numOfQuestions_div > 255){ checkFailed = true }
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
        // Student Code Check
        if((stuNumField.text?.isEmpty ?? nil)!){ checkFailed = true}
        if((stuNumField.text!.count > 3 || stuNumField.text!.count < 0) && checkFailed == false){ checkFailed = true }
        if((Int(stuNumField.text!)! < 1 || Int(stuNumField.text!)! > 999) && checkFailed == false){ checkFailed = true }
        // Parity
        if (checkFailed == false){
            var posCount = 0
            for index in 0..<disCodeInBin.count{
                if (disCodeInBin.character(at: index)! == "1"){posCount = posCount + 1}
            }
            let posMod = posCount % 2
            var tempPar: Bool = false
            if (posMod != 0){tempPar = true}
            else {tempPar = false}
            if (tempPar != false){checkFailed = true}
        }
    }
    
    // Turns binary code to useable data
    func disassembleBinaryCode(binCode: String) {
        checkFailed = false
        var binaryCode = binCode
        var binarySnipit = ""
        // Pre-Check
        if (binCode.count != properBinaryCount && debugIn == false){checkFailed = true}
        print("disCount: \(binaryCode.count)")
        // If Validity Passed Start Extraction
        if (checkFailed == false){
            
            // Extracting Add Question Number
            binarySnipit = ""
            for index in 0..<8 {binarySnipit.append(binaryCode.character(at: index)!)}
            print("(BinSnip: \(binarySnipit)")
            for _ in 0..<8 {binaryCode.removeFirst()}
            print("LeftBin: \(binaryCode)")
            numOfQuestions_add = binToInt(bin: binarySnipit); // 8
            
            // Extracting Sub Question Number
            binarySnipit = ""
            for index in 0..<8 {binarySnipit.append(binaryCode.character(at: index)!)}
            print("(BinSnip: \(binarySnipit)")
            for _ in 0..<8 {binaryCode.removeFirst()}
            print("LeftBin: \(binaryCode)")
            numOfQuestions_sub = binToInt(bin: binarySnipit); // 8
            
            // Extracting Mul Question Number
            binarySnipit = ""
            for index in 0..<8 {binarySnipit.append(binaryCode.character(at: index)!)}
            print("(BinSnip: \(binarySnipit)")
            for _ in 0..<8 {binaryCode.removeFirst()}
            print("LeftBin: \(binaryCode)")
            numOfQuestions_mul = binToInt(bin: binarySnipit); // 8
            
            // Extracting Div Question Number
            binarySnipit = ""
            for index in 0..<8 {binarySnipit.append(binaryCode.character(at: index)!)}
            print("(BinSnip: \(binarySnipit)")
            for _ in 0..<8 {binaryCode.removeFirst()}
            print("LeftBin: \(binaryCode)")
            numOfQuestions_div = binToInt(bin: binarySnipit); // 8
            
            // Extracting Add Diff Number
            binarySnipit = ""
            for index in 0..<2 {binarySnipit.append(binaryCode.character(at: index)!)}
            print("(BinSnip: \(binarySnipit)")
            for _ in 0..<2 {binaryCode.removeFirst()}
            print("LeftBin: \(binaryCode)")
            difficulty_add = binToInt(bin: binarySnipit); // 2
            
            // Extracting Sub Diff Number
            binarySnipit = ""
            for index in 0..<2 {binarySnipit.append(binaryCode.character(at: index)!)}
            print("(BinSnip: \(binarySnipit)")
            for _ in 0..<2 {binaryCode.removeFirst()}
            print("LeftBin: \(binaryCode)")
            difficulty_sub = binToInt(bin: binarySnipit); // 2
            
            // Extracting Mul Diff Number
            binarySnipit = ""
            for index in 0..<2 {binarySnipit.append(binaryCode.character(at: index)!)}
            print("(BinSnip: \(binarySnipit)")
            for _ in 0..<2 {binaryCode.removeFirst()}
            print("LeftBin: \(binaryCode)")
            difficulty_mul = binToInt(bin: binarySnipit); // 2
            
            // Extracting Div Diff Number
            binarySnipit = ""
            for index in 0..<2 {binarySnipit.append(binaryCode.character(at: index)!)}
            print("(BinSnip: \(binarySnipit)")
            for _ in 0..<2 {binaryCode.removeFirst()}
            print("LeftBin: \(binaryCode)")
            difficulty_div = binToInt(bin: binarySnipit); // 2
            
            // Extracting Date
            binarySnipit = ""
            for index in 0..<28 {binarySnipit.append(binaryCode.character(at: index)!)}
            print("(BinSnip: \(binarySnipit)")
            for _ in 0..<28 {binaryCode.removeFirst()}
            print("LeftBin: \(binaryCode)")
            getDate(dateStr: binarySnipit)  // 28
            
            // Extracting Shuffle Bool
            binarySnipit = ""
            binarySnipit.append(binaryCode.character(at: 0)!)
            print("(BinSnip: \(binarySnipit)")
            binaryCode.removeFirst()
            if (binarySnipit == "1"){shuffle = true}
            else {shuffle = false} // 1
            print("LeftBin: \(binaryCode)")
            
            // Extracting Instructor Code
            binarySnipit = ""
            for index in 0..<15 {binarySnipit.append(binaryCode.character(at: index)!)}
            print("(BinSnip: \(binarySnipit)")
            for _ in 0..<15 {binaryCode.removeFirst()}
            print("LeftBin: \(binaryCode)")
            instructorCode = binToInt(bin: binarySnipit); // 15
            
            // Extracting Homework Code
            binarySnipit = ""
            for index in 0..<11 {binarySnipit.append(binaryCode.character(at: index)!)}
            print("(BinSnip: \(binarySnipit)")
            for _ in 0..<11 {binaryCode.removeFirst()}
            print("LeftBin: \(binaryCode)")
            hwCode = binToInt(bin: binarySnipit); // 15
            quizNumLable.text = ("Quiz Number: \(String(hwCode))")
            
            // Extracting Student Code
            binarySnipit = ""
            for index in 0..<9 {binarySnipit.append(binaryCode.character(at: index)!)}
            print("(BinSnip: \(binarySnipit)")
            for _ in 0..<9 {binaryCode.removeFirst()}
            print("LeftBin: \(binaryCode)")
            // Had to modify code to input what the student given code is
            studentCode = Int(stuNumField.text!)!
            
            // Extracting Parity
            binarySnipit = ""
            binarySnipit.append(binaryCode.character(at: 0)!)
            print("(BinSnip: \(binarySnipit)")
            binaryCode.removeFirst()
            if (binarySnipit == "1"){parityBit = true}
            else {parityBit = false} // 1
            print("LeftBin: \(binaryCode)")
            
            // PRINT EXTRACTED VALUES
            print("---------- ENCODED DATA ----------")
            print("QADD: \(numOfQuestions_add) QSUB: \(numOfQuestions_sub)   QMUL: \(numOfQuestions_mul)   QDIV: \(numOfQuestions_div)")
            print("DADD: \(difficulty_add) DSUB: \(difficulty_sub)   DMUL: \(difficulty_mul)   DDIV: \(difficulty_div)")
            print("DATE: Y:\(year) M:\(month) D:\(day) H:\(hour) M:\(min)")
            print("SHUF: \(shuffle)   Teach: \(instructorCode)")
            print("HW#: \(hwCode)   STU: \(studentCode)   PAR: \(parityBit)")
            print("----------------------------------")
            // If in debug, skip validation check
            if (debugIn == false){checkForValidInput()}
            
        }
        if (checkFailed == true) {
            // if check failed
            lableAboveCode.textColor = UIColor(red:0.89, green:0.44, blue:0.31, alpha:1.0)
            lableAboveCode.text = "Invalid"
            quizNumLable.text = String("Quiz Number: ")
            quizNumLable.isHidden = true
            takeQuiz.isHidden = true
            // If check passed,
        }
    }
    
    // Function gets date data from binary
    func getDate(dateStr: String){
        var binarySnipit: String = ""
        var binaryCode: String = dateStr
        
        // Extracting Year Code
        binarySnipit = ""
        for index in 0..<7 {
            binarySnipit.append(binaryCode.character(at: index)!)
        }
        print("(BinSnip: \(binarySnipit)")
        for _ in 0..<7 {
            binaryCode.removeFirst()
        }
        print("LeftBin: \(binaryCode)")
        year = String(binToInt(bin: binarySnipit)) // 7
        
        // Extracting Month Code
        binarySnipit = ""
        for index in 0..<4 {
            binarySnipit.append(binaryCode.character(at: index)!)
        }
        print("(BinSnip: \(binarySnipit)")
        for _ in 0..<4 {
            binaryCode.removeFirst()
        }
        print("LeftBin: \(binaryCode)")
        month = String(binToInt(bin: binarySnipit)) // 4
        
        // Extracting Day Code
        binarySnipit = ""
        for index in 0..<6 {
            binarySnipit.append(binaryCode.character(at: index)!)
        }
        print("(BinSnip: \(binarySnipit)")
        for _ in 0..<6 {
            binaryCode.removeFirst()
        }
        print("LeftBin: \(binaryCode)")
        day = String(binToInt(bin: binarySnipit)) // 6
        
        // Extracting Hour Code
        binarySnipit = ""
        for index in 0..<5 {
            binarySnipit.append(binaryCode.character(at: index)!)
        }
        print("(BinSnip: \(binarySnipit)")
        for _ in 0..<5 {
            binaryCode.removeFirst()
        }
        print("LeftBin: \(binaryCode)")
        hour = String(binToInt(bin: binarySnipit)) // 5
        
        // Extracting Min Code
        binarySnipit = ""
        for index in 0..<6 {
            binarySnipit.append(binaryCode.character(at: index)!)
        }
        print("(BinSnip: \(binarySnipit)")
        for _ in 0..<6 {
            binaryCode.removeFirst()
        }
        print("LeftBin: \(binaryCode)")
        min = String(binToInt(bin: binarySnipit)) // 6
    }
    
    // Turns the code into binary
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
            for _ in 0..<diff {
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
    
    @IBAction func codeMessageFieldPrimaryAction(_ sender: Any) {
        codeEntryField.resignFirstResponder()
    }
    
    @IBAction func stuMessageFieldPrimaryAction(_ sender: Any) {
        stuNumField.resignFirstResponder()
    }
    
    // Prep for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Create a new variable to store the instance of Quiz
        let destinationVC = segue.destination as! Quiz
        destinationVC.homeworkQuiz = true
        // Gets the mode set (maybe not needed)
        var count = 0
        if (self.numOfQuestions_add > 0){modesActive[0] = true}
        if (self.numOfQuestions_sub > 0){modesActive[1] = true}
        if (self.numOfQuestions_mul > 0){modesActive[2] = true}
        if (self.numOfQuestions_div > 0){modesActive[3] = true}
        //destinationVC.modesActive = self.modesActive
        
        // Sets true question count
        count = 0
        count = numOfQuestions_add + count
        count = numOfQuestions_sub + count
        count = numOfQuestions_mul + count
        count = numOfQuestions_div + count
        destinationVC.questionCount = count
        destinationVC.score_Qmax = count
        
        // Generation question array
        for _ in 0..<numOfQuestions_add {
            if difficulty_add == 1 {hwArray.append((1, 1))}
            if difficulty_add == 2 {hwArray.append((1, 2))}
            if difficulty_add == 3 {hwArray.append((1, 3))}
        }
        for _ in 0..<numOfQuestions_sub {
            if numOfQuestions_sub == 1 {hwArray.append((2, 1))}
            if numOfQuestions_sub == 2 {hwArray.append((2, 2))}
            if numOfQuestions_sub == 3 {hwArray.append((2, 3))}
        }
        for _ in 0..<numOfQuestions_mul {
            if numOfQuestions_mul == 1 {hwArray.append((3, 1))}
            if numOfQuestions_mul == 2 {hwArray.append((3, 2))}
            if numOfQuestions_mul == 3 {hwArray.append((3, 3))}
        }
        for _ in 0..<numOfQuestions_div {
            if numOfQuestions_div == 1 {hwArray.append((4, 1))}
            if numOfQuestions_div == 2 {hwArray.append((4, 2))}
            if numOfQuestions_div == 3 {hwArray.append((4, 3))}
        }
        
        // Sets and sends the seed
        let tempStr = (String(instructorCode) + String(hwCode))
        let tempInt = UInt64(tempStr)
        let seed = tempInt
        destinationVC.seed = seed!
        // Sets generator
        var generator = SeededGenerator(seed: seed!)
        // Shuffles the array using the predetermined seed
        destinationVC.shuffle = true
        var hwArrayCopy: [(question: Int, difficulty: Int)] = []
        if (shuffle){
            for _ in 0..<hwArray.count {
            let randomInt = Int.random(in: 0 ..< (hwArray.count), using: &generator)
            let tempVar = hwArray[randomInt]
                hwArray.remove(at: randomInt)
            hwArrayCopy.append((question: tempVar.question, difficulty: tempVar.difficulty))
            }
            destinationVC.hwArray = hwArrayCopy
        }
            // If not shuffling array
        else {destinationVC.hwArray = hwArray}
        
        // Set other data needed for results
        destinationVC.instructorCode = self.instructorCode
        destinationVC.hwCode = self.hwCode
        destinationVC.studentCode = self.studentCode
        destinationVC.stuGrade = self.stuGrade
    }
}
