//
//  GradingScreen.swift
//  MathApp
//
//  Created by Hunter Boleman on 6/25/19.
//  Copyright © 2019 Hunter Boleman. All rights reserved.
//

import UIKit

class GradingScreen: UIViewController {

    //-------------------- Class Setup --------------------//
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //-------------------- Outlets --------------------//
    
    @IBOutlet weak var studentCodeOutlet: UITextField!
    @IBOutlet weak var scoreOutlet: UILabel!
    @IBOutlet weak var studentNumOutlet: UILabel!
    @IBOutlet weak var quizNumOutlet: UILabel!
    @IBOutlet weak var dateOutlet: UILabel!
    
    //-------------------- Variables --------------------//
    
    var instructorCode: Int = 1234;
    var hwCode: Int = 999
    var studentCode: Int = -1
    var parityBit: Bool = false
    var stuGrade: Int = 100
    
    // For code logic
    var checkFailed = false;
    var assembledBinCode: String = ""
    var codeInHR: String = ""
    var assembledHrCode: String = ""
    var disCodeInBin: String = ""
    var disCodeInHR: String = ""
    let leadingBuffer = 1
    let properBinaryCount = 65
    
    var binaryCode = ""
    var binarySnipit = ""
    
    var month: String = ""
    var day: String = ""
    var hour: String = ""
    
    // For invalid message
    var invalidMessage = ""
    var invalidNumOfQsBounds = false
    var invalidTeacherCodeBounds = false
    var invalidHWCodeBounds = false
    var invalidStuCodeBounds = false
    var invalidParity = false
    var invalidPastDue = false
    var invalidCount = false
    var mismatchTeacherCode = false
    var mismatchHwCode = false
    
    // Debug
    let debugBinary: Bool = false
    let debugBinSeperation: Bool = true
    let debugInvalid: Bool = false
    let disableValidation: Bool = true
    
    //-------------------- Actions --------------------//
    
    @IBAction func runCode(_ sender: Any) {
        if (debugInvalid == false){
            checkFailed = false
            getDataFromCode()
            runPostCheck()
            dispPostCheck()
        }
        else {runInvalid()}
    }
    
    //-------------------- Other Functions --------------------//
    
    // Get data from code
    func getDataFromCode(){
        // run to clear error message
//        quizNumLable.text = String("")
//        invalidLable.text = ""
//        dueDateLable.text = ""
//        // run after valid
//        invalidLable.isHidden = true
//        quizNumLable.isHidden = false
//        quizNumDispLbl.isHidden = false
//        dueDateLable.isHidden = false
//        dueLable.isHidden = false
//        takeQuiz.isHidden = false
        // get code info
        disCodeInBin = disassembleHumanReadableCode(hrCode: studentCodeOutlet.text!, leadingBuffer: self.leadingBuffer)
        disassembleBinaryCode(binCode: disCodeInBin)
    }
    
    // Displays info on VC after everything is ready
    func dispPostCheck(){
        // Score
        let gradeIntFirst = Double(stuGrade)
        var gradeValue = gradeIntFirst
        gradeValue = (gradeValue / 100)
        let hrGradeValue = String(format: "%.2f%%", gradeValue)
        scoreOutlet.text = hrGradeValue
        // Student Num
        studentNumOutlet.text = String(studentCode)
        // Quiz Num
        quizNumOutlet.text = String(hwCode)
        //Date
        dateOutlet.text = " \(padStringStr(str: month, length: 2, padding: "0"))-\(padStringStr(str: day, length: 2, padding: "0")) at \(padStringStr(str: hour, length: 2, padding: "0"))"
    }
    
    // Runs when input is invalid
    func runInvalid(){
        print("INVALID")
        prepInvalidDisp()
//        invalidLable.text = invalidMessage
//        invalidLable.isHidden = false
//        quizNumLable.text = ""
//        quizNumLable.isHidden = true
//        quizNumDispLbl.isHidden = true
//        dueDateLable.isHidden = true
//        dueLable.isHidden = true
//        if (invalidPastDue && debugInvalid == false) {dueLable.isHidden = false ; dueDateLable.isHidden = false}
//        else if (debugInvalid){dueLable.isHidden = false}
//        takeQuiz.isHidden = true
    }
    
