//
//  LeaguesDetails.swift
//  Sports
//
//  Created by Rawan Bahnasy on 5/12/22.
//  Copyright © 2022 ayahassan. All rights reserved.
//

import UIKit
import Kingfisher

protocol LeaguesProtocol : AnyObject{
    func stopAnimating()
    func reloadUpcomingEventsCollectionView()
    func reloadTeamsCollectionView()
}
class LeaguesDetails: UIViewController, UICollectionViewDataSource , UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    let indicator = UIActivityIndicatorView(style: .large)
    @IBOutlet weak var upcomingEvents: UICollectionView!
    
    @IBOutlet weak var latestResult: UICollectionView!
    
    @IBOutlet weak var teams: UICollectionView!
    
    var detailsPresenter : LeaguesDetailsPresenter!
    let CollectionViewCellUpComingEventsID = "CollectionViewCellUpComingEvents"
    
    let CollectionViewCellTeamsID = "CollectionViewCellTeams"
    let networkManager = NetworkManager()
    
    var events = [Event]()
    var teamsArr = [Team]()
    var sports = [Sport]()
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == upcomingEvents ){
            return detailsPresenter.getUpcomingEventCount()
        }
        if (collectionView == teams){
            return detailsPresenter.getTeamsCount()
        }
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset:CGFloat = 10
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 130)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let eventCell = upcomingEvents.dequeueReusableCell(withReuseIdentifier: CollectionViewCellUpComingEventsID, for : indexPath ) as! CollectionViewCellUpComingEvents
        let event = detailsPresenter.getUpcomingEventWithIndex(index: indexPath.row)
        eventCell.img.image = UIImage(named: "up_coming")
       // eventCell.img.kf.setImage(with: URL(string: event.strThumb ?? "" ))
        eventCell.eventName.text = event.strEvent
        eventCell.eventDate.text = event.dateEvent
        eventCell.eventTime.text = event.strTime
        if (collectionView == latestResult){
            let cell2 = latestResult.dequeueReusableCell(withReuseIdentifier: "cell2" , for : indexPath ) as! CollectionViewCellResults
            cell2.backgroundColor = UIColor.blue
            return cell2
        }
        if(collectionView == teams){
            let teamsCell = teams.dequeueReusableCell(withReuseIdentifier: CollectionViewCellTeamsID, for : indexPath) as! CollectionViewCellTeams
            let team = detailsPresenter.getTeamsWithIndex(index: indexPath.row)
            teamsCell.teamsImg.kf.setImage(with: URL(string: team.strTeamBadge ?? "" ))
            return teamsCell
        }
        return eventCell
        
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.center = self.view.center
         self.view.addSubview(indicator)
         indicator.startAnimating()
        detailsPresenter = LeaguesDetailsPresenter(networkManager: NetworkManager())
        detailsPresenter.attachView(view: self)
      
        
        let nibCellTeams = UINib(nibName: CollectionViewCellTeamsID, bundle: nil)
        teams.register(nibCellTeams, forCellWithReuseIdentifier: CollectionViewCellTeamsID)
        let nibCell = UINib(nibName: CollectionViewCellUpComingEventsID, bundle: nil)
        upcomingEvents.register(nibCell, forCellWithReuseIdentifier: CollectionViewCellUpComingEventsID)
        if let layout = upcomingEvents.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        teams.reloadData()
        detailsPresenter.getEvents()
        detailsPresenter.getTeams()
        
        
    }
}
extension LeaguesDetails : LeaguesProtocol{
    func reloadTeamsCollectionView() {
        self.teams.reloadData()
    }
    
    func stopAnimating() {
        indicator.stopAnimating()
        
    }
    func reloadUpcomingEventsCollectionView() {
       self.upcomingEvents.reloadData()
      }
     
 }

