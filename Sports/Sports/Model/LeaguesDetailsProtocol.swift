//
//  LeaguesDetailsProtocol.swift
//  Sports
//
//  Created by Rawan Bahnasy on 5/14/22.
//  Copyright © 2022 ayahassan. All rights reserved.
//

import Foundation
protocol LeaguesDetailsProtocol {
    func getLatestEvents(leagueID :String)
    func getTeams(sportType :String,country: String)

}
