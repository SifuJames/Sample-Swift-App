//
//  OpeningTableViewController.swift
//  Learn This
//
//  Created by James Stacy on 2/5/19.
//  Copyright © 2019 James Stacy. All rights reserved.
//

import UIKit

class OpeningTableViewController: UITableViewController {
    
    var items = [MemryItem]()
    
   

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        makeItems()
       // loadItem()
    }

    func  makeItems() {
        items.removeAll()
        var me = MemryItem(title: "Test 1", text:"Text, for Test 1.")
        items.append(me)
        me = MemryItem(title: "Test 2", text:"Text, for Test 2.")
        items.append(me)
        me = MemryItem(title: "Test 3", text:"Text, for Test 3.")
        items.append(me)
        me = MemryItem(title: "Test 4", text:"Text, for Test 4.")
        items.append(me)
        me = MemryItem(title: "Test 5", text:"Text, for Test 5.")
        items.append(me)
        me = MemryItem(title: "Test 6", text:"Text, for Test 6.")
        items.append(me)
        
    }
    
    func loadItem() {
        guard let url = Bundle.main.url(forResource: "Items", withExtension: "json") else {
            fatalError("Can't find JSON")
        }
        guard let data = try? Data(contentsOf: url) else{
            fatalError("Could not load JSON")
        }
        
        let decoder = JSONDecoder()
        
        guard let savedItems = try? decoder.decode([MemryItem].self, from: data) else {
            fatalError("Could not decode JSON")
        }
        
        items = savedItems
        
    }
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return items.count
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "openCell", for: indexPath)

        cell.textLabel?.text = items[indexPath.row].title
        cell.detailTextLabel?.text = items[indexPath.row].text

        return cell
    }
   
  override  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let vc = storyboard?.instantiateViewController(withIdentifier: "ShowViewController") as? ShowViewController else{
        fatalError("Failed to get screen")}
        let item = items[indexPath.row]
    vc.item = item
        navigationController?.pushViewController(vc, animated: true)
    
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
