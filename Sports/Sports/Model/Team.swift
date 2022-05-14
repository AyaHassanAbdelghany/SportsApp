//
//  Team.swift
//  Sports
//
//  Created by Rawan Bahnasy on 5/13/22.
//  Copyright © 2022 ayahassan. All rights reserved.
//

import Foundation

struct ListOfTeams : Decodable {
    var teams : [Team]?
}

struct Team : Decodable {
    
    var strTeam : String?
    var intFormedYear, strLeague, strStadium, strStadiumThumb, strDescriptionEN, strFacebook, strTwitter, strTeamBadge, strTeamJersey : String?
}
