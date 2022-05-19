//
//  CollectionViewCell.swift
//  Sports
//
//  Created by Rawan Bahnasy on 5/17/22.
//  Copyright © 2022 ayahassan. All rights reserved.
//

import UIKit

class CollectionViewCellResult: UICollectionViewCell {
    
    @IBOutlet weak var resultImg: UIImageView!
    
    @IBOutlet weak var resultTeams: UILabel!
    
    @IBOutlet weak var homeScore: UILabel!
    
    @IBOutlet weak var awayScore: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var matchTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
