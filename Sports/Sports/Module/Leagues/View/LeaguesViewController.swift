//
//  LeaguesViewController.swift
//  Sports
//
//  Created by ayahassan on 5/14/22.
//  Copyright © 2022 ayahassan. All rights reserved.
//

import UIKit
import Network


protocol LeaguesViewProtocal {
    
    func renderTableView(leagues:[League])
    func setLeagueName(leagueName :String)
}

class LeaguesViewController: UIViewController{

     var leaguesPresenter :LeaguePresenterProtocol!
    var leagues = [League]()
    private var name: String?

    
    @IBOutlet var leagueTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.leagueTable.register(UINib(nibName: "LeagueTableViewCell", bundle: nil), forCellReuseIdentifier: "leagueCell")
        self.leagueTable.delegate = self
        self.leagueTable.dataSource = self
        
        
        leaguesPresenter = LeaguePresenter(networkManager: NetworkManager())
        leaguesPresenter.attachView(view :self)
        leaguesPresenter.getLeagues(leagueName: name!)
    }

}


extension LeaguesViewController :LeaguesViewProtocal{
    func setLeagueName(leagueName: String) {
        name = leagueName
    }
    
    func renderTableView(leagues:[League]) {
        self.leagues = leagues
        self.leagueTable.reloadData()
    }
    
    
}

extension LeaguesViewController :UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeagueTableViewCell
           cell.layer.shadowColor = UIColor.black.cgColor
               cell.layer.shadowOffset = CGSize(width: 3, height: 3)
               cell.layer.shadowRadius = 4
               cell.layer.shadowOpacity = 0.3
               cell.layer.masksToBounds = false
        
        let youtubeUrl = URL(string:"https://"+self.leagues[indexPath.row].strYoutube!)
       
        cell.openYoutube = {
            if(!Constaint.flagNetwork){
                self.ShowAlert()}
            else{
        if UIApplication.shared.canOpenURL(youtubeUrl! ){
            UIApplication.shared.open(youtubeUrl!)
           }
        }
        }
             cell.leagueName.text = leagues[indexPath.row].strLeague
        
              cell.imageLeague.layer.borderWidth = 1
                cell.imageLeague.layer.masksToBounds = false
                cell.imageLeague.layer.borderColor = UIColor.black.cgColor
                cell.imageLeague.layer.cornerRadius = cell.imageLeague.frame.height/2
                cell.imageLeague.clipsToBounds = true
             cell.imageLeague.kf.setImage(with :URL(string: leagues[indexPath.row].strBadge!),placeholder :UIImage(named:"sportDefault.jpg"))

             return cell
    }
    
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
             return 108
         }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
         let leaguesDetailsVC = storyboard.instantiateViewController(withIdentifier:"leagueDetails") as? LeaguesDetails
        leaguesDetailsVC?.league = leagues[indexPath.row]
        leaguesDetailsVC?.modalPresentationStyle = .fullScreen
         present(leaguesDetailsVC!, animated: true, completion: nil)

    }
   
     func ShowAlert(){
           let alert = UIAlertController(title: "Sorry", message: "No Internt Connection ", preferredStyle: .alert)
           let cancelBtn = UIAlertAction(title: "Cancel", style: .default, handler: nil)
           alert.addAction(cancelBtn)
           self.present(alert, animated: true, completion: nil)
       }
    
}
