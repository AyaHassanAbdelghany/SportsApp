//
//  FavouritePresenterProtocal.swift
//  Sports
//
//  Created by ayahassan on 5/16/22.
//  Copyright © 2022 ayahassan. All rights reserved.
//

import Foundation
import CoreData

protocol FavouritePresenterProtocol{
    
   
     func insertLeague(league:League)
     func getLFavLeagues()-> [League]
    func deleteLeague(indexPath: Int)
    func attachView(view :FavouriteSportsViewProtocal)

}
