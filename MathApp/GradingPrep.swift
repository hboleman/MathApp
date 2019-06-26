//
//  Grading.swift
//  MathApp
//
//  Created by Hunter Boleman on 6/25/19.
//  Copyright © 2019 Hunter Boleman. All rights reserved.
//

import UIKit

class GradingPrep: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var instructorCodeOutlet: UITextField!
    @IBOutlet weak var homeworkCodeOutlet: UITextField!
    
    var instructorCode: Int = 1234;
    var hwCode: Int = 999
    var checkFailed = false
    
    @IBAction func startGrading(_ sender: Any) {
        checkFailed = false
        if (checkFailed == false){self.performSegue(withIdentifier: "gradingScreen", sender: self)}
        else {
            
        }
    }
    
    func ValidationCheck(){
        // Teacher code bounds check
        if((instructorCodeOutlet.text?.isEmpty ?? nil)!){ checkFailed = true}
        if((instructorCodeOutlet.text!.count > 4 || instructorCodeOutlet.text!.count < 4) && checkFailed == false){ checkFailed = true }
        if((Int(instructorCodeOutlet.text!)! < 1111 || Int(instructorCodeOutlet.text!)! > 9999) && checkFailed == false){ checkFailed = true }
        // Homework code bounds check
        if((homeworkCodeOutlet.text?.isEmpty ?? nil)!){ checkFailed = true}
        if((homeworkCodeOutlet.text!.count > 3 || homeworkCodeOutlet.text!.count < 0) && checkFailed == false){ checkFailed = true }
        if((Int(homeworkCodeOutlet.text!)! < 1 || Int(homeworkCodeOutlet.text!)! > 999) && checkFailed == false){ checkFailed = true }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! GradingScreen
        destinationVC.hwCode = Int(homeworkCodeOutlet.text!)!
        destinationVC.instructorCode = Int(instructorCodeOutlet.text!)!
    }
    
}
