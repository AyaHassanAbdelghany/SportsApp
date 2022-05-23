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
    
    static var flagNetwork :Bool = true
    
    static func checkNetwork(){
              let monitor = NWPathMonitor()

                    monitor.pathUpdateHandler = { pathUpdateHandler in
                        if pathUpdateHandler.status == .satisfied{
                            flagNetwork = true
        
                        }else{
                            flagNetwork = false
                        }
                    }
                    let queue = DispatchQueue(label: "InternetConnectionMonitor")
                    monitor.start(queue: queue)
          }
      
}
