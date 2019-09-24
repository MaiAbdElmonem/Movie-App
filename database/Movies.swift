//
//  Movies.swift
//  database
//
//  Created by mai ahmed on 5/12/19.
//  Copyright © 2019 mai ahmed. All rights reserved.
//

import UIKit

class Movies: NSObject {
    
    var title : String = ""
    var image : String = ""
    var rating : Float = 0.0
    var releaseYear : Int = 0
    var genre : [String] = [""]
    
    
    init(title: String, image : String , rating : Float, releaseYear :Int, genre : [String]) {
        self.title = title
        self.image = image
        self.rating = rating
        self.releaseYear = releaseYear
        self.genre = genre
    }
}
