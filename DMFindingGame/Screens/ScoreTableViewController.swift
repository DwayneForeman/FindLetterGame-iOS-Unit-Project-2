//
//  ScoreTableViewController.swift
//  DMFindingGame
//
//  Created by MyMac on 8/7/23.
//

import UIKit

class ScoreTableViewController: UITableViewController {

    @objc func closeButtonTapped() {
           dismiss(animated: true, completion: nil)
       }

    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        CoreDataManager.shared.scoresArray = CoreDataManager.shared.fetchScores()
        
       

        // Add "Close" button
              let closeButton = UIButton(type: .system)
              closeButton.setTitle("X", for: .normal)
              closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
              view.addSubview(closeButton)
              
              // Set button constraints for top left corner
              closeButton.translatesAutoresizingMaskIntoConstraints = false
              NSLayoutConstraint.activate([
                  closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
                  closeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 6) 
              ])
            

    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return CoreDataManager.shared.scoresArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath)
        cell.textLabel?.text = String(CoreDataManager.shared.scoresArray[indexPath.row].scoreCount)
        return cell
        
    }

}
