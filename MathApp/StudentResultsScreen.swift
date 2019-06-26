//
//  ResultsScreen.swift
//  MathApp
//
//  Created by Hunter Boleman on 6/17/19.
//  Copyright © 2019 Hunter Boleman. All rights reserved.
//

import UIKit

class StudentResultsScreen: UIViewController {
    
    //-------------------- Class Setup --------------------//
    
    @IBOutlet weak var scoreLable: UILabel!
    @IBOutlet weak var resultsCode: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfDefaultsNeedSetup()
        // Do any additional setup after loading the view.
        // Trigger code generation.
        generateCode()
    }
    
    //-------------------- Variables --------------------//
    var instructorCode: Int = 1234;
    var hwCode: Int = 999
    var studentCode: Int = 256
    var parityBit: Bool = false
    var stuGrade: Int = 0;
    var month = "15"
    var day = "63"
    var hour = "31"
    
    var checkFailed = false;
    var assembledBinCode: String = ""
    var codeInHR: String = ""
    var assembledHrCode: String = ""
    var disCodeInBin: String = ""
    var disCodeInHR: String = ""
    let leadingBuffer = 1
    let properBinaryCount = 65
    
    // Debug
    let debugIn: Bool = false
    let debugBinSeperation: Bool = false
    
    //-------------------- Functions --------------------//
    
    // Generate Code
    func generateCode(){
        checkFailed = false
        // If debug is on, create code with this data
        if (debugIn){
            month = "15"
            day = "63"
            hour = "31"
            // Instructor Code
            instructorCode = 0 //32767
            // Will pad homework code
            hwCode = 2047
            // Student Code
            studentCode = 511 //511
            // grade
            stuGrade = 16383
            //parityBit
            parityBit = false
        }
        // Regular Setup
        var gradeIntFirst = Double(stuGrade)
        var gradeValue = gradeIntFirst
        gradeValue = (gradeValue / 100)
        let hrGradeValue = String(format: "%.2f%%", gradeValue)
        // Setup lables
        scoreLable.text = String("\(hrGradeValue)")
        assembleBinaryResultsCode()
        assembleHumanReadableResultsCode(binCode: assembledBinCode)
        resultsCode.text = ("\(assembledHrCode)")
        // Add result info to database
        addScoreToDatabase(score: self.assembledHrCode, grade: String(self.stuGrade), quizNum: String(self.hwCode), teachCode: String(self.instructorCode))
    }
    
    // Get Date in Binary
    func getDate(mo: String, d: String, h: String) -> String{
        var temp: String = ""
        // Month
        let tempMo = padStringInt(num: Int(mo)!, length: 4, padding: "0")
        temp.append(contentsOf: tempMo)
        // Day
        let tempD = padStringInt(num: Int(d)!, length: 6, padding: "0")
        temp.append(contentsOf: tempD)
        // Hour
        let tempH = padStringInt(num: Int(h)!, length: 5, padding: "0")
        temp.append(contentsOf: tempH)
        return temp
    }
    
    //-------------------- Assemble Code --------------------//
    
    // Assemble Binary Code
    func assembleBinaryResultsCode(){
        assembledBinCode = ""
        // FORMATTING DATE
        let date = Date.init()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let _ = format.string(from: date)
        // Calander Setup
        let calendar = Calendar.current
        let tempMonth = calendar.component(.month, from: date)
        let tempDay = calendar.component(.day, from: date)
        let tempHour = calendar.component(.hour, from: date)
        // Getting Relevant Values
        let month = String(tempMonth)
        let day = String(tempDay)
        let hour = String(tempHour)
        // Get other binary values
        let tempDate = getDate(mo: month, d: day, h: hour)
        let teachCode: String = padStringInt( num: instructorCode, length: 15, padding: "0")
        let homewkCode: String = padStringInt( num: hwCode, length: 11, padding: "0")
        let stuCode: String = padStringInt(num: studentCode, length: 9, padding: "0")
        let grade: String = padStringInt(num: stuGrade, length: 8, padding: "0")
        // makes 43
        // Form Together All Binary Values
        var wholeString: String = ""
        if (debugBinSeperation){wholeString.append(contentsOf: " DAT ")} // should be 8
        wholeString.append(contentsOf: tempDate)
        if (debugBinSeperation){wholeString.append(contentsOf: " TEA ")} // should be 8
        wholeString.append(contentsOf: teachCode)
        if (debugBinSeperation){wholeString.append(contentsOf: " HWC ")} // should be 8
        wholeString.append(contentsOf: homewkCode)
        if (debugBinSeperation){wholeString.append(contentsOf: " STU ")} // should be 8
        wholeString.append(contentsOf: stuCode)
        if (debugBinSeperation){wholeString.append(contentsOf: " GRD ")} // should be 8
        wholeString.append(contentsOf: grade)
        // grade: 01100100
        if (debugBinSeperation){wholeString.append(contentsOf: " PAR ")} // should be 8
        // For Parity
        var posCount = 0
        for index in 0..<wholeString.count{if (wholeString.character(at: index)! == "1"){posCount = posCount + 1}}
        let posMod = posCount % 2
        if (posMod != 0){parityBit = true}
        else {parityBit = false}
        var parityValue: String = ""
        if (parityBit){parityValue = "1"}
        else{parityValue = "0"}
        // End Parity
        wholeString.append(contentsOf: parityValue)
        // Print Related Info
        print("Whole String: \(wholeString)")
        print("Count: \(wholeString.count)")
        assembledBinCode = wholeString
    }
    
    // Assemble Human Readable Code
    func assembleHumanReadableResultsCode(binCode: String){
        var formingFullString = ""
        var codeToCrunch = binCode
        var strOfSix = ""
        
        while (codeToCrunch.count > 0) {
            // Get code snippit
            if (codeToCrunch.count > 6){
                strOfSix = ""
                for index in 0..<6 {strOfSix.append(codeToCrunch.character(at: index)!)}
                print(codeToCrunch)
                for _ in 0..<6 {codeToCrunch.removeFirst()}
                print(codeToCrunch)
                print("of6: \(strOfSix)")
            }
            else {
                strOfSix = ""
                for index in 0..<codeToCrunch.count {strOfSix.append(codeToCrunch.character(at: index)!)}
                print(codeToCrunch)
                for _ in 0..<codeToCrunch.count {codeToCrunch.removeFirst()}
                print(codeToCrunch)
                print("ofX: \(strOfSix)")
            }
            // Convert snippit to code charactrer
            let codeCharacter = codeConversionBinToChar(str: strOfSix)
            formingFullString.append(contentsOf: codeCharacter)
            print("HR: \(codeCharacter)")
        }
        // Print and Assign Full Coded Value
        print("FULL CODE: \(formingFullString)")
        assembledHrCode = formingFullString
    }
}
