//
//  RegularResultsScreen.swift
//  MathApp
//
//  Created by Hunter Boleman on 6/25/19.
//  Copyright © 2019 Hunter Boleman. All rights reserved.
//

import UIKit

class RegularResultsScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DisplayResults()
    }
    
    //-------------------- Variables --------------------//
    
    var stuGrade: Int = 0;
    
    //-------------------- Outputs --------------------//
    
    @IBOutlet weak var scoreLable: UILabel!
    
    //-------------------- Function --------------------//
    
    // Generate Code
    func DisplayResults(){
        // Regular Setup
        let gradeIntFirst = Double(stuGrade)
        var gradeValue = gradeIntFirst
        gradeValue = (gradeValue / 100)
        let hrGradeValue = String(format: "%.2f%%", gradeValue)
        // Setup lables
        scoreLable.text = String("\(hrGradeValue)")
    }

}
