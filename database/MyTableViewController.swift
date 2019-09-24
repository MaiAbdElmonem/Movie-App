//
//  MyTableViewController.swift
//  database
//
//  Created by mai ahmed on 5/3/19.
//  Copyright © 2019 mai ahmed. All rights reserved.
//

import UIKit
import CoreData
import Reachability


class MyTableViewController: UITableViewController {
    var movies: [Movies] = []
    var moviesObj : Movies!

    
    @IBAction func addbutton(_ sender: Any) {
    }
    
    let reachability = Reachability()!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if reachability.connection == .wifi || reachability.connection == .cellular {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            //1
            let url : URL? = URL(string: "https://api.androidhive.info/json/movies.json")
            
            //2
            let request : URLRequest = URLRequest(url: url!)
            
            //3
            let session : URLSession = URLSession(configuration: URLSessionConfiguration.default)
            
            //4
            let task = session.dataTask(with: request) { (data, response, error) in
                // 6
                do{
                    var json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Array<Dictionary<String, Any>>
                    
                    
                    
                    for i in 0...json.count - 1  {
                        self.moviesObj = Movies(title: json[i]["title"] as! String, image : json[i]["image"] as! String , rating : json[i]["rating"] as! Float, releaseYear : json[i]["releaseYear"]  as! Int, genre : json[i]["genre"] as! Array)
                        self.movies.append(self.moviesObj)
                        
                    }
                    
                    // UILabel.text must be used from main thread only
                    // we will use : any thing related to GUI
                    DispatchQueue.main.async {
                        // self.myLabel.text = movie["title"] as? String
                        
                        self.tableView.reloadData()
                        
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        
                    }
                    
                    
                    //print(json)
                } catch let error{
                    print(error)
                }
                
            }
            task.resume()
        }
}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

//         Configure the cell...

        return cell
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
