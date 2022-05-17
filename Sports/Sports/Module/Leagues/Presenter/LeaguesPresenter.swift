//
//  LeaguesPresenter.swift
//  Sports
//
//  Created by ayahassan on 5/13/22.
//  Copyright © 2022 ayahassan. All rights reserved.
//

import Foundation

class LeaguePresenter :LeaguePresenterProtocol{
 
    var leagues :[League]!
    var networkManager :NetworkManagerProtocol
   var leagueView : LeaguesViewProtocal!
    
       init(networkManager : NetworkManagerProtocol) {
              self.networkManager = networkManager
          }
    
    func attachView(view: LeaguesViewProtocal) {
        self.leagueView = view
       }
    
    func getLeagues(leagueName :String) {
        networkManager.fetchResponse(endUrl: "search_all_leagues.php", httpMethod: .get, parametrs: ["s":leagueName]) { [weak self] (result:Result<AllLeagues, Error>) in
            switch result {
                
            case .success(let response):
                self?.leagues = response.countries ?? []
            case .failure(let error):
                print(error.localizedDescription)
            }
            DispatchQueue.main.async {
                print(self!.leagues.count)
                self!.leagueView.renderTableView(leagues: self?.leagues ?? [])

                }
        }
       
    }
    
}
