//
//  Event.swift
//  Sports
//
//  Created by Rawan Bahnasy on 5/13/22.
//  Copyright © 2022 ayahassan. All rights reserved.
//

import Foundation


// MARK: - Welcome
struct AllEvents: Codable {
    var event: [Event]?
}

// MARK: - Event
struct Event: Codable {
    var idEvent: String?
    var idAPIfootball, strEvent, strEventAlternate, strFilename: String?
    var strSport, idLeague, strLeague, strSeason: String?
    var strHomeTeam, strAwayTeam, intHomeScore, intRound: String?
    var intAwayScore: String?
    var strTimestamp: String?
    var dateEvent: String?
    var strTime: String?
    var idHomeTeam, idAwayTeam: String?
    var strCountry: String?
    var strPostponed, strLocked: String?
}
