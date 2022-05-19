//
//  LeaguesDetailsPresenter.swift
//  Sports
//
//  Created by Rawan Bahnasy on 5/14/22.
//  Copyright © 2022 ayahassan. All rights reserved.
//

import Foundation
protocol Favorites
{
    var favLeague : League {get set}
}

class LeaguesDetailsPresenter : LeaguesDetailsProtocol , Favorites {
    var favLeague: League
    var dbService : DBManagerProtocal?
    var latestEvents :[Event]?
    var comingEvents :[Event]?
    var teams : [Team]?
    var networkManager :NetworkManagerProtocol
    weak var view : LeaguesProtocol!
   // var round : String = "38"
   // var sesson : String = "2021-2022"
    
    init(networkManager : NetworkManagerProtocol ,favLeague: League) {
        self.networkManager = networkManager
        self.favLeague = favLeague
        self.dbService = DBManager()
    }
    func attachView(view: LeaguesProtocol){
          self.view = view
      }
    
    func getLatestEvents(leagueID :String) {
          networkManager.fetchResponse(endUrl: "eventsseason.php", httpMethod: .get, parametrs: ["id":leagueID]) { [weak self] (result:Result<AllEvents, Error>) in
                           switch result {
                            case .success(let response):
                                self?.latestEvents = response.events ?? []
                             print("successfull fetching latest result")
                          DispatchQueue.main.async {
                            self?.view.reloadLatestEventsCollectionView()
                            self?.view.stopAnimating()
                                  }
                           case .failure(let error):
                               print(error.localizedDescription)
                           }
                       }
    }
    func getComingEvents(leagueID :String) {
        networkManager.fetchResponse(endUrl: "eventsseason.php", httpMethod: .get, parametrs: ["id":leagueID ]) { [weak self] (result:Result<AllEvents, Error>) in
                           switch result {
                            case .success(let response):
                                self?.comingEvents = response.events ?? []
                             print("successfull fetching comming events ")
                          DispatchQueue.main.async {
                            self?.view.reloadUpcomingEventsCollectionView()
                            self?.view.stopAnimating()
                                  }
                           case .failure(let error):
                               print(error.localizedDescription)
                           }
                       }
    }
    
    func getTeams(sportType :String,country: String) {
        networkManager.fetchResponse(endUrl: "search_all_teams.php", httpMethod: .get, parametrs: ["s":sportType , "c":country]) { [weak self] (result:Result<ListOfTeams, Error>) in
                         switch result {
                          case .success(let response):
                            self?.teams = response.teams ?? []
                           print("successfull fetching teams")
                        DispatchQueue.main.async {
                            self?.view.reloadTeamsCollectionView()
                          self?.view.stopAnimating()
                                }
                         case .failure(let error):
                             print(error.localizedDescription)
                         }
                     }
    }
    func getUpcomingEventWithIndex(index: Int) -> Event {
        return self.comingEvents?[index] ?? Event()
    }
    
    func getUpcomingEventCount() -> Int {
        return self.comingEvents?.count ?? 0
    }
    func getLatestEventWithIndex(index: Int) -> Event {
        return self.latestEvents?[index] ?? Event()
    }
    
    func getLatestEventCount() -> Int {
        return self.latestEvents?.count ?? 0
    }
    func getTeamsWithIndex(index: Int) -> Team {
        return self.teams?[index] ?? Team()
    }
    
    func getTeamsCount() -> Int {
        return self.teams?.count ?? 0
    }
    
    func addToDatabase(_ _flag : Bool) {
        favLeague.isFavorite = _flag
        dbService?.insertLeague(league: favLeague)
    }
    
    func getFlag(league : League) -> Bool {
        guard let obj = dbService?.searchForLeague(league.strLeague ?? "") else { print ("Not Found"); return false }
        return true
    }
    func deleteFromDatabase(_ _flag : Bool)
    {
        favLeague.isFavorite = _flag
        guard let objToBeDeleted = dbService?.searchForLeague(favLeague.strLeague ?? "") else { print ("Not Found"); return }
        dbService?.deleteObject(objToBeDeleted)
    }
}
