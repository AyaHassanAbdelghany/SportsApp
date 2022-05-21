//
//  DBManager.swift
//  Sports
//
//  Created by ayahassan on 5/16/22.
//  Copyright © 2022 ayahassan. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DBManager :DBManagerProtocal{
 
    
    
    var viewContext : NSManagedObjectContext!

    init(){
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        viewContext = appdelegate.persistentContainer.viewContext
    }
    
    func insertLeague(league: League) {
        let entity = NSEntityDescription.entity(forEntityName: "Leagues", in: viewContext)
        let leagueFav = NSManagedObject(entity: entity!, insertInto: viewContext)
               
        print(league.strLeague as Any)
        leagueFav.setValue(league.strLeague, forKey: "leagueName")
        leagueFav.setValue(league.strBadge,  forKey: "leagueImage")
        leagueFav.setValue(league.strYoutube ,forKey: "leagueYoutube")
        leagueFav.setValue(league.isFavorite, forKey: "isFavorite")
        leagueFav.setValue(league.idLeague, forKey: "idLeague")
        leagueFav.setValue(league.strCountry, forKey: "strCountry")
        leagueFav.setValue(league.strSport, forKey: "strSport")

            do{
            try viewContext.save()
                                                
            }catch let error{
        print(error.localizedDescription)
            }
          
    }
    
    func getLeague() -> [League] {
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "Leagues")
         var leagues = [League]()
                    do{
                let leagueFav = try self.viewContext.fetch(fetch)
                print(leagueFav.count)
                leagueFav.forEach { (item) in
                var league = League()
                league.strLeague = item.value(forKey: "leagueName") as? String
                league.strBadge = item.value(forKey: "leagueImage") as? String
                league.strYoutube = item.value(forKey: "leagueYoutube") as? String
                    league.isFavorite = item.value(forKey: "isFavorite") as? Bool
                    league.idLeague = item.value(forKey: "idLeague")
                    as? String
                    league.strCountry = item.value(forKey: "strCountry")
                    as? String
                    league.strSport = item.value(forKey: "strSport")
                    as? String
                leagues.append(league)
                      }
                   
                    }catch{
                print("Couldn't fetch!")
                    }
        return leagues
    }
    
    func deleteLeague(indexPath : Int){
    let fetch = NSFetchRequest<NSManagedObject>(entityName: "Leagues")
                    do{
    let leagueObject = try self.viewContext.fetch(fetch)
        viewContext.delete(leagueObject[indexPath])
           do{
               try viewContext.save()
                    }
    
                        }catch{
               print("Couldn't delete league!")
           }
    }
    
    func deleteObject(_ object : NSManagedObject)
     {
         viewContext.delete(object)
         do
         {
             try viewContext.save()
         }
         catch let error
         {
             print(error.localizedDescription)
         }
     }
    func searchForLeague(_ queryStr : String) -> NSManagedObject?
    {
        let req = NSFetchRequest<NSManagedObject>(entityName: "Leagues")
        req.predicate = NSPredicate(format: "leagueName == %@", queryStr ?? "")
        var ret : [NSManagedObject]?
        do
        {
            ret = try viewContext.fetch(req)
        }
        catch let error
        {
            print(error.localizedDescription)
        }
        if ret?.count == 0
        {
            return nil
        }
        return ret?[0]
    }
    
}
