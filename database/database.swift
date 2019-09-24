//
//  database.swift
//  database
//
//  Created by mai ahmed on 5/12/19.
//  Copyright © 2019 mai ahmed. All rights reserved.
//

import Foundation
import CoreData

class database {
    let appDelegate:AppDelegate?
    
    init(appDelegate:AppDelegate?){
        self.appDelegate = appDelegate
    }
    
    func saveCore(movies:Array<Movies>){
        //2
        let managedContext = self.appDelegate?.persistentContainer.viewContext
        //3
        let entity1 = NSEntityDescription.entity(forEntityName: "Film", in: managedContext!)
        let entity2 = NSEntityDescription.entity(forEntityName: "Genre", in: managedContext!)
        for mv in movies {
            //4
            let movie = NSManagedObject(entity: entity1!, insertInto: managedContext!)
            //5
            movie.setValue(mv.title, forKeyPath: "name")
            movie.setValue(mv.image, forKeyPath: "image")
            movie.setValue(mv.rating, forKeyPath: "rating")
            movie.setValue(mv.releaseYear, forKeyPath: "releaseYear")
            
            for gr in mv.genre {
                let genre = NSManagedObject(entity: entity2!, insertInto: managedContext!)
                
                genre.setValue(gr, forKeyPath: "name")
                
                
                //                movie.setValue(NSSet(object: genre), forKey: "genre")
                // Add Genres to movie
                let genres = movie.mutableSetValue(forKey: "belongsTo")
                genres.add(genre)
            }
        }
        //6
        do{
            try managedContext!.save()
        }catch let error{
            print(error)
        }
    }
    
    func fetchCore()->Array<Movies>{
        let managedContext = self.appDelegate!.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Film")
        
        let dateSort = NSSortDescriptor(key:"name", ascending:true)
        fetchRequest.sortDescriptors = [dateSort]
        
        var movies:Array<Movies> = []
        // Execute Fetch Request
        do {
            let results = try managedContext.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult>) as! [NSManagedObject]
            
            for mv in results {
                let movie = Movies(title: mv.value(forKey: "name") as! String, image: mv.value(forKey: "image") as! String, rating: mv.value(forKey: "rating") as! Float, releaseYear: mv.value(forKey: "releaseYear") as! Int, genre: [])
                let records = mv.mutableSetValue(forKey: "belongsTo")
                
                for record in records {
                    movie.genre.append(((record as AnyObject).value(forKey: "name") as! String?)!)
                }
                
                movies.append(movie)
            }
        } catch let error {
            print(error)
        }
        return movies
    }
    
    func deleteAllData(entity: String)
    {
        let managedContext = self.appDelegate!.persistentContainer.viewContext
        let ReqVar = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: ReqVar)
        do { try managedContext.execute(DelAllReqVar) }
        catch { print(error) }
    }
}
