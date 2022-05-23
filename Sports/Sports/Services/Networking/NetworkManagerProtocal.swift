//
//  NetworkManagerProtocal.swift
//  Sports
//
//  Created by ayahassan on 5/13/22.
//  Copyright © 2022 ayahassan. All rights reserved.
//

import Foundation
import Alamofire


protocol NetworkManagerProtocol{
    func fetchResponse <T: Decodable>(endUrl: String, httpMethod: HTTPMethod ,parametrs : [String:String] , complitionHandler: @escaping (Swift.Result<T, Error>) -> Void)
}
