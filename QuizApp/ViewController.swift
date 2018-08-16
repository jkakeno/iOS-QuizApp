//
//  ViewController.swift
//  QuizApp
//
//  Created by Jun Kakeno on 8/16/18.
//  Copyright © 2018 Jun Kakeno. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    //Counters
    var questionsAsked = 0
    var correctQuestions = 0
    var count = 15
    var timer:Timer?
    
    //Number of questions per game
    var questionsPerRound: Int!
    
    var gameSound: SystemSoundID = 0
    
    //Question and color properties initialize with ! is saying that these properties won't be nil
    var questionProvider: QuestionProvider = QuestionProvider()
    var question: Question!
    var backgroundColorProvider: BackgroundColorProvider = BackgroundColorProvider()
    var backgroundColor: UIColor!
    
    //Views properties
    @IBOutlet weak var resultField: UILabel!
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var countDown: UILabel!
    var buttons:[UIButton] = [UIButton]()

    override func viewDidLoad() {
        super.viewDidLoad()
        playSound(resource: "GameSound", type: "wav")
        displayQuestion()
    }
    
    //Helpers
    
    func playSound(resource: String, type: String){
        let path = Bundle.main.path(forResource: resource, ofType: type)
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
        AudioServicesPlaySystemSound(gameSound)
    }
    
    func displayQuestion() {
        //Hide unnessesary views
        playAgainButton.isHidden = true
        hideSelectionButtons()
        
        //Set number of questions per game
        questionsPerRound = questionProvider.questions.count
        
        //Set the text view with a random question
        question = questionProvider.randomQuestion()
        questionField.text = question.getContent()
        
        //Set the view background with a random color
        backgroundColor = backgroundColorProvider.randomColor()
        view.backgroundColor = backgroundColor
        
        //Set the answer selection buttons for each question
        var y :Double = 300.0
        for i in 0...question.getAnswers().count - 1{
            let button = UIButton(type: UIButtonType.roundedRect) as UIButton
            // Below set the frame of the button to a constant position (x position, y position)
//            button.frame = CGRect(x: 20.0, y: y, width: 335.0, height: 40.0)
            button.backgroundColor = UIColor.white
            button.tintColor = backgroundColor
            button.setTitle(question.getAnswers()[i], for: UIControlState.normal)
            //Add action to the button
            button.addTarget(self, action: #selector(selectAnswer), for:.touchUpInside)
            //Add the button to the container view
            self.view.addSubview(button)
            
            /*Add constraints to the button
             anchor the button leading edge to be 40 points to the right from the view leading edge
             anchor the button trailing edge to be 40 points to the left from the view trailing edge
             anchor the button top to be y points down from the top of the view
             anchor the button height to be 40 points*/
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
                button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
                button.topAnchor.constraint(equalTo: view.topAnchor, constant: CGFloat(y)),
                button.heightAnchor.constraint(equalToConstant: 40)
                ])
            
            /*Increase y position by 50 points for the next button since the height is set to 40 there will be 10 points between buttons*/
            y += 50
            
            //Add buttons to array
            buttons.append(button)
        }
        //Start timer
        timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter(){
        if count > 0 {
            countDown.text = String(count)
            count-=1
        }else if count == 0 {
            resetCounter()
            questionsAsked += 1
            nextRound()
        }
    }
    
    /*Create an action for answer selection button*/
    @objc func selectAnswer(sender: UIButton!) {
        // Increment the questions asked counter
        questionsAsked += 1
        if let lable = sender.titleLabel!.text{
            if lable == question.correctAnswer{
                resultField.textColor = UIColor.green
                resultField.text="Correct!"
                playSound(resource: "CorrectAnswerSound", type: "mp3")
                //Increament the correct questions counter
                correctQuestions += 1
            }else{
                resultField.textColor = UIColor.red
                resultField.text="Sorry, wrong answer! \nCorrect answer is: \(question.getCorrectAnswer())"
                playSound(resource: "WrongAnswerSound", type: "mp3")
            }
        }
        resetCounter()
        loadNextRound(delay: 2)
    }
    
    func resetCounter(){
        count = 15
        //Stop the timer
        timer?.invalidate()
        timer=nil
    }
    
    func loadNextRound(delay seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    func displayScore() {
        // Display play again button
        playAgainButton.isHidden = false
        //Hide unnessesary views
        hideSelectionButtons()

        //Display score
        if Double(correctQuestions)/Double(questionsAsked) >= 0.7{
            questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound as Int) correct!"
            playSound(resource: "SuccessSound", type: "wav")
        }else if Double(correctQuestions)/Double(questionsAsked) < 0.7{
            questionField.text = "May need to improve. \nYou got \(correctQuestions) out of \(questionsPerRound as Int) correct!"
            playSound(resource: "FailureSound", type: "wav")
        }
    }
    
    func hideSelectionButtons(){
        resultField.text = ""
        countDown.text = ""
        for button in buttons{
            button.isHidden = true
        }
    }

    @IBAction func playAgain(_ sender: UIButton) {
        //Reset counters
        questionsAsked = 0
        correctQuestions = 0
        nextRound()
    }
    

}

