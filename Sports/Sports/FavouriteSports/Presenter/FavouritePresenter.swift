//
//  FavouritePresenter.swift
//  Sports
//
//  Created by ayahassan on 5/16/22.
//  Copyright © 2022 ayahassan. All rights reserved.
//

import Foundation
import CoreData

class FavouritePresenter :FavouritePresenterProtocol{

    
    var leagues :[League]!
    var dbManager :DBManagerProtocal!
   var favouriteSportsView : FavouriteSportsViewProtocal!
    
    init(dbManager : DBManagerProtocal) {
                self.dbManager = dbManager
            }

    func attachView(view: FavouriteSportsViewProtocal) {
        self.favouriteSportsView = view
    }
    
    func insertLeague(league: League) {
        dbManager.insertLeague(league: league)
    }
    
    func getLFavLeagues() -> [League] {
        return dbManager.getLeague()
    }
    
    func deleteLeague(indexPath: Int) {
        dbManager.deleteLeague(indexPath :indexPath)
    }

}
