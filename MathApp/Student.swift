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
    @IBOutlet weak var quizNumDispLbl: UILabel!
    @IBOutlet weak var invalidLable: UILabel!
    
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
    
    var binaryCode = ""
    var binarySnipit = ""
    
    // For invalid message
    var invalidMessage = ""
    var invalidNumOfQsBounds = false
    var invalidTeacherCodeBounds = false
    var invalidHWCodeBounds = false
    var invalidStuCodeBounds = false
    var invalidParity = false
    var invalidPastDue = false
    var invalidCount = false
    var invalidAreadyTaken = false
    
    // Arrays
    var hwArray: [(question: Int, difficulty: Int)] = []
    
    // Debug
    let debugIn: Bool = false
    let debugBinSeperation: Bool = false
    
    //-------------------- Actions --------------------//
    
    // Validates that the code sent as input is valid as a code, and not past due date
    @IBAction func checkCode(_ sender: Any) {
        runPreCheck(binCode: disCodeInBin)
        getDataFromCode()
        runPostCheck()
    }
    
    //-------------------- Other Functions --------------------//
    
    func getDataFromCode(){
        // run to clear error message
        quizNumLable.text = String("\(hwCode)")
        lableAboveCode.text = "Enter Code"
        // run after valid
        quizNumLable.isHidden = false
        quizNumDispLbl.isHidden = false
        takeQuiz.isHidden = false
        lableAboveCode.textColor = UIColor(red:0.56, green:0.81, blue:0.48, alpha:1.0);
        // get code info
        disassembleHumanReadableCode(hrCode: codeEntryField.text!)
        disassembleBinaryCode(binCode: disCodeInBin)
    }
    
    func runPreCheck(binCode: String){
        checkFailed = false
        binaryCode = binCode
        binarySnipit = ""
        if (binCode.count != properBinaryCount && debugIn == false){checkFailed = true ; invalidCount = true ; runInvalid()}
        print("disCount: \(binaryCode.count)")
    }
    
    func runInvalid(){
        prepInvalidDisp()
        lableAboveCode.textColor = UIColor(red:0.89, green:0.44, blue:0.31, alpha:1.0)
        lableAboveCode.text = "Invalid"
        invalidLable.isHidden = false
        quizNumLable.text = String("")
        quizNumLable.isHidden = true
        quizNumDispLbl.isHidden = true
        takeQuiz.isHidden = true
    }
    
    func prepInvalidDisp(){
        invalidMessage = ""
        if (invalidNumOfQsBounds){invalidMessage.append(contentsOf: "\nInvalid number of questions")}
        else if (invalidTeacherCodeBounds){invalidMessage.append(contentsOf: "\nInvalid teacher code")}
        else if (invalidHWCodeBounds){invalidMessage.append(contentsOf: "\nInvalid homework number")}
        else if (invalidStuCodeBounds){invalidMessage.append(contentsOf: "\nInvalid student number")}
        else if (invalidParity){invalidMessage.append(contentsOf: "\nCode does not validate")}
        else if (invalidPastDue){invalidMessage.append(contentsOf: "\nQuiz past due")}
        else if (invalidCount){invalidMessage.append(contentsOf: "\nCode does not validate")}
        else if (invalidAreadyTaken){invalidMessage.append(contentsOf: "\nQuiz has already been taken")}
    }
    
    // Checks inputed values or code for validity
    func runPostCheck(){
        if (debugIn == false){
            //checks that number of questions has a valid number
            if(numOfQuestions_add < 0 && numOfQuestions_add > 255){ checkFailed = true ; invalidNumOfQsBounds = true }
            if(numOfQuestions_sub < 0 && numOfQuestions_sub > 255){ checkFailed = true ; invalidNumOfQsBounds = true }
            if(numOfQuestions_mul < 0 && numOfQuestions_mul > 255){ checkFailed = true ; invalidNumOfQsBounds = true }
            if(numOfQuestions_div < 0 && numOfQuestions_div > 255){ checkFailed = true ; invalidNumOfQsBounds = true }
            // checks that there is at least one question
            if (checkFailed == false){
                var total = 0
                total = numOfQuestions_add
                total = total + numOfQuestions_sub
                total = total + numOfQuestions_mul
                total = total + numOfQuestions_div
                if (total < 1){checkFailed = true ; invalidNumOfQsBounds = true}
            }
            // Teacher Code
            if((instructorCode < 1111 || instructorCode > 9999) && checkFailed == false){ checkFailed = true ; invalidTeacherCodeBounds = true}
            // Homework Code
            if((hwCode < 1 || hwCode > 999) && checkFailed == false){ checkFailed = true ; invalidHWCodeBounds = true}
            // Student Code Check
            if((stuNumField.text?.isEmpty ?? nil)!){ checkFailed = true ; invalidStuCodeBounds = true}
            if((stuNumField.text!.count > 3 || stuNumField.text!.count < 0) && checkFailed == false){ checkFailed = true ; invalidStuCodeBounds = true}
            if((Int(stuNumField.text!)! < 1 || Int(stuNumField.text!)! > 999) && checkFailed == false){ checkFailed = true ; invalidStuCodeBounds = true}
            // Parity
            if (checkFailed == false){
                var posCount = 0
                for index in 0..<disCodeInBin.count{if (disCodeInBin.character(at: index)! == "1"){posCount = posCount + 1}}
                let posMod = posCount % 2
                var tempPar: Bool = false
                if (posMod != 0){tempPar = true}
                else {tempPar = false}
                if (tempPar != false){checkFailed = true ; invalidParity = true}
            }
            //Due Date Check
            if (pastDue()){checkFailed = true ; invalidPastDue = true}
            // Aready Taken Quiz
            if (isQuizRepeat(quizNum: String(self.hwCode), teachCode: String(self.instructorCode))){checkFailed = true ; invalidAreadyTaken = true}
        }
    }
    
    func pastDue() -> Bool {
        // Get date of now
        let date = Date.init()
        // Get date in comparable format
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        _ = format.string(from: date)
        // Get needed components from date
        let calendar = Calendar.current
        let tempYear = calendar.component(.year, from: date)
        let tempMonth = calendar.component(.month, from: date)
        let tempDay = calendar.component(.day, from: date)
        let tempHour = calendar.component(.hour, from: date)
        let tempMin = calendar.component(.minute, from: date)
        // Format the year for two digits
        if (tempYear > 2000){ year = String(tempYear - 2000)}
        
        // Compare date of code to now
        if(Int(self.year)! > Int(tempYear)){return false}
        else if(Int(self.month)! > Int(tempMonth)){return false}
        else if(Int(self.day)! > Int(tempDay)){return false}
        else if(Int(self.hour)! > Int(tempHour)){return false}
        else if(Int(self.min)! > Int(tempMin)){return false}
        else {return true}
    }
    
    // Turns binary code to useable data
    func disassembleBinaryCode(binCode: String) {
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
            quizNumLable.text = ("\(String(hwCode))")
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
        }
        if (checkFailed == true) {runInvalid()}
    }
    
    // Function gets date data from binary
    func getDate(dateStr: String){
        var binarySnipit: String = ""
        var binaryCode: String = dateStr
        // Extracting Year Code
        binarySnipit = ""
        for index in 0..<7 {binarySnipit.append(binaryCode.character(at: index)!)}
        print("(BinSnip: \(binarySnipit)")
        for _ in 0..<7 {binaryCode.removeFirst()}
        print("LeftBin: \(binaryCode)")
        year = String(binToInt(bin: binarySnipit)) // 7
        // Extracting Month Code
        binarySnipit = ""
        for index in 0..<4 {binarySnipit.append(binaryCode.character(at: index)!)}
        print("(BinSnip: \(binarySnipit)")
        for _ in 0..<4 {binaryCode.removeFirst()}
        print("LeftBin: \(binaryCode)")
        month = String(binToInt(bin: binarySnipit)) // 4
        // Extracting Day Code
        binarySnipit = ""
        for index in 0..<6 {binarySnipit.append(binaryCode.character(at: index)!)}
        print("(BinSnip: \(binarySnipit)")
        for _ in 0..<6 {binaryCode.removeFirst()}
        print("LeftBin: \(binaryCode)")
        day = String(binToInt(bin: binarySnipit)) // 6
        // Extracting Hour Code
        binarySnipit = ""
        for index in 0..<5 {binarySnipit.append(binaryCode.character(at: index)!)}
        print("(BinSnip: \(binarySnipit)")
        for _ in 0..<5 {binaryCode.removeFirst()}
        print("LeftBin: \(binaryCode)")
        hour = String(binToInt(bin: binarySnipit)) // 5
        // Extracting Min Code
        binarySnipit = ""
        for index in 0..<6 {binarySnipit.append(binaryCode.character(at: index)!)}
        print("(BinSnip: \(binarySnipit)")
        for _ in 0..<6 {binaryCode.removeFirst()}
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
        // Copy over binary
        let origBinStr = fullBinString
        // Remove extra zeros at end
        for _ in 0..<leadingBuffer {fullBinString.removeLast()}
        // Copies over the binary version
        disCodeInBin = fullBinString
        // Print Related Info
        print("Reassembled Binary Code:")
        print(fullBinString)
        print("Orig Binary Code:")
        print(origBinStr)
        print("DisassembleHR Code: \(fullBinString)")
        print("DisassembleHR Count: \(fullBinString.count)")
    }
    
    //------------------ Utilities ------------------//
    
    @IBAction func codeMessageFieldPrimaryAction(_ sender: Any) {codeEntryField.resignFirstResponder()}
    @IBAction func stuMessageFieldPrimaryAction(_ sender: Any) {stuNumField.resignFirstResponder()}
    
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
