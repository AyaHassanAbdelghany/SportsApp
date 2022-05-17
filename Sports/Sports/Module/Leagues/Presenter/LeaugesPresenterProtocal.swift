//
//  LeaugesPresenterProtocal.swift
//  Sports
//
//  Created by ayahassan on 5/13/22.
//  Copyright © 2022 ayahassan. All rights reserved.
//

import Foundation

protocol LeaguePresenterProtocol{
    
    func getLeagues(leagueName:String)
    func attachView(view :LeaguesViewProtocal)

}
