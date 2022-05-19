//
//  FavouriteSportsViewController.swift
//  Sports
//
//  Created by ayahassan on 5/16/22.
//  Copyright © 2022 ayahassan. All rights reserved.
//

import UIKit
import CoreData
import Network


protocol FavouriteSportsViewProtocal {
    //func renderTableView(leagues:[League])
    func renderTableView()
}
class FavouriteSportsViewController: UIViewController {

    @IBOutlet var favouriteSportTable: UITableView!
    var favouritePresenter :FavouritePresenterProtocol!
     var favleagues = [League]()
    override func viewWillAppear(_ animated: Bool) {
        favleagues = favouritePresenter.getLFavLeagues()
        renderTableView()
        print(favleagues.count)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.favouriteSportTable.register(UINib(nibName: "FavouriteSportsTableViewCell", bundle: nil), forCellReuseIdentifier: "favouriteCell")
        self.favouriteSportTable.delegate = self
        self.favouriteSportTable.dataSource = self
        
        favouritePresenter = FavouritePresenter(dbManager: DBManager())
        favouritePresenter.attachView(view :self)
        
        
    }
    
}



extension FavouriteSportsViewController : FavouriteSportsViewProtocal{
    func renderTableView() {
        self.favouriteSportTable.reloadData()
    }
    
}
extension FavouriteSportsViewController :UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favleagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = favouriteSportTable.dequeueReusableCell(withIdentifier: "favouriteCell", for: indexPath) as! FavouriteSportsTableViewCell
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 3, height: 3)
        cell.layer.shadowRadius = 4
        cell.layer.shadowOpacity = 0.3
        cell.layer.masksToBounds = false
        
        let youtubeUrl = URL(string:"https://"+self.favleagues[indexPath.row].strYoutube!)
       
        cell.openYoutube = {
            if(Constaint.checkNetwork()){
                self.ShowAlert()}
            else{
        if UIApplication.shared.canOpenURL(youtubeUrl! ){
            UIApplication.shared.open(youtubeUrl!)
           }
        }
        }
             cell.leagueName.text = favleagues[indexPath.row].strLeague
        
                      cell.imageLeague.layer.borderWidth = 1
                       cell.imageLeague.layer.masksToBounds = false
                       cell.imageLeague.layer.borderColor = UIColor.black.cgColor
                       cell.imageLeague.layer.cornerRadius = cell.imageLeague.frame.height/2
                       cell.imageLeague.clipsToBounds = true
             cell.imageLeague.kf.setImage(with :URL(string: favleagues[indexPath.row].strBadge!),placeholder :UIImage(named:"sportDefault.jpg"))

             return cell
    }
    
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete{
            favouritePresenter.deleteLeague(indexPath:indexPath.row)
            favleagues.remove(at: indexPath.row)
         self.favouriteSportTable.deleteRows(at: [indexPath], with: .automatic)
         }
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(Constaint.checkNetwork()){
                       self.ShowAlert()
            
        }
        else{
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
         let leaguesDetailsVC = storyboard.instantiateViewController(withIdentifier:"leagueDetails") as? LeaguesDetails
        leaguesDetailsVC?.league = favleagues[indexPath.row]
        leaguesDetailsVC?.modalPresentationStyle = .fullScreen
         present(leaguesDetailsVC!, animated: true, completion: nil)
        }
    }
    
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return 108
        }
     func ShowAlert(){
           let alert = UIAlertController(title: "Sorry", message: "No Internt Connection ,you cann't open youtube without internet.", preferredStyle: .alert)
           let cancelBtn = UIAlertAction(title: "Cancel", style: .default, handler: nil)
           alert.addAction(cancelBtn)
           self.present(alert, animated: true, completion: nil)
       }
    
      
         
}
