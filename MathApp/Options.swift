//
//  Options.swift
//  MathApp
//
//  Created by Hunter Boleman on 2/20/19.
//  Copyright © 2019 Hunter Boleman. All rights reserved.
//

import UIKit

// This class controls the options view controler
class Options: UIViewController {
    
    //-------------------- Class Setup --------------------//
    
    // Populate local variables with UserData information
    var mode_difficulty: Int = 0;
    var modesActive: [Bool] = Array(repeating: false, count: 4)
    var questionCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfDefaultsNeedSetup()
        // Populate local variables with UserData information
        mode_difficulty = defaults.integer(forKey: "mode_difficulty");
        modesActive = defaults.array(forKey: "modesActive") as! [Bool]
        questionCount = defaults.integer(forKey: "questionCount")
        numberLable.text = String(questionCount)
        
        // Makes the options reflect the current set value
        color_plus()
        color_minus()
        color_multiply()
        color_divide()
        if (mode_difficulty == 1){color_easy()}
        else if (mode_difficulty == 2){color_medium()}
        else if (mode_difficulty == 3){color_hard()}
    }
    
    func save_defaults(){
        defaults.set(mode_difficulty, forKey: "mode_difficulty");
        defaults.set(modesActive, forKey: "modesActive")
        defaults.set(questionCount, forKey: "questionCount")
        defaults.synchronize();
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("VC:ViewWillDis");
        save_defaults();
    }
    
    //-------------------- Outlets --------------------//
    
    @IBOutlet weak var out_plus: UIButton!
    @IBOutlet weak var out_minus: UIButton!
    @IBOutlet weak var out_multiply: UIButton!
    @IBOutlet weak var out_divide: UIButton!
    @IBOutlet weak var out_easy: UIButton!
    @IBOutlet weak var out_medium: UIButton!
    @IBOutlet weak var out_hard: UIButton!
    @IBOutlet weak var numberLable: UILabel!
    
    // Local Vars
    let min = 1
    let max = 20
    
    //-------------------- Actions --------------------//
    
    // Button for Mode
    @IBAction func btn_mode_plus(_ sender: Any) {
        if (notLast(index: 0)) {
            if (modesActive[0] == true) {modesActive[0] = false}
            else {modesActive[0] = true}
            color_plus();
        }
    }
    @IBAction func btn_mode_minus(_ sender: Any) {
        if (notLast(index: 1)) {
            if (modesActive[1] == true) {modesActive[1] = false}
            else {modesActive[1] = true}
            color_minus();
        }
    }
    @IBAction func btn_mode_multiply(_ sender: Any) {
        if (notLast(index: 2)) {
            if (modesActive[2] == true) {modesActive[2] = false}
            else {modesActive[2] = true}
            color_multiply();
        }
    }
    @IBAction func btn_mode_divide(_ sender: Any) {
        if (notLast(index: 3)) {
            if (modesActive[3] == true) {modesActive[3] = false}
            else {modesActive[3] = true}
            color_divide();
        }
    }
    
    // Buttons Difficulty
    @IBAction func btn_easy(_ sender: Any) {
        mode_difficulty = 1;
        color_easy();
    }
    @IBAction func btn_medium(_ sender: Any) {
        mode_difficulty = 2;
        color_medium();
    }
    @IBAction func btn_hard(_ sender: Any) {
        mode_difficulty = 3;
        color_hard();
    }
    
    //-------------------- Actions - Color --------------------//
    
    // Color Change for Mode
    func color_plus(){
        if (modesActive[0] == true){ out_plus.setTitleColor(UIColor(red:0.89, green:0.44, blue:0.31, alpha:1.0), for: .normal)}
        else {out_plus.setTitleColor(UIColor(red:0.19, green:0.62, blue:0.79, alpha:1.0), for: .normal)}
    }
    func color_minus(){
        if (modesActive[1] == true){ out_minus.setTitleColor(UIColor(red:0.89, green:0.44, blue:0.31, alpha:1.0), for: .normal)}
        else {out_minus.setTitleColor(UIColor(red:0.19, green:0.62, blue:0.79, alpha:1.0), for: .normal)}
    }
    func color_multiply(){
        if (modesActive[2] == true){ out_multiply.setTitleColor(UIColor(red:0.89, green:0.44, blue:0.31, alpha:1.0), for: .normal)}
        else {out_multiply.setTitleColor(UIColor(red:0.19, green:0.62, blue:0.79, alpha:1.0), for: .normal)}
    }
    func color_divide(){
        if (modesActive[3] == true){ out_divide.setTitleColor(UIColor(red:0.89, green:0.44, blue:0.31, alpha:1.0), for: .normal)}
        else {out_divide.setTitleColor(UIColor(red:0.19, green:0.62, blue:0.79, alpha:1.0), for: .normal)}
    }
    
    
    // Color Change for Difficulty
    func color_easy(){
        out_easy.setTitleColor(UIColor(red:0.89, green:0.44, blue:0.31, alpha:1.0), for: .normal)
        out_medium.setTitleColor(UIColor(red:0.19, green:0.62, blue:0.79, alpha:1.0), for: .normal)
        out_hard.setTitleColor(UIColor(red:0.19, green:0.62, blue:0.79, alpha:1.0), for: .normal)
    }
    func color_medium(){
        out_easy.setTitleColor(UIColor(red:0.19, green:0.62, blue:0.79, alpha:1.0), for: .normal)
        out_medium.setTitleColor(UIColor(red:0.89, green:0.44, blue:0.31, alpha:1.0), for: .normal)
        out_hard.setTitleColor(UIColor(red:0.19, green:0.62, blue:0.79, alpha:1.0), for: .normal)
    }
    func color_hard(){
        out_easy.setTitleColor(UIColor(red:0.19, green:0.62, blue:0.79, alpha:1.0), for: .normal)
        out_medium.setTitleColor(UIColor(red:0.19, green:0.62, blue:0.79, alpha:1.0), for: .normal)
        out_hard.setTitleColor(UIColor(red:0.89, green:0.44, blue:0.31, alpha:1.0), for: .normal)
    }
    
    //-------------------- Other Functions --------------------//
    
    // Used to prevent all the options from being unchecked
    func notLast(index: Int) -> Bool {
        // For enabling
        if (modesActive[index] == false){return true}
        // For disabling
        var count = 0
        for index in 0..<modesActive.count{if (modesActive[index] == true){count = count + 1}}
        if (count > 1 && modesActive[index] == true){return true}
        else {return false}
    }
    
    //-------------------- Action - Incremental --------------------//
    
    @IBAction func decrimentButton(_ sender: Any) {
        if ((questionCount - 1) <= max && (questionCount - 1) >= min){
            questionCount = questionCount - 1
            numberLable.text = String(questionCount)
        }
    }
    
    @IBAction func incrementButton(_ sender: Any) {
        if ((questionCount + 1) <= max && (questionCount + 1) >= min){
            questionCount = questionCount + 1
            numberLable.text = String(questionCount)
        }
    }
}
