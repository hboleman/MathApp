//
//  PastGradesVC.swift
//  MathApp
//
//  Created by Hunter Boleman on 6/25/19.
//  Copyright © 2019 Hunter Boleman. All rights reserved.
//

import UIKit

class PastGradesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        readInDB()
        maxStat = scoreArr.count
        updateDisplay()
    }
    
    @IBOutlet weak var scoreOutlet: UILabel!
    @IBOutlet weak var resultsCodeOutlet: UILabel!
    @IBOutlet weak var quizNumOutlet: UILabel!
    @IBOutlet weak var pastQuizNum: UILabel!
    
    var currStat = 1
    var maxStat = 0
    var tempStr = ""
    let min = 1
    
    
    @IBAction func minus(_ sender: Any) {
        if ((currStat - 1) <= maxStat && (currStat - 1) >= min){
            currStat = currStat - 1
            updateDisplay()
        }
    }
    
    @IBAction func plus(_ sender: Any) {
        if ((currStat + 1) <= maxStat && (currStat + 1) >= min){
            currStat = currStat + 1
            updateDisplay()
        }
    }
    
    func updateDisplay(){
        // Score Code
        resultsCodeOutlet.text = scoreArr[(currStat - 1)]
        // Grade Value
        let gradeIntFirst = Double(gradeArr[(currStat - 1)])
        let gradeValue = (gradeIntFirst! / 100)
        scoreOutlet.text = String(format: "%.2f%%", gradeValue)
        // Quiz Num
        tempStr = quizIDArr[(currStat - 1)]
        for _ in 0..<4 {
            tempStr.removeFirst()
        }
        quizNumOutlet.text = tempStr
        // Past Quiz Num
        pastQuizNum.text = ("\(currStat)/\(maxStat)")
    }
}
