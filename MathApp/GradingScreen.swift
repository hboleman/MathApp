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
    
    //-------------------- Actions --------------------//
    
    @IBAction func runCode(_ sender: Any) {
        
    }
    

}
