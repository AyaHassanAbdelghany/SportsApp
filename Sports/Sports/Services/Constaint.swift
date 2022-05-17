//
//  Constaint.swift
//  Sports
//
//  Created by ayahassan on 5/16/22.
//  Copyright © 2022 ayahassan. All rights reserved.
//

import Foundation
import UIKit
import Network

class Constaint{
    
    static func checkNetwork() -> Bool{
              let monitor = NWPathMonitor()
              var flag: Bool = false

              monitor.pathUpdateHandler = { pathUpdateHandler in
                  if pathUpdateHandler.status != .satisfied{
                      flag = true
                  }else{
                      flag = false
                  }
              }
              let queue = DispatchQueue(label: "InternetConnectionMonitor")
              monitor.start(queue: queue)
              return flag
          }
      
}
