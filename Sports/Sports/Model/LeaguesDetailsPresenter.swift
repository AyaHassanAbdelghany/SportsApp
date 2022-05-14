//
//  LeaguesDetailsPresenter.swift
//  Sports
//
//  Created by Rawan Bahnasy on 5/14/22.
//  Copyright © 2022 ayahassan. All rights reserved.
//

import Foundation

class LeaguesDetailsPresenter : LeaguesDetailsProtocol{
    var events :[Event]?
    var teams : [Team]?
    var networkManager :NetworkManagerProtocol
    weak var view : LeaguesProtocol!
    init(networkManager : NetworkManagerProtocol) {
        self.networkManager = networkManager
        
    }
    func attachView(view: LeaguesProtocol){
          self.view = view
      }
    
    func getEvents() {
          networkManager.fetchResponse(endUrl: "eventsseason.php", httpMethod: .get, parametrs: ["id":"4328"]) { [weak self] (result:Result<AllEvents, Error>) in
                           switch result {
                            case .success(let response):
                                self?.events = response.events ?? []
                             print("successful")
                          DispatchQueue.main.async {
                            self?.view.reloadUpcomingEventsCollectionView()
                            self?.view.stopAnimating()
                                  }
                           case .failure(let error):
                               print(error.localizedDescription)
                           }
                       }
    }
    
    func getTeams() {
        networkManager.fetchResponse(endUrl: "search_all_teams.php", httpMethod: .get, parametrs: ["s":"Soccer" , "c":"England"]) { [weak self] (result:Result<ListOfTeams, Error>) in
                         switch result {
                          case .success(let response):
                            self?.teams = response.teams ?? []
                           print("successful")
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
        return self.events?[index] ?? Event()
    }
    
    func getUpcomingEventCount() -> Int {
        return self.events?.count ?? 0
    }
    func getTeamsWithIndex(index: Int) -> Team {
        return self.teams?[index] ?? Team()
    }
    
    func getTeamsCount() -> Int {
        return self.teams?.count ?? 0
    }
    

}
