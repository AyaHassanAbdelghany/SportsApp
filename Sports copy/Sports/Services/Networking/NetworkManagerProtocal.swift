//
//  NetworkManagerProtocal.swift
//  Sports
//
//  Created by ayahassan on 5/13/22.
//  Copyright © 2022 ayahassan. All rights reserved.
//

import Foundation
import Alamofire

//https://www.thesportsdb.com/api/v1/json/2/eventsseason.php?id=4328
//event id for league special(id league)   upcoming events

//https://www.thesportsdb.com/api/v1/json/2/search_all_teams.php?s=Soccer&c=England
// teams for league special and country(strLeague)  teams

//https://www.thesportsdb.com/api/v1/json/2/eventslast.php?id=133602
// results for event special (event id)  last results

protocol NetworkManagerProtocol{
    func fetchResponse <T: Decodable>(endUrl: String, httpMethod: HTTPMethod ,parametrs : [String:String] , complitionHandler: @escaping (Swift.Result<T, Error>) -> Void)
}
