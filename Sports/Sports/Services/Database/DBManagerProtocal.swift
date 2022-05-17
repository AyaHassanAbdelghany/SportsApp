//
//  DBManagerProtocal.swift
//  Sports
//
//  Created by ayahassan on 5/16/22.
//  Copyright © 2022 ayahassan. All rights reserved.
//

import Foundation
import CoreData

protocol DBManagerProtocal{
    
    
    func insertLeague(league:League)
    func getLeague()-> [League]
   func deleteLeague(indexPath: Int)
    
    
}
