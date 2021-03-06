//
//  ViewController.swift
//  GuessTheSneaker
//
//  Created by Elijah Caluya on 3/2/21.
//

import UIKit
import SQLite3

class ViewController: UIViewController {
    @IBOutlet weak var adidasButton: UIButton!
    @IBOutlet weak var ajButton: UIButton!
    @IBOutlet weak var nikeButton: UIButton!
    
    
    // Need OpaquePointers for SQLite functionality
    var db: OpaquePointer?
    var stmt: OpaquePointer?
    
    
    // Function to get shoes from a specific brand or all shoes
    func getShoesFromBrand(brand: String) -> Array<Shoe>{
        var selectQuery = "SELECT * FROM ShoeTable WHERE brand = '\(brand)'"
        // If paramter is empty string, get all of the shoes
        if brand.count == 0 {
            selectQuery = "SELECT * FROM ShoeTable"
        }
        
        if sqlite3_prepare(db, selectQuery, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error selecting from table: \(errmsg)")
        }
        
        // Return a list of shoe objects
        var list = [Shoe]()
        while (sqlite3_step(stmt) == SQLITE_ROW){
            let id = String(cString: sqlite3_column_text(stmt, 0))
            let brand = String(cString: sqlite3_column_text(stmt, 1))
            let model = String(cString: sqlite3_column_text(stmt, 2))
            let colorway = String(cString: sqlite3_column_text(stmt, 3))
            // add values to list
            list.append(Shoe(id: String(id), brand: String(brand), model: String(model), colorway: String(colorway)))
        }
        return list
    }
    
    // Prepare data for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // if going to Gameplay, send the brand and list of shoes of that specific brand
        if let target = segue.destination as? GameplayViewController {
            if let brand = sender as? UIButton {
                target.brand = brand.currentTitle!
                target.brandList = getShoesFromBrand(brand: brand.currentTitle!)
            }
        }
        // Otherwise, send all the shoes for the answers
        else if let target = segue.destination as? AnswersViewController {
            target.shoesList = getShoesFromBrand(brand: "")
        }
    }
    
    // Function to display rules to user as an alert
    @IBAction func displayRules(_ sender: UIBarButtonItem) {
        let title = "Rules:"
        var message = "1) Pick a Brand you want to choose from (Adidas, Air Jordan, Nike)\n"
        message += "2) Choose the model and colorway from the picker for your answer\n"
        message += "3) Press Submit and confirm or cancel your choice\n"
        message += "4) If you get 10 correct you win the game. 3 incorrect choices means you lose"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okayAction)
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // create database file
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("shoeDB.sqlite")
        // open the database
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
//        // Dropping table for testing purposes
//        if sqlite3_exec(db, "DROP TABLE ShoeTable", nil, nil, nil) != SQLITE_OK {
//            let errmsg = String(cString: sqlite3_errmsg(db)!)
//            print("error dropping table: \(errmsg)")
//        }
        // Create table
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS ShoeTable (id TEXT PRIMARY KEY, brand TEXT, model TEXT, colorway TEXT)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        
        // Check if the table is empty or not
        var isEmptyTable = false
        // Select from table
        if sqlite3_prepare(db, "SELECT COUNT(*) FROM ShoeTable", -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error selecting from table: \(errmsg)")
        }
        
        // If you get an empty result, then the table is empty and needs to be populated
        while (sqlite3_step(stmt) == SQLITE_ROW){
            let numRows = sqlite3_column_int(stmt, 0)
            if numRows == 0 {
                isEmptyTable = true
            }
        }
        
        // Only populate the table if it is empty (Usually on first installation of device)
        if isEmptyTable {
            print("New table, populating with data")
            // Load data in from txt file
            if let path = Bundle.main.path(forResource: "shoe_data", ofType: "txt") {
                do {
                    let data = try String(contentsOfFile: path, encoding: .ascii)
                    let myStrings = data.components(separatedBy: "\r\n")
                    for i in 0..<myStrings.count-1 {
                        let shoes = myStrings[i].components(separatedBy: ",")
                        // Insert into table
                        if sqlite3_exec(db, "INSERT INTO ShoeTable VALUES ('\(shoes[0])', '\(shoes[1])', '\(shoes[2])', '\(shoes[3])')", nil, nil, nil) != SQLITE_OK {
                            let errmsg = String(cString: sqlite3_errmsg(db)!)
                            print("error inserting into table: \(errmsg)")
                        }
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
}

