//
//  FavouriteSportsTableViewCell.swift
//  Sports
//
//  Created by ayahassan on 5/16/22.
//  Copyright © 2022 ayahassan. All rights reserved.
//

import UIKit

class FavouriteSportsTableViewCell: UITableViewCell {

    @IBOutlet var leagueName: UILabel!
    @IBOutlet var imageLeague: UIImageView!
  
      var openYoutube :(() ->Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    @IBAction func btnYoutube(_ sender: UIButton) {
        openYoutube()
       }
}
