//
//  ViewController.swift
//  GuessTheSneaker
//
//  Created by Elijah Caluya on 3/2/21.
//

import UIKit
import SQLite3

class ViewController: UIViewController {

    var db: OpaquePointer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // create database file
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("shoeDB.sqlite")
        // open the database
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        // Create table
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS ShoeTable (id TEXT PRIMARY KEY, brand TEXT, model TEXT, colorway TEXT)", nil, nil, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
    }


}

