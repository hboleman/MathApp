//
//  Teaching.swift
//  MathApp
//
//  Created by Hunter Boleman on 2/20/19.
//  Copyright © 2019 Hunter Boleman. All rights reserved.
//

import UIKit
import Foundation

// This class controls the Teaching View Controler
class Teacher: UIViewController {
    
    //-------------------- Class Setup --------------------//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfDefaultsNeedSetup()
    }
    
    //-------------------- Outlets --------------------//
    
    @IBOutlet weak var addQuestionNum: UITextField!
    @IBOutlet weak var subQuestionNum: UITextField!
    @IBOutlet weak var divQuestionNum: UITextField!
    @IBOutlet weak var mulQuestionNum: UITextField!
    
    @IBOutlet weak var segAdd: UISegmentedControl!
    @IBOutlet weak var segSub: UISegmentedControl!
    @IBOutlet weak var segMul: UISegmentedControl!
    @IBOutlet weak var segDiv: UISegmentedControl!
    
    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    @IBOutlet weak var shuffleToggle: UISwitch!
    @IBOutlet weak var teacherCode: UITextField!
    @IBOutlet weak var homeworkCode: UITextField!
    @IBOutlet weak var codeLable: UILabel!
    
    //-------------------- Variables --------------------//
    
    // Variables for generating code
    var numOfQuestions_add: Int = 1;
    var numOfQuestions_sub: Int = 1;
    var numOfQuestions_mul: Int = 1;
    var numOfQuestions_div: Int = 1;
    
    var difficulty_add: Int = 1;
    var difficulty_sub: Int = 1;
    var difficulty_mul: Int = 1;
    var difficulty_div: Int = 1;
    
    var year: String = "25"
    var month: String = "12"
    var day: String = "31"
    var hour: String = "24"
    var min: String = "60"
    
    var shuffle: Bool = false;
    var instructorCode: Int = 1234;
    var hwCode: Int = 999
    var studentCode: Int = 256
    var parityBit: Bool = false
    
    // Variables needed for code creation logic
    var checkFailed = false;
    var assembledBinCode: String = ""
    var codeInHR: String = ""
    var assembledHrCode: String = ""
    var disCodeInBin: String = ""
    var disCodeInHR: String = ""
    let leadingBuffer = 3
    let properBinaryCount = 105
    
    // DEBUG
    let debugIn: Bool = false
    let debugBinSeperation: Bool = false
    
    //-------------------- Actions --------------------//
    
    // Will validate input, and if valid will gather the raw data needed to create code, and call on the functions that assemble the code
    @IBAction func generateCode(_ sender: Any) {
        // Resets the invalid data flag
        checkFailed = false
        // Validates input, unless in debug mode
        if (debugIn == false){checkForValidInput()}
        
        // Assign raw data if inputs are valid
        if (checkFailed == false){
            codeLable.textColor = UIColor(red:0.56, green:0.81, blue:0.48, alpha:1.0);
            if (debugIn == false){
            
            // If input valid, set variabels from input
            numOfQuestions_add = Int(addQuestionNum.text!)!
            numOfQuestions_sub = Int(subQuestionNum.text!)!
            numOfQuestions_mul = Int(mulQuestionNum.text!)!
            numOfQuestions_div = Int(divQuestionNum.text!)!
            
            let arrInt: [Int] = [1, 2, 3]
            difficulty_add = arrInt[segAdd.selectedSegmentIndex]
            difficulty_sub = arrInt[segSub.selectedSegmentIndex]
            difficulty_mul = arrInt[segMul.selectedSegmentIndex]
            difficulty_div = arrInt[segDiv.selectedSegmentIndex]
            
            // Logic for date formatting
            let date = datePickerOutlet.date
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
            // Assign temp date components to assosiated variables
            year = String(tempYear)
            month = String(tempMonth)
            day = String(tempDay)
            hour = String(tempHour)
            min = String(tempMin)
            // Format the year for two digits
            if (Int(year)! > 2000){ year = String(Int(year)! - 2000)}
            
            // Assign Remaining Variables
            shuffle = shuffleToggle.isOn
            instructorCode = Int(teacherCode.text!)!
            hwCode = Int(homeworkCode.text!)!
            studentCode = 123
            }
            // If Debugging, assign data with predetermined patterns
            else if (debugIn){
                // 11111111 : 255 or 0
                numOfQuestions_add = 255
                numOfQuestions_sub = 0
                numOfQuestions_mul = 255
                numOfQuestions_div = 0
                // 11 : 3 or 0
                difficulty_add = 3
                difficulty_sub = 0
                difficulty_mul = 3
                difficulty_div = 0
                // FORMATTING DATE
                // y:1111111 m:1111 d:111111 h:11111 m: 111111
                year = "127"
                month = "15"
                day = "63"
                hour = "31"
                min = "63"
                // Shuffle
                shuffle = false
                // Instructor Code
                instructorCode = 32767
                // Will pad homework code
                hwCode = 0
                // Student Code
                studentCode = 511
                //parityBit
                parityBit = false
            }
            
            // If data has been assigned, and input is valid, call on the functions to generate the code
            if (checkFailed == false){
                assembleBinaryCode()
                assembleHumanReadableCode(binCode: assembledBinCode)
                codeLable.text = assembledHrCode
            }
        }
        else{
            // If check failed, display invalid option
            codeLable.text = "Invalid Option!"
            codeLable.textColor = UIColor(red:0.89, green:0.44, blue:0.31, alpha:1.0)
        }
    }
    
    // Checks inputed values for validity
    func checkForValidInput(){
        //checks that number of questions has a valud number
        if((addQuestionNum.text?.isEmpty ?? nil)!){ checkFailed = true }
        if((subQuestionNum.text?.isEmpty ?? nil)!){ checkFailed = true }
        if((mulQuestionNum.text?.isEmpty ?? nil)!){ checkFailed = true }
        if((divQuestionNum.text?.isEmpty ?? nil)!){ checkFailed = true }
        // checks if number of questions are within bounds
        if(checkFailed == false && Int(addQuestionNum.text!)! >= 0 && Int(addQuestionNum.text!)! > 255){ checkFailed = true }
        if(checkFailed == false && Int(subQuestionNum.text!)! >= 0 && Int(addQuestionNum.text!)! > 255){ checkFailed = true }
        if(checkFailed == false && Int(mulQuestionNum.text!)! >= 0 && Int(addQuestionNum.text!)! > 255){ checkFailed = true }
        if(checkFailed == false && Int(divQuestionNum.text!)! >= 0 && Int(addQuestionNum.text!)! > 255){ checkFailed = true }
        // checks that there is at least one question
        if (checkFailed == false){
            var total = 0
            total = Int(addQuestionNum.text!)!
            total = total + Int(subQuestionNum.text!)!
            total = total + Int(mulQuestionNum.text!)!
            total = total + Int(divQuestionNum.text!)!
            if (total < 1){checkFailed = true}
        }
        // Teacher code bounds check
        if((teacherCode.text?.isEmpty ?? nil)!){ checkFailed = true}
        if((teacherCode.text!.count > 4 || teacherCode.text!.count < 4) && checkFailed == false){ checkFailed = true }
        if((Int(teacherCode.text!)! < 1111 || Int(teacherCode.text!)! > 9999) && checkFailed == false){ checkFailed = true }
        // Homework code bounds check
        if((homeworkCode.text?.isEmpty ?? nil)!){ checkFailed = true}
        if((homeworkCode.text!.count > 3 || homeworkCode.text!.count < 0) && checkFailed == false){ checkFailed = true }
        if((Int(homeworkCode.text!)! < 1 || Int(homeworkCode.text!)! > 999) && checkFailed == false){ checkFailed = true }
    }
    
    // Create the binary representation of the input data
    func assembleBinaryCode(){
        // Take raw data and pad it to specification
        // Should have 105 characters, (date is 28)
        let addNum: String = padStringInt(num: numOfQuestions_add, length: 8, padding: "0")
        let subNum: String = padStringInt(num: numOfQuestions_sub, length: 8, padding: "0")
        let mulNum: String = padStringInt(num: numOfQuestions_mul, length: 8, padding: "0")
        let divNum: String = padStringInt(num: numOfQuestions_div, length: 8, padding: "0")
        let addDiff: String = padStringInt(num: difficulty_add, length: 2, padding: "0")
        let subDiff: String = padStringInt(num: difficulty_sub, length: 2, padding: "0")
        let mulDiff: String = padStringInt(num: difficulty_mul, length: 2, padding: "0")
        let divDiff: String = padStringInt(num: difficulty_div, length: 2, padding: "0")
        let date = getDate(yr: year, mo: month, d: day, h: hour, m: min)
        // For Shuffle
        var sh: String = ""
        if (shuffle){sh = "1"}
        else{sh = "0"}
        // After Shuffle
        let teachCode: String = padStringInt( num: instructorCode, length: 15, padding: "0")
        let homewkCode: String = padStringInt( num: hwCode, length: 11, padding: "0")
        let stuCode: String = padStringInt(num: studentCode, length: 9, padding: "0")
        // Take padded and converted data and append them in order with our string.
        // Debug mode interts breaks inbetween the binary to make it easier to read the sections.
        var wholeString: String = ""
        if (debugBinSeperation){wholeString.append(contentsOf: " NUM ")} // should be 32
        wholeString.append(contentsOf: addNum)
        wholeString.append(contentsOf: subNum)
        wholeString.append(contentsOf: mulNum)
        wholeString.append(contentsOf: divNum)
        if (debugBinSeperation){wholeString.append(contentsOf: " DIF ")} // should be 8
        wholeString.append(contentsOf: addDiff)
        wholeString.append(contentsOf: subDiff)
        wholeString.append(contentsOf: mulDiff)
        wholeString.append(contentsOf: divDiff)
        if (debugBinSeperation){wholeString.append(contentsOf: " DAT ")}
        wholeString.append(contentsOf: date)
        if (debugBinSeperation){wholeString.append(contentsOf: " SHF ")}
        wholeString.append(contentsOf: sh)
        if (debugBinSeperation){wholeString.append(contentsOf: " TEA ")}
        wholeString.append(contentsOf: teachCode)
        if (debugBinSeperation){wholeString.append(contentsOf: " HWC ")}
        wholeString.append(contentsOf: homewkCode)
        if (debugBinSeperation){wholeString.append(contentsOf: " STU ")}
        wholeString.append(contentsOf: stuCode)
        // Logic for parity bit - even parity
        var posCount = 0
        for index in 0..<wholeString.count{
            if (wholeString.character(at: index)! == "1"){posCount = posCount + 1}
        }
        if (debugIn == false){
        let posMod = posCount % 2
        if (posMod != 0){parityBit = true}
        else {parityBit = false}
        }
        var parityValue: String = ""
        if (parityBit){parityValue = "1"}
        else{parityValue = "0"}
        if (debugBinSeperation){wholeString.append(contentsOf: " PAR ")}
        wholeString.append(contentsOf: parityValue)
        // End parity logic
        
        // Extra consol info
        print("Whole String: \(wholeString)")
        print("Count: \(wholeString.count)")
        // Assign the bin code value
        assembledBinCode = wholeString
    }
    
    // Create the human readable code representation of the input data using custom code mapping
    func assembleHumanReadableCode(binCode: String){
        // String will be used to append data to
        var formingStr = ""
        // Copies our binary data to a temporary string
        var codeToCrunch = binCode
        // Resets the chunk value
        var strOfSix = ""
        
        // While string contains anything, take chunks of 6 binary digits
        //    and convert to custom code map, then append to string.
        while (codeToCrunch.count > 0) {
            if (codeToCrunch.count > 6){
                // Take a chunk of six characters and remove them from the whole binary string.
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
                // Pad whatever chunks are left to six characters and remove them from the whole binary string.
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
            // Convert chunk to a mapped code character, append to string
            let codeCharacter = codeConversionBinToChar(str: strOfSix)
            formingStr.append(contentsOf: codeCharacter)
            print("HR: \(codeCharacter)")
        }
        // Assign final code to it's variable
        print("FULL CODE: \(formingStr)")
        assembledHrCode = formingStr
    }
    
    // Prepares a binary blob constructed to our code specification for the date portion.
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
    
    //------------------ Utilities ------------------//
    
    // Allows the enter key to dismiss the keyboard
    @IBAction func addMessageFieldPrimaryAction(_ sender: Any) {addQuestionNum.resignFirstResponder()}
    @IBAction func subMessageFieldPrimaryAction(_ sender: Any) {subQuestionNum.resignFirstResponder()}
    @IBAction func mulMessageFieldPrimaryAction(_ sender: Any) {mulQuestionNum.resignFirstResponder()}
    @IBAction func divMessageFieldPrimaryAction(_ sender: Any) {divQuestionNum.resignFirstResponder()}
    @IBAction func teachMessageFieldPrimaryAction(_ sender: Any) {teacherCode.resignFirstResponder()}
    @IBAction func hwMessageFieldPrimaryAction(_ sender: Any) {homeworkCode.resignFirstResponder()}
}
