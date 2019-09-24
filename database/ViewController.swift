//
//  ViewController.swift
//  MovieListJson
//
//  Created by Lost Star on 5/3/19.
//  Copyright © 2019 esraa. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    
    var movieObj :Movies!
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var releaseLabel: UILabel!
    
    @IBOutlet weak var genreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Movie Details"
        // Do any additional setup after loading the view.
        myTableView.delegate = self
        myTableView.dataSource = self
        
        
        titleLabel.text = movieObj.title
        ratingLabel.text = "\(movieObj.rating)"
        releaseLabel.text = "\(movieObj.releaseYear)"
        movieImage.sd_setImage(with: URL(string :movieObj.image),placeholderImage: UIImage(named: ""))
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieObj.genre.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = movieObj.genre[indexPath.row]
        
        return cell
        
    }
    
    
    
}

