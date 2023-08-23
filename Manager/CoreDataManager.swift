//
//  CoreDataManager.swift
//  DMFindingGame
//
//  Created by David Ruvinskiy on 4/24/23.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Main")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Fatal error loading store: \(error.localizedDescription)")
            }
        }
        return container
    }()
    

    
   
    
    
    // Grab a hold of the Score entities
    var scoresArray = [Score]()
    
    
    /**
     Add the passed score to CoreData.
     */
    func addScore(score: Int) {
        
        // 1. We need our middle man first and foremost by tapping into the viewContact property of our persistantContainer we created form PersistantContainer class
        let context = persistentContainer.viewContext
        
        // 2. We need to create a new score that confroms to Core Data so we can sucesfully save a score everytime the user leaves the gameplay screen
        let newScore = NSEntityDescription.insertNewObject(forEntityName: "Score", into: context) as! Score
        
        // 3. Now when we can do whatver we like with the newScore. We will set it's scoreCount property equal what we pass in which will be (gameBrain.shared.scorre) as the parameter. You will notice we call this func addScore within the viewDidDissapear function so it saves rigth before user leaves the screen
        newScore.scoreCount = Int16(score)
        
        // 4. Now we use a do catch block as the .save() method throws an erorr. We are tapping into the .save() method of context. On step 2, we stored newScore into: context so it will properly save
        do {
            try context.save()
        } catch {
            print("Error saving scores \(error)")
        }
        
    }
    
    /**
     Retrieve all the scores from CoreData.
     */
    func fetchScores() -> [Score] {
        
        // 1. We need our middle man first and foremost by tapping into the viewContact property of our persistantContainer we created form PersistantContainer class
        let context = persistentContainer.viewContext
        
        // 2. We need to create our fetch request which should request an array of Scores
        let fetchRequest = NSFetchRequest<Score>(entityName: "Score")
        
        // 3. We need to capture the request in our created array by "try"ing and tapping into the premade fetch method of context and passing in the fetchRequest we creataed in step 2 - Since it will throw an error we wrap in a do/catch block
        do {
            scoresArray = try context.fetch(fetchRequest)
        } catch {
            print("Issues with fetching scores \(error)")
        }
        
        // 4. Let's return our array with the new fetched items from the database
        return scoresArray
    }
    
    /**
     Calculate the high score.
     */
    func calculateHighScore() -> Int {
        
        // 1. Let's create our middle man
        let context = persistentContainer.viewContext
        
        // 2. Let's create our fetch request
        let fetchRequest = NSFetchRequest<Score>(entityName: "Score")
        
        // 3. Our objective is to sort through out database to find teh highest score so we can use the .sortDescriptors method from teh fetchRquest. They "key" is the property we are using to dtermine the order which is scoreCount
        // we set acending to false so we can sort descinding from top to bottom and grab the highest right off the top of the array
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "scoreCount", ascending: false)]
        // 4. Set your fetchRequest limit. Since we are only looking for ONE high score we equal it to 1
        fetchRequest.fetchLimit = 1
        
        // 5. Let's create a constant to grab the higest score within the do/catch block. Notice we add.first at the end of the fetchReuest because we are looking for the very first item from our sort results
        do {
            let highestScore = try context.fetch(fetchRequest).first // Remeber we get back an array so we can tap into .first index of that array
            
            // Now we will tap into the property of the highestSore which is scoreCount. sinceScore count is an optional we have to safely unwrap it using optional binding
            if let highScore = highestScore?.scoreCount {
                // So if we are in fact able to sort a high score then let let equal the high schore of our gameBrain ib outlet property .highScore
                GameBrain.shared.highScore = Int(highScore)
                // Now return the highScore
                return Int(highScore)
        
            }
        } catch {
            print("Error fetching scores \(error)")
        }
        return 0 // If we cannot find a high score we return 0
    }
}
