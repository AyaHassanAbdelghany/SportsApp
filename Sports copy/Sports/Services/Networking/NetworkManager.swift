//
//  NetworkManager.swift
//  Sports
//
//  Created by ayahassan on 5/13/22.
//  Copyright © 2022 ayahassan. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager:NetworkManagerProtocol{
    
    let baseUrl = "https://www.thesportsdb.com/api/v1/json/2/"

    func fetchResponse<T>(endUrl: String, httpMethod: HTTPMethod, parametrs: [String : String], complitionHandler: @escaping (Swift.Result<T, Error>) -> Void) where T : Decodable {
        let url = URL(string: baseUrl + endUrl)!
        
        Alamofire.request(url, method: httpMethod, parameters: parametrs).responseJSON { (response) in
            guard let data = response.data else { return }
                do {
                    let response = try JSONDecoder().decode(T.self, from: data)
                    complitionHandler(.success(response))
                } catch {
                    complitionHandler(.failure(error))
                }
            }
    }
    
    
    
}