    // Prepares detailed information for invalid code
    func prepInvalidDisp(){
        invalidMessage = ""
//        if (invalidNumOfQsBounds || debugInvalid){invalidMessage.append(contentsOf: "\nInvalid number of questions")}
//        if (invalidTeacherCodeBounds || debugInvalid){invalidMessage.append(contentsOf: "\nInvalid teacher code")}
//        if (invalidHWCodeBounds || debugInvalid){invalidMessage.append(contentsOf: "\nInvalid homework number")}
//        if (invalidStuCodeBounds || debugInvalid){invalidMessage.append(contentsOf: "\nInvalid student number")}
//        if (invalidParity || debugInvalid){invalidMessage.append(contentsOf: "\nCode does not validate")}
//        if (invalidPastDue || debugInvalid){invalidMessage.append(contentsOf: "\nQuiz past due")}
//        if (invalidCount || debugInvalid){invalidMessage.append(contentsOf: "\nCode does not validate")}
//        if (invalidAreadyTaken || debugInvalid){invalidMessage.append(contentsOf: "\nQuiz has already been taken")}
    }
    
    // Checks inputed values or code for validity
    func runPostCheck(){
        if (debugBinary == false){
            // Teacher Code
            if((instructorCode < 1111 || instructorCode > 9999) && checkFailed == false){ checkFailed = true ; invalidTeacherCodeBounds = true}
            // Homework Code
            if((hwCode < 1 || hwCode > 999) && checkFailed == false){ checkFailed = true ; invalidHWCodeBounds = true}
            // Student Code Check
            if((studentCode > 3 || studentCode < 0) && checkFailed == false){ checkFailed = true ; invalidStuCodeBounds = true}
            if((studentCode < 1 || studentCode > 999) && checkFailed == false){ checkFailed = true ; invalidStuCodeBounds = true}
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
            if (checkFailed == false){
                if (pastDue(year: 0, month: Int(self.month)!, day: Int(self.day)!, hour: Int(self.hour)!, min: 0, ignoreYearMonth: true)){checkFailed = true ; invalidPastDue = true}
            }
            if (checkFailed){runInvalid()}
        }
    }
    
    // Checks binary count against what it should be
    func checkCount(){
        if (disCodeInBin.count != properBinaryCount && debugBinary == false){
            checkFailed = true ;
            invalidCount = true ;
        }
        print("disCount: \(disCodeInBin.count)")
    }
    
    // Turns binary code to useable data
    func disassembleBinaryCode(binCode: String) {
        checkCount()
        // If Validity Passed Start Extraction
        if (checkFailed == false){
            binaryCode = binCode
            // Extracting Date
            binarySnipit = ""
            for index in 0..<15 {binarySnipit.append(binaryCode.character(at: index)!)}
            print("(BinSnip: \(binarySnipit)")
            for _ in 0..<15 {binaryCode.removeFirst()}
            print("LeftBin: \(binaryCode)")
            getDate(dateStr: binarySnipit)  // 15
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
            hwCode = binToInt(bin: binarySnipit); // 11
            // Extracting Student Code
            binarySnipit = ""
            for index in 0..<9 {binarySnipit.append(binaryCode.character(at: index)!)}
            print("(BinSnip: \(binarySnipit)")
            for _ in 0..<9 {binaryCode.removeFirst()}
            print("LeftBin: \(binaryCode)")
            studentCode = binToInt(bin: binarySnipit); // 9
            // Extracting Student Grade
            binarySnipit = ""
            for index in 0..<14 {binarySnipit.append(binaryCode.character(at: index)!)}
            print("(BinSnip: \(binarySnipit)")
            for _ in 0..<14 {binaryCode.removeFirst()}
            print("LeftBin: \(binaryCode)")
            stuGrade = binToInt(bin: binarySnipit); // 14
            // Extracting Parity
            binarySnipit = ""
            binarySnipit.append(binaryCode.character(at: 0)!)
            print("(BinSnip: \(binarySnipit)")
            binaryCode.removeFirst()
            if (binarySnipit == "1"){parityBit = true}
            else {parityBit = false} // 1
            print("LeftBin: \(binaryCode)")
            // PRINT EXTRACTED VALUES
            print("---------- ENCODED GRADING DATA ----------")
            print("DATE: M:\(month) D:\(day) H:\(hour)")
            print("SHUF: Teach: \(instructorCode)")
            print("HW#: \(hwCode)   STU: \(studentCode)   PAR: \(parityBit)")
            print("------------------------------------------")
        }
        //if (checkFailed == true) {runInvalid()}
    }
    
    // Function gets date data from binary (15)
    func getDate(dateStr: String){
        var binarySnipit: String = ""
        var binaryCode: String = dateStr
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
    }
    
    //------------------ Utilities ------------------//
    
    @IBAction func studentCodeField(_ sender: Any) {studentNumOutlet.resignFirstResponder()}
    
}
