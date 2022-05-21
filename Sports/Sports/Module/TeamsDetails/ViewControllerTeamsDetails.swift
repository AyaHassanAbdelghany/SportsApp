//
//  ViewControllerTeamsDetails.swift
//  Sports
//
//  Created by Rawan Bahnasy on 5/20/22.
//  Copyright © 2022 ayahassan. All rights reserved.
//

import UIKit
import Kingfisher

class ViewControllerTeamsDetails: UIViewController {
    var team : Team?

    @IBOutlet weak var teamsImg: UIImageView!
    
    @IBOutlet weak var teamName: UILabel!
    
    @IBOutlet weak var teamDesc: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        teamName.text = team?.strTeam
        teamDesc.text = team?.strDescriptionEN
        teamsImg.kf.setImage(with: URL(string: team?.strStadiumThumb ?? "" ), placeholder: UIImage(named: "std"))

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
