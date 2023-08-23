//
//  GameBrain.swift
//  DMFindingGame
//
//  Created by David Ruvinskiy on 4/17/23.
//

import Foundation
import UIKit

/**
 2.1 Create a class called `GameBrain`. `GameBrain` will be a singleton that can be accessed in `StartViewController` and `GameViewController`. The code that makes this class a singleton is provided.
 
 
 A `GameBrain` should have the following properties:
 
    - A String `targetLetter` initially set to an empty String
    - A [String] `randomLetters` initially set to an empty array
    - An Int `score` initially set to 0
    - An Int `highScore` initially set to 0
    - An Int `numLetters` initially set to 0
    - An Int `secondsRemaining` set to 30
    - An Int `letters` set to 30
    - A [String] `letters` set to the letters of the alphabet.
 
 A `GameBrain` should also have the following methods:
 
    - `generateRandomLetters`:  Returns an array of letters. There should be as many letters as `numLetters`. The array should include the target letter. The rest of the letters should be random. A letter should show up in the array only once. The order of the letters should be random.
 
    - `newRound`: Sets the `targetLetter` to a random letter from the `letters` array and sets `randomLetters` to the result of calling `generateRandomLetters`.
 
    - `newGame`:  Accepts the number of letters for the game and assigns `numLetters` accordingly. Also sets the `score` to 0, sets the `secondsRemaining` to 30, and calls `newRound`.
 
    - `letterSelected`: Accepts the letter the user selected and updates the `score` and `highScore` accordingly. Also, calls `newRound`.
 
 Run the tests in `DMFindingGameTests` to make sure your code is correct.
 */
class GameBrain {
    
   
    
    /**
     This code makes `GameBrain` a singleton. You do not need to modify this code.
     */
    static let shared = GameBrain()
    private init() {}
    
   
    
    // Properties required
    
    var targetLetter = ""
    var randomLetters: [String] = []
    var score: Int = 0
    var highScore: Int = 0
    var numLetters: Int = 0
    var secondsRemaining: Int = 0
    var letters: Int = 30
    // There were two "letters" properties to be initiated via instructions above so I had to change one to alphabet oppose to letters
    var alphabet: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    // Methods required
    
    func generateRandomLetter() -> [String] {
        
     
        // Let's FIRST make sure we include the targerLetter into our array that we're going to return
        //  Rmeeber: Puttinge teh ragetLetter in brackets automcatically creates the STring array which we need to return
        var arrayOfLetters = [targetLetter]
        
        // Now we need to add 11 more numbers into the "arrayOfLetters" under two conditions
        // 1st Condition - While the count is less than 12 which is represented by "numLetters"
        // 2nd Condition - Making sure a number within the array doesn NOT appear twice
        // Solution - After researching, we can use a while loop...While said conditions are true let the code in {} execute
        
        while arrayOfLetters.count < numLetters {
            //Will run while the count inside the array is NOT more than 12
            
            let randomLetter = alphabet.randomElement()!
            // Creating a new constant and setting it equal to our array above and grabbing a randon element from it. Also .randomElement is an optional so we need to FORCE unwrap it.
            
            if !arrayOfLetters.contains(randomLetter) {
                // ONLY IF, our arrayOfLetters does NOT (hence the ! negate) contain the same randomeLetter we previously generated and sent to the rayy them we will execute the block below:
                
                arrayOfLetters.append(randomLetter)
                // Addind the number which we confired is NOT already in the array to the array
                
            }
            
        }
        
        // Since Arrays are in order and we want NO ORDER lets shake it around a bit using the buuilt in shuffle method
        arrayOfLetters.shuffle()
        
        // let's return our array
        return arrayOfLetters
        
    }
    
    
    func newRound() {
        targetLetter = alphabet.randomElement()!
        print(targetLetter)
        randomLetters = generateRandomLetter()
        //print(randomLetters)
    }
    
  
    
    func newGame(numOfLettersForGame: Int) {
        numLetters = numOfLettersForGame
        score = 0
        secondsRemaining = 30
        newRound()
    }
    
    func letterSelected(usersLetter: String) {
        
        
        // Adding score plus one if user selects the correct target letter
        if usersLetter == targetLetter {
            print(usersLetter)
            print(targetLetter)
            score += 1
            print(score)
        }
        
        
        // Updating highcore to equal score if score is higher than current highScore
        if highScore < score {
            highScore = CoreDataManager.shared.calculateHighScore()
        }
        
        newRound()
        
    }
    
}
