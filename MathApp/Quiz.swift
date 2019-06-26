//
//  Quiz.swift
//  MathApp
//
//  Created by Hunter Boleman on 2/20/19.
//  Copyright © 2019 Hunter Boleman. All rights reserved.
//

import UIKit
import GameplayKit

// This class controls the quiz view controler
class Quiz: UIViewController {
    
    //-------------------- Class Setup --------------------//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfDefaultsNeedSetup()
        if (homeworkQuiz == false){
            // Populate local variables with UserData information
            num1 = defaults.integer(forKey: "num1");
            num2 = defaults.integer(forKey: "num2");
            numAns = defaults.integer(forKey: "numAns");
            temp1 = defaults.integer(forKey: "temp1");
            temp2 = defaults.integer(forKey: "temp2");
            place = defaults.integer(forKey: "place");
            user_num = defaults.integer(forKey: "user_num");
            score_right = defaults.integer(forKey: "score_right");
            score_wrong = defaults.integer(forKey: "score_wrong");
            score_Qcurrent = defaults.integer(forKey: "score_Qcurrent");
            score_Qmax = defaults.integer(forKey: "score_Qmax");
            canTouch = defaults.bool(forKey: "canTouch");
            mode_difficulty = defaults.integer(forKey: "mode_difficulty");
            // Newer variables
            modesActive = defaults.array(forKey: "modesActive") as! [Bool]
            questionCount = defaults.integer(forKey: "questionCount")
            shuffle = defaults.bool(forKey: "shuffle")
        }
        if (debugSendToResults == false){start()}
    }
    
    func save_defaults(){
        if (homeworkQuiz == false){
            defaults.set(num1, forKey: "num1");
            defaults.set(num2, forKey: "num2");
            defaults.set(numAns, forKey: "numAns");
            defaults.set(temp1, forKey: "temp1");
            defaults.set(temp2, forKey: "temp2");
            defaults.set(place, forKey: "place");
            defaults.set(user_num, forKey: "user_num");
            defaults.set(score_right, forKey: "score_right");
            defaults.set(score_wrong, forKey: "score_wrong");
            defaults.set(score_Qcurrent, forKey: "score_Qcurrent");
            defaults.set(score_Qmax, forKey: "score_Qmax");
            defaults.set(canTouch, forKey: "canTouch");
            defaults.set(mode_difficulty, forKey: "mode_difficulty");
            // Newer Variables
            defaults.set(modesActive, forKey: "modesActive")
            defaults.set(shuffle, forKey: "shuffle")
            // Sync
            defaults.synchronize();
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("VC:ViewWillDis");
        save_defaults();
    }
    
    //-------------------- Outlets --------------------//
    
    // Lables Outlets
    @IBOutlet weak var lbl_top: UILabel!
    @IBOutlet weak var lbl_bottom: UILabel!
    @IBOutlet weak var lbl_answer: UILabel!
    @IBOutlet weak var lbl_symbol: UILabel!
    @IBOutlet weak var lbl_right: UILabel!
    @IBOutlet weak var lbl_wrong: UILabel!
    @IBOutlet weak var lbl_polarity: UILabel!
    
    // Progress View Outlets
    @IBOutlet weak var progviewquiz: UIProgressView!
    
    // Outlets
    @IBOutlet weak var out_nextquestion: UIButton!
    
    //-------------------- Variables --------------------//
    // Quiz Vars
    var num1: Int = 0;
    var num2: Int = 0;
    var numAns: Int = 0;
    var temp1: Int = 0;
    var temp2: Int = 0;
    var place: Int = 0;
    var user_num: Int = 0;
    var score_right: Int = 0;
    var score_wrong: Int = 0;
    var score_Qcurrent: Int = 0;
    var score_Qmax: Int = 0;
    var canTouch: Bool = true;
    var mode_symbol: Int = 0;
    var mode_difficulty: Int = 0;
    // HW Vars
    var modesActive: [Bool] = Array(repeating: false, count: 4)
    var questionCount: Int = 0;
    var questionsArray: [Int] = Array.init()
    var hwArray: [(question: Int, difficulty: Int)] = []
    var shuffle: Bool = false
    // Rand Vars
    var seed: UInt64 = 0
    var generator = SeededGenerator()
    var doSegue: Bool = false
    // Needed for resutls & student quiz
    var instructorCode: Int = 1234;
    var hwCode: Int = 999
    var studentCode: Int = 256
    var stuGrade: Int = 0;
    var homeworkQuiz: Bool = false
    //DEBUG - When enabled, just press next to move to results screen.
    var debugSendToResults: Bool = true
    
    //-------------------- Numpad Actions --------------------//
    
    // ZERO
    @IBAction func btn_zero(_ sender: Any) {if (canTouch == true){user_num = user_num * 10; place = place + 1; lbl_answer.text = String(user_num);}}
    // ONE
    @IBAction func btn_one(_ sender: Any) {if (canTouch == true){let ins_num: Int = 1; user_num = (user_num * 10) + ins_num; place = place + 1; lbl_answer.text = String(user_num);}}
    // TWO
    @IBAction func btn_two(_ sender: Any) {if (canTouch == true){let ins_num: Int = 2; user_num = (user_num * 10) + ins_num; place = place + 1; lbl_answer.text = String(user_num);}}
    // THREE
    @IBAction func btn_three(_ sender: Any) {if (canTouch == true){ let ins_num: Int = 3; user_num = (user_num * 10) + ins_num; place = place + 1; lbl_answer.text = String(user_num);}}
    // FOUR
    @IBAction func btn_four(_ sender: Any) {if (canTouch == true){let ins_num: Int = 4; user_num = (user_num * 10) + ins_num; place = place + 1; lbl_answer.text = String(user_num);}}
    // FIVE
    @IBAction func btn_five(_ sender: Any) {if (canTouch == true){let ins_num: Int = 5; user_num = (user_num * 10) + ins_num; place = place + 1;lbl_answer.text = String(user_num);}}
    // SIX
    @IBAction func btn_six(_ sender: Any) {if (canTouch == true){ let ins_num: Int = 6; user_num = (user_num * 10) + ins_num; place = place + 1; lbl_answer.text = String(user_num);}}
    // SEVEN
    @IBAction func btn_seven(_ sender: Any) {if (canTouch == true){ let ins_num: Int = 7; user_num = (user_num * 10) + ins_num; place = place + 1; lbl_answer.text = String(user_num);}}
    // EIGHT
    @IBAction func btn_eight(_ sender: Any) {if (canTouch == true){ let ins_num: Int = 8; user_num = (user_num * 10) + ins_num; place = place + 1; lbl_answer.text = String(user_num);}}
    // NINE
    @IBAction func btn_nine(_ sender: Any) {if (canTouch == true){let ins_num: Int = 9; user_num = (user_num * 10) + ins_num; place = place + 1; lbl_answer.text = String(user_num);}}
    // CLEAR
    @IBAction func btn_clear(_ sender: Any) {if (canTouch == true){ place = 1; user_num = 0; lbl_answer.text = String(user_num);}}
    
    //-------------------- Actions --------------------//
    
    // Processes answer and question to determine corectness
    @IBAction func btn_enter(_ sender: Any) {
        if (canTouch == true){
            //lbl_polarity.isHidden = false;
            // For negative
            if (lbl_polarity.isHidden == false){
                user_num = user_num * -1;
                if (user_num == numAns){
                    lbl_answer.text = "CORRECT!";
                    canTouch = false;
                    score(right: 1, wrong: 0, question: 1);
                }
                if (user_num != numAns){
                    lbl_answer.text = "WRONG!";
                    canTouch = false;
                    score(right: 0, wrong: 1, question: 1);
                }
            }
                // For non-negative
            else if (lbl_polarity.isHidden == true){
                if (user_num == numAns){
                    lbl_answer.text = "CORRECT!";
                    canTouch = false;
                    score(right: 1, wrong: 0, question: 1);
                }
                if (user_num != numAns){
                    lbl_answer.text = "WRONG!";
                    canTouch = false;
                    score(right: 0, wrong: 1, question: 1);
                }
            }
            // Extra setup
            lbl_polarity.isHidden = true;
            place = 1;
            user_num = 0;
            out_nextquestion.isHidden = false;
        }
    }
    
    // Changes the polarity of the users answer
    @IBAction func btn_polarity(_ sender: Any) {
        if (lbl_polarity.isHidden == true){lbl_polarity.isHidden = false;}
        else {lbl_polarity.isHidden = true;}
    }
    
    // Button that activates next question processes
    @IBAction func btn_nextQuestion(_ sender: Any) {if (debugSendToResults == false){NextQuestion()} ; if (debugSendToResults){doSegue = true} ; segueCheck()}
    
    
    //-------------------- Other Functions --------------------//
    
    // Checks if doSegue is true, if so, segue to results screen
    func segueCheck(){if (doSegue){self.performSegue(withIdentifier: "resultsScreenSegue", sender: self)}}
    
    // Function sets gets everything setup for a new quiz.
    func start(){
        if (homeworkQuiz == false){
            // Section for making array for which questions to run
            if (modesActive[0] == true){for _ in 0..<questionCount {questionsArray.append(1)}}
            if (modesActive[1] == true){for _ in 0..<questionCount {questionsArray.append(2)}}
            if (modesActive[2] == true){for _ in 0..<questionCount {questionsArray.append(3)}}
            if (modesActive[3] == true){for _ in 0..<questionCount {questionsArray.append(4)}}
            
            // Get proper question count
            var count = 0
            for index in 0..<modesActive.count{if (modesActive[index] == true){count = count + 1}}
            questionCount = questionCount * count
            score_Qmax = questionCount
            
            // Shuffles the array of questions if needed
            if (shuffle){questionsArray.shuffle()}
        }
        else{
            // Student Setup - most of the work was done in the student prepare for segue
            // Reset psudo-random number generator
            generator = SeededGenerator(seed: seed)
        }
        //Regular Quiz Setup
        // Set Variables
        num1 = 0;
        num2 = 0;
        numAns = 0;
        place = 1;
        user_num = 0;
        score_right = 0;
        score_wrong = 0;
        score_Qcurrent = 0;
        canTouch = true;
        out_nextquestion.isHidden = true;
        // Prepares first question
        NextQuestion();
        progviewquiz.progress = Float(0);
    }
    
    // Function used to rotate the question and re-enable touch on the keypad
    func NextQuestion(){
        // Decide Which Question to do
        // Regular Quiz
        if (score_Qcurrent < score_Qmax){
            if (homeworkQuiz == false){
                let tempNum = questionsArray.removeFirst()
                mode_symbol = tempNum
            }
                // Student Quiz
            else {
                let tempNum = hwArray.removeFirst()
                let tempDiff = tempNum.difficulty
                let tempQuestion = tempNum.question
                mode_difficulty = tempDiff
                mode_symbol = tempQuestion
            }
            // Regualr Question Setup
            if (mode_symbol == 1){ // +
                lbl_symbol.text = "+";
                //Easy
                if (mode_difficulty == 1){
                    temp1 = randFunc(min: 1, max: 15)
                    temp2 = randFunc(min: 1, max: 15)
                }
                //Medium
                if (mode_difficulty == 2){
                    temp1 = randFunc(min: 20, max: 99)
                    temp2 = randFunc(min: 1, max: 99)
                }
                //Hard
                if (mode_difficulty == 3){
                    temp1 = randFunc(min: 50, max: 9999)
                    temp2 = randFunc(min: 50, max: 9999)
                }
                num1 = temp1;
                num2 = temp2;
                numAns = num1 + num2;
            }
                
            else if (mode_symbol == 2){ // -
                lbl_symbol.text = "-";
                //Easy
                if (mode_difficulty == 1){
                    temp1 = randFunc(min: 1, max: 15)
                    temp2 = randFunc(min: 1, max: 20)
                }
                //Medium
                if (mode_difficulty == 2){
                    temp1 = randFunc(min: 20, max: 99)
                    temp2 = randFunc(min: 1, max: 130)
                }
                //Hard
                if (mode_difficulty == 3){
                    temp1 = randFunc(min: 50, max: 9999)
                    temp2 = randFunc(min: 50, max: 9999)
                }
                num1 = temp1;
                num2 = temp2;
                numAns = num1 - num2;
            }
                
            else if (mode_symbol == 3){ // X
                lbl_symbol.text = "x";
                //Easy
                if (mode_difficulty == 1){
                    repeat {
                        temp1 = randFunc(min: 1, max: 20)
                        temp2 = randFunc(min: 1, max: 4)
                    } while ((temp1 % temp2) != 0)
                }
                //Medium
                if (mode_difficulty == 2){
                    temp1 = randFunc(min: 10, max: 50)
                    temp2 = randFunc(min: 1, max: 10)
                }
                //Hard
                if (mode_difficulty == 3){
                    temp1 = randFunc(min: 50, max: 9990)
                    temp2 = randFunc(min: 15, max: 9990)
                }
                num1 = temp1;
                num2 = temp2;
                numAns = num1 * num2;
            }
                
            else if (mode_symbol == 4){ // %
                lbl_symbol.text = "%";
                //Easy
                if (mode_difficulty == 1){
                    var tempRnd = 0
                    var retryFlag = false
                    repeat {
                        retryFlag = false
                        temp1 = randFunc(min: 4, max: 20)
                        temp2 = randFunc(min: 1, max: (temp1 / 2))
                        // To have less divide by 1s
                        if (temp1 == 1 || temp2 == 1){
                            tempRnd = randFunc(min: 1, max: 10)
                            if (tempRnd != 5){retryFlag = true}
                        }
                    } while (((temp1 % temp2) != 0) || retryFlag == true)
                }
                //Medium
                if (mode_difficulty == 2){
                    repeat {
                        temp1 = randFunc(min: 10, max: 100)
                        temp2 = randFunc(min: 1, max: (temp1 / 2))
                    } while ((temp1 % temp2) != 0)
                }
                //Hard
                if (mode_difficulty == 3){
                    repeat {
                        temp1 = randFunc(min: 50, max: 9999)
                        temp2 = randFunc(min: 1, max: (temp1 / 2))
                    } while ((temp1 % temp2) != 0)
                }
                num1 = temp1;
                num2 = temp2;
                numAns = num1 / num2;
            }
            // Transfer new numbers to lables
            lbl_top.text = String(num1);
            lbl_bottom.text = String(num2);
            lbl_answer.text = "";
            // Set place value to 1 which allows an entered number to be in the correct number column.
            place = 1;
            // Holds the value for the number the user sees.
            user_num = 0;
            // Hide the "Next Question" button until question is answered.
            out_nextquestion.isHidden = true;
            // Allows the keypad to be enabled again.
            canTouch = true;
        }
        // End condition triggers when question has reached the max allowed.
        if (score_Qcurrent >= score_Qmax) {
            canTouch = false;
            lbl_top.text = ""
            lbl_bottom.text = "";
            lbl_answer.text = "DONE!";
            lbl_symbol.text = "";
            // If this is a student quiz, segue to results.
            if(homeworkQuiz){
                doSegue = true
            }
        }
    }
    
    // Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Regular segue
        if (debugSendToResults == false && homeworkQuiz == true && doSegue){
            // Create a new variable to store the instance of Quiz
            let destinationVC = segue.destination as! ResultsScreen
            // Set other data needed for results
            destinationVC.instructorCode = self.instructorCode
            destinationVC.hwCode = self.hwCode
            destinationVC.studentCode = self.studentCode
            // Create Grade
            self.stuGrade = Int(Double(score_right / score_Qmax) * 10000)
            destinationVC.stuGrade = self.stuGrade
            // Setup lables
            //destinationVC.scoreLable.text = String(self.stuGrade)
        }
            // Debug segue
        else if (debugSendToResults == true && doSegue){
            // Create a new variable to store the instance of Quiz
            let destinationVC = segue.destination as! ResultsScreen
            // Set other data needed for results
            destinationVC.instructorCode = 1234
            destinationVC.hwCode = 0
            destinationVC.studentCode = 511
            // Create Testing Grade
            score_right = 2
            score_Qmax = 11
            let rightDouble = Double(score_right)
            let maxDouble = Double(score_Qmax)
            let tempGrade = Double(rightDouble / maxDouble)
            let tempGradeInt = Int(Double(tempGrade * 10000))
            self.stuGrade = tempGradeInt
            destinationVC.stuGrade = self.stuGrade
        }
    }
    
    // This function allows both the psudo-random numbers, and true random numbers to be used.
    func randFunc(min: Int, max: Int) -> Int {
        if (homeworkQuiz){
            let randomInt = Int.random(in: min ..< max, using: &generator)
            return randomInt
        }
        else {
            let randomInt = Int.random(in: min ... max)
            return randomInt
        }
    }
    
    // Function is used in "Next Question" to manipulate the viewable values.
    func score(right: Int, wrong: Int, question: Int){
        score_right = score_right + right;
        score_wrong = score_wrong + wrong;
        score_Qcurrent = score_Qcurrent + question;
        
        lbl_right.text = "Right: " + String(score_right);
        lbl_wrong.text = "Wrong: " + String(score_wrong);
        let score_percentage: Float = (Float(score_Qcurrent) / Float(score_Qmax));
        progviewquiz.setProgress(score_percentage, animated: true);
    }
}
