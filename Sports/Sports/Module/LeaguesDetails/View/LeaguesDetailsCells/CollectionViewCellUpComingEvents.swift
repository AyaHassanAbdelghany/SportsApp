//
//  CollectionViewCellUpComingEvents.swift
//  Sports
//
//  Created by Rawan Bahnasy on 5/13/22.
//  Copyright © 2022 ayahassan. All rights reserved.
//

import UIKit

class CollectionViewCellUpComingEvents: UICollectionViewCell {

    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var eventName: UILabel!
    
    @IBOutlet weak var eventDate: UILabel!
    
    @IBOutlet weak var eventTime: UILabel!
    override func awakeFromNib() {
        img.clipsToBounds = true
        img.layer.cornerRadius = 20

        super.awakeFromNib()
        // Initialization code
    }

}
