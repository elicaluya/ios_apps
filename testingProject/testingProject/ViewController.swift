//
//  ViewController.swift
//  testingProject
//
//  Created by Elijah Caluya on 2/19/21.
//

import UIKit
import SQLite3

class ViewController: UIViewController {
    
    @IBOutlet weak var urlImage: UIImageView!
    
    @IBOutlet weak var textOutlet: UITextView!
    
    
    let url = "https://elijah-caluya-web.s3-us-west-1.amazonaws.com/PersonalWebsite/img/androidapp_screenshot.PNG"

    let url2 = "https://elijah-caluya-web.s3-us-west-1.amazonaws.com/PersonalWebsite/img/quote_screenshot.PNG"
    
    
    // Testing image download and viewing functionality
    @IBAction func getSecondImage(_ sender: UIButton) {
        urlImage.load(url: URL(string: url2)!)
    }
    
    @IBAction func getImage(_ sender: UIButton) {
        urlImage.load(url: URL(string: url)!)
    }
    
    
    // Testing SQL functionality
    var db: OpaquePointer?
    let insertQuery = "INSERT INTO TestTable VALUES ('shoe_id1', 'brand1', 'model1', 'cw1')"
    var tcList = [TestClass]()
    let selectQuery = "SELECT * FROM TestTable"
    var stmt: OpaquePointer?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // create database file
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("testDB.sqlite")
        // open the database
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        // Dropping table
        if sqlite3_exec(db, "DROP TABLE TestTable", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error dropping table: \(errmsg)")
        }
        // Create table
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS TestTable (id TEXT PRIMARY KEY, brand TEXT, model TEXT, colorway TEXT)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        // Insert into table
        if sqlite3_exec(db, insertQuery, nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error inserting into table: \(errmsg)")
        }
        // Select from table
        if sqlite3_prepare(db, selectQuery, -1, &stmt, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error selecting from table: \(errmsg)")
        }
        // Traversing through all the records
        while (sqlite3_step(stmt) == SQLITE_ROW){
            let id = String(cString: sqlite3_column_text(stmt, 0))
            let brand = String(cString: sqlite3_column_text(stmt, 1))
            let model = String(cString: sqlite3_column_text(stmt, 2))
            let colorway = String(cString: sqlite3_column_text(stmt, 3))
            // add values to list
            tcList.append(TestClass(id: String(id), brand: String(brand), model: String(model), colorway: String(colorway)))
        }
        // Reading through list and displaying the item
        var text = ""
        for i in 0..<tcList.count {
            let item: TestClass = tcList[i]
            text += "id = \(item.id!) brand = \(item.brand!) model = \(item.model!) cw = \(item.colorway!)"
        }
        textOutlet.text = text
    }


}

extension UIImageView {
    func load(url: URL){
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

