//
//  QuestionProvider.swift
//  QuizApp
//
//  Created by Jun Kakeno on 8/16/18.
//  Copyright © 2018 Jun Kakeno. All rights reserved.
//

import GameKit

class QuestionProvider{
    var questions: [Question] = []
    var randomNumber: Int = 0
    var previousNumbers: [Int] = [Int]()
    
    init(){
        let question1 = Question(content: "This was the only US President to serve more than two consecutive terms.", answers: ["George Washington","Franklin D. Roosevelt","Woodrow Wilson","Andrew Jackson"], correctAnswer: "Franklin D. Roosevelt")
        let question2 = Question(content: "Which of the following countries has the most residents?", answers: ["Nigeria","Russia","Iran","Vietnam"], correctAnswer: "Nigeria")
        let question3 = Question(content: "In what year was the United Nations founded?", answers: ["1918","1919","1945"], correctAnswer: "1945")
        let question4 = Question(content:"The Titanic departed from the United Kingdom, where was it supposed to arrive?" , answers: ["Paris","Washington D.C.","New York City","Boston"], correctAnswer: "New York City")
        let question5 = Question(content: "Which nation produces the most oil?", answers: ["Iran","Iraq","Brazil","Canada"], correctAnswer: "Canada")
        let question6 = Question(content: "Which country has most recently won consecutive World Cups in Soccer?", answers: ["Italy","Brazil","Argetina","Spain"], correctAnswer: "Brazil")
        let question7 = Question(content: "Which of the following rivers is longest?", answers: ["Yangtze","Mississippi","Congo","Mekong"], correctAnswer: "Mississippi")
        let question8 = Question(content: "Which city is the oldest?", answers: ["Mexico City","Cape Town","San Juan","Sydney"], correctAnswer: "Mexico City")
        let question9 = Question(content: "Which country was the first to allow women to vote in national elections?", answers: ["Poland","United States"], correctAnswer: "Poland")
        let question10 = Question(content: "Which of these countries won the most medals in the 2012 Summer Games?", answers: ["France","Germany","Japan","Great Britian"], correctAnswer: "Great Britian")
        
        questions.append(question1)
        questions.append(question2)
        questions.append(question3)
        questions.append(question4)
        questions.append(question5)
        questions.append(question6)
        questions.append(question7)
        questions.append(question8)
        questions.append(question9)
        questions.append(question10)
    }
    
    func randomQuestion() -> Question {
        
        repeat {
            randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: questions.count)
        }while previousNumbers.contains(randomNumber)
        previousNumbers.append(randomNumber)
        if previousNumbers.count == questions.count{
            //Reset the array that holds previous numbers onces all the questions have been presented
            previousNumbers=[]
        }
        return questions[randomNumber]
    }
}
