//
//  StaticTableViewController.swift
//  TableViewApp
//
//  Created by Elijah Caluya on 3/1/21.
//

import UIKit

class TableViewController: UITableViewController {

    // List of Member objects to populate the Table View
    let members = [
        Member(stageName: "Heejin",
               unit: .oneThird,
               firstName: "Hee Jin",
               lastName: "Jeon",
               birthday: "October 19, 2000",
               debut: "October 5, 2016",
               color: "Pink",
               animal: "Rabbit",
               pic:"https://pbs.twimg.com/media/Em8mjvOVkAAfIQM?format=jpg&name=4096x4096"),
        Member(stageName: "Hyunjin",
               unit: .oneThird,
               firstName: "Hyun Jin",
               lastName: "Kim",
               birthday: "November 19, 2000",
               debut: "November 17, 2016",
               color: "Yellow",
               animal: "Cat",
               pic: "https://pbs.twimg.com/media/Em8nBQYVgAYOEgC?format=jpg&name=4096x4096"),
        Member(stageName: "Haseul",
               unit: .oneThird,
               firstName: "Ha Seul",
               lastName: "Jo",
               birthday: "August 18, 1997",
               debut: "December 15, 2016",
               color: "Green",
               animal: "White Bird",
               pic: "https://kprofiles.com/wp-content/uploads/2017/05/Haseul-1-429x800.jpg"),
        Member(stageName: "Yeojin",
               unit: .solo,
               firstName: "Yeo Jin",
               lastName: "Im",
               birthday: "November 11, 2002",
               debut: "January 4, 2017",
               color: "Orange",
               animal: "Frog",
               pic: "https://pbs.twimg.com/media/Em8nNNeVgAA1cQD?format=jpg&name=4096x4096"),
        Member(stageName: "Vivi",
               unit: .oneThird,
               firstName: "Gaahei",
               lastName: "Wong",
               birthday: "December 9, 1996",
               debut: "April 17, 2017",
               color: "Pastel Rose",
               animal: "Deer",
               pic: "https://pbs.twimg.com/media/Em8nXLHVoAAhacW?format=jpg&name=4096x4096"),
        Member(stageName: "Kim Lip",
               unit: .oddEye,
               firstName: "Jung Eun",
               lastName: "Kim",
               birthday: "February 1, 1999",
               debut: "May 23, 2017",
               color: "Red",
               animal: "Owl",
               pic: "https://pbs.twimg.com/media/Em8noM2UcAIv0HM?format=jpg&name=4096x4096"),
        Member(stageName: "JinSoul",
               unit: .oddEye,
               firstName: "Jin Sol",
               lastName: "Jung",
               birthday: "June 13, 1997",
               debut: "June 26, 2017",
               color: "Blue",
               animal: "Blue Betta Fish",
               pic: "https://pbs.twimg.com/media/Em8n73_VEAAtY4G?format=jpg&name=4096x4096"),
        Member(stageName: "Choerry",
               unit: .oddEye,
               firstName: "Ye Rim",
               lastName: "Choi",
               birthday: "June 4, 2001",
               debut: "July 28, 2017",
               color: "Purple",
               animal: "Fruit Bat",
               pic: "https://pbs.twimg.com/media/Em8oHiyVkAg23eY?format=jpg&name=4096x4096"),
        Member(stageName: "Yves",
               unit: .yyxy,
               firstName: "Soo Young",
               lastName: "Ha",
               birthday: "May 24, 1997",
               debut: "November 28, 2017",
               color: "Burgundy",
               animal: "Swan",
               pic: "https://pbs.twimg.com/media/Em8ovmFVkAABg0u?format=jpg&name=4096x4096"),
        Member(stageName: "Chuu",
               unit: .yyxy,
               firstName: "Ji Woo",
               lastName: "Kim",
               birthday: "October 20, 1999",
               debut: "December 28, 2017",
               color: "Peach",
               animal: "Penguin",
               pic: "https://pbs.twimg.com/media/Em8o9h2VQAEmvnH?format=jpg&name=4096x4096"),
        Member(stageName: "Go Won",
               unit: .yyxy,
               firstName: "Chae Won",
               lastName: "Park",
               birthday: "November 19, 2000",
               debut: "January 30, 2018",
               color: "Eden Green",
               animal: "Butterfly",
               pic: "https://pbs.twimg.com/media/Em8pOTDVcAAedPh?format=jpg&name=4096x4096"),
        Member(stageName: "Olivia Hye",
               unit: .yyxy,
               firstName: "Hye Joo",
               lastName: "Son",
               birthday: "November 13, 2001",
               debut: "March 30, 2018",
               color: "Silver",
               animal: "Wolf",
               pic: "https://pbs.twimg.com/media/Em8pfzLVoAIoLfY?format=jpg&name=4096x4096")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return members.count
    }

    // Configure the Table View to display the stage name and sub unit for each member
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let member = members[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: member.unit.rawValue, for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = member.stageName
        cell.detailTextLabel?.text = "Sub-Unit: \(member.unit.rawValue)"
        return cell
    }
    
    // Prepare info for the segue between view controllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailViewController = segue.destination as? DetailViewController {
            if let indexPath =
                self.tableView.indexPathForSelectedRow {
                detailViewController.member = members[indexPath.row]
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
