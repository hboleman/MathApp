//
//  Grading.swift
//  MathApp
//
//  Created by Hunter Boleman on 6/25/19.
//  Copyright © 2019 Hunter Boleman. All rights reserved.
//

import UIKit

class GradingPrep: UIViewController {

    //-------------------- Class Setup --------------------//
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //-------------------- Outlets --------------------//
    
    @IBOutlet weak var instructorCodeOutlet: UITextField!
    @IBOutlet weak var homeworkCodeOutlet: UITextField!
    
    //-------------------- Variables --------------------//
    
    var instructorCode: Int = 1234;
    var hwCode: Int = 999
    var checkFailed = false
    
    //-------------------- Actions --------------------//
    
    @IBAction func startGrading(_ sender: Any) {
        checkFailed = false
        ValidationCheck()
        if (checkFailed == false){self.performSegue(withIdentifier: "gradingScreen", sender: self)}
        else {
            invalidDisplay()
        }
    }
    
    //-------------------- Functions --------------------//
    
    func invalidDisplay(){
        
    }
    
    func ValidationCheck(){
        // Teacher code bounds check
        if((instructorCodeOutlet.text?.isEmpty ?? nil)!){ checkFailed = true}
        if((instructorCodeOutlet.text!.count > 4 || instructorCodeOutlet.text!.count < 4) && checkFailed == false){ checkFailed = true }
        if((Int(instructorCodeOutlet.text!)! < 1111 || Int(instructorCodeOutlet.text!)! > 9999) && checkFailed == false){ checkFailed = true }
        // Homework code bounds check
        if((homeworkCodeOutlet.text?.isEmpty ?? nil)!){ checkFailed = true}
        if((homeworkCodeOutlet.text!.count > 3 || homeworkCodeOutlet.text!.count < 1) && checkFailed == false){ checkFailed = true }
        if((Int(homeworkCodeOutlet.text!)! < 1 || Int(homeworkCodeOutlet.text!)! > 999) && checkFailed == false){ checkFailed = true }
    }
    
    //------------------ Utilities ------------------//
    
    @IBAction func teacherCodeField(_ sender: Any) {instructorCodeOutlet.resignFirstResponder()}
    @IBAction func homeworkCodeField(_ sender: Any) {homeworkCodeOutlet.resignFirstResponder()}
    
    
    //------------------ Other Functions ------------------//
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! GradingScreen
        destinationVC.compHwCode = Int(homeworkCodeOutlet.text!)!
        destinationVC.compinstructorCode = Int(instructorCodeOutlet.text!)!
    }
    
}
