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
    
    var db: OpaquePointer?
    var shoeList = [Shoe]()
    let sizeQuery = "SELECT COUNT(*) FROM ShoeTable"
    var stmt: OpaquePointer?
    
    
    func getShoesFromBrand(brand: String) -> Array<Shoe>{
        let selectQuery = "SELECT * FROM ShoeTable WHERE brand = '\(brand)'"
        if sqlite3_prepare(db, selectQuery, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error selecting from table: \(errmsg)")
        }
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let target = segue.destination as? GameplayViewController {
            if let brand = sender as? UIButton {
                target.brand = brand.currentTitle!
                target.brandList = getShoesFromBrand(brand: brand.currentTitle!)
            }
        }
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
//        // Dropping table
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
        if sqlite3_prepare(db, sizeQuery, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error selecting from table: \(errmsg)")
        }
        
        while (sqlite3_step(stmt) == SQLITE_ROW){
            let numRows = sqlite3_column_int(stmt, 0)
            if numRows == 0 {
                isEmptyTable = true
            }
        }
        
        // Only populate the table if it is empty
        if isEmptyTable {
            print("New table, populating with data")
            // Load data in from txt file
            if let path = Bundle.main.path(forResource: "shoe_data", ofType: "txt") {
                do {
                    let data = try String(contentsOfFile: path, encoding: .ascii)
                    let myStrings = data.components(separatedBy: "\r\n")
                    for i in 0..<myStrings.count-1 {
                        let shoes = myStrings[i].components(separatedBy: ",")
                        shoeList.append(Shoe(id: shoes[0], brand: shoes[1], model: shoes[2], colorway: shoes[3]))
                    }
                } catch {
                    print(error)
                }
            }
        }
        
        for i in 0..<shoeList.count {
            // Insert into table
            if sqlite3_exec(db, "INSERT INTO ShoeTable VALUES ('\(shoeList[i].id!)', '\(shoeList[i].brand!)', '\(shoeList[i].model!)', '\(shoeList[i].colorway!)')", nil, nil, nil) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("error inserting into table: \(errmsg)")
            }
        }
        
//        // Load data into table if the table is empty
//        if sqlite3_exec(db, "BULK INSERT ShoeTable FROM 'shoe_list.txt' WITH (FIELDTERMINATOR = ',',ROWTERMINATOR = '\n') GO", nil, nil, nil) != SQLITE_OK {
//            let errmsg = String(cString: sqlite3_errmsg(db)!)
//            print("error creating table: \(errmsg)")
//        }
//        // Select from table
//        if sqlite3_prepare(db, selectQuery, -1, &stmt, nil) != SQLITE_OK {
//            let errmsg = String(cString: sqlite3_errmsg(db)!)
//            print("error selecting from table: \(errmsg)")
//        }
//        // Traversing through all the records
//        while (sqlite3_step(stmt) == SQLITE_ROW){
//            let id = String(cString: sqlite3_column_text(stmt, 0))
//            let brand = String(cString: sqlite3_column_text(stmt, 1))
//            let model = String(cString: sqlite3_column_text(stmt, 2))
//            let colorway = String(cString: sqlite3_column_text(stmt, 3))
//            // add values to list
//            shoeList.append(Shoe(id: String(id), brand: String(brand), model: String(model), colorway: String(colorway)))
//        }
//        // Reading through list and displaying the item
//        var text = ""
//        for i in 0..<shoeList.count {
//            let item: Shoe = shoeList[i]
//            text += "id = \(item.id!) brand = \(item.brand!) model = \(item.model!) cw = \(item.colorway!)"
//        }
//        testText.text = text
    }


}

