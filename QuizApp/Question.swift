//
//  Question.swift
//  QuizApp
//
//  Created by Jun Kakeno on 8/16/18.
//  Copyright © 2018 Jun Kakeno. All rights reserved.
//

class Question {

    var content: String
    var answers: [String]
    var correctAnswer: String
    
    init(content: String,answers: [String],correctAnswer:String) {
        self.content = content
        self.answers = answers
        self.correctAnswer = correctAnswer
    }
    
    func getContent() -> String {
        return self.content
    }
    
    func getAnswers() -> [String] {
        return self.answers
    }
    
    func getCorrectAnswer() -> String {
        return self.correctAnswer
    }
}
