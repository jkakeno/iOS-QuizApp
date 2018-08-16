//
//  BackgroundColorProvider.swift
//  QuizApp
//
//  Created by Jun Kakeno on 8/16/18.
//  Copyright © 2018 Jun Kakeno. All rights reserved.
//

import UIKit
import GameKit

var randomNumber: Int = 0
var previousNumbers: [Int] = [Int]()

struct BackgroundColorProvider {
    let colors = [
        UIColor(red: 90/255.0, green: 187/255.0, blue: 181/255.0, alpha: 1.0), // teal color
        UIColor(red: 222/255.0, green: 171/255.0, blue: 66/255.0, alpha: 1.0), // yellow color
        UIColor(red: 241/255.0, green: 192/255.0, blue: 200/255.0, alpha: 1.0), // pink color
        UIColor(red: 239/255.0, green: 130/255.0, blue: 100/255.0, alpha: 1.0), // orange color
        UIColor(red: 77/255.0, green: 75/255.0, blue: 82/255.0, alpha: 1.0), // dark color
        UIColor(red: 105/255.0, green: 94/255.0, blue: 133/255.0, alpha: 1.0), // purple color
        UIColor(red: 150/255.0, green: 210/255.0, blue: 225/255.0, alpha: 1.0), // baby blue color
    ]
    
    func randomColor() -> UIColor {
        let randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: colors.count)
        return colors[randomNumber]
    }
}

