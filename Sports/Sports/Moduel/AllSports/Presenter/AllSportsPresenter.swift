//
//  AllSportsPresenter.swift
//  Sports
//
//  Created by ayahassan on 5/13/22.
//  Copyright © 2022 ayahassan. All rights reserved.
//

import Foundation

class AllSportsPresenter :AllSportsPresenterProtocol{
    
    var sports :[Sport]!
    var networkManager :NetworkManagerProtocol
    
    init(networkManager : NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func getAllSports() {
        networkManager.fetchResponse(endUrl: "all_sports.php", httpMethod: .get, parametrs: [:]) { [weak self] (result:Result<AllSports, Error>) in
            switch result {
            case .success(let response):
                self?.sports = response.sports ?? []
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
