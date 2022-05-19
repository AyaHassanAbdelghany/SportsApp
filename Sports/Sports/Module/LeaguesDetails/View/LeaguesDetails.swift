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
    func reloadLatestEventsCollectionView()
}

class LeaguesDetails: UIViewController, UICollectionViewDataSource , UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    var flag : Bool = false

    @IBAction func favoritePressed(_ sender: UIButton) {
        switchFavorite(button: sender)

    }
    
    
    @IBAction func backPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)

    }
    
    var league  = League()

    
    @IBOutlet weak var favouritButton: UIButton!
    let indicator = UIActivityIndicatorView(style: .large)
    @IBOutlet weak var upcomingEvents: UICollectionView!
    
    @IBOutlet weak var latestResult: UICollectionView!
    
    @IBOutlet weak var teams: UICollectionView!

    
    var detailsPresenter : LeaguesDetailsPresenter!
    let CollectionViewCellUpComingEventsID = "CollectionViewCellUpComingEvents"
    
    let CollectionViewCellTeamsID = "CollectionViewCellTeams"
    let CollectionViewCellResultID = "CollectionViewCellResult"
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
        return detailsPresenter.getLatestEventCount()
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        let inset:CGFloat = 10
//        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let eventCell = upcomingEvents.dequeueReusableCell(withReuseIdentifier: CollectionViewCellUpComingEventsID, for : indexPath ) as! CollectionViewCellUpComingEvents
        let event = detailsPresenter.getUpcomingEventWithIndex(index: indexPath.row)
        eventCell.img.kf.setImage(with: URL(string: event.strThumb ?? "" ), placeholder: UIImage(named: "background"))
        eventCell.eventName.text = event.strEvent
        eventCell.eventDate.text = event.dateEvent
        eventCell.eventTime.text = event.strTime

        if(collectionView == teams){
            let teamsCell = teams.dequeueReusableCell(withReuseIdentifier: CollectionViewCellTeamsID, for : indexPath) as! CollectionViewCellTeams
            let team = detailsPresenter.getTeamsWithIndex(index: indexPath.row)
            teamsCell.teamsImg.kf.setImage(with: URL(string: team.strTeamBadge ?? "" ))
            return teamsCell
        }
        if (collectionView == latestResult){
            let resultCell = latestResult.dequeueReusableCell(withReuseIdentifier: CollectionViewCellResultID, for: indexPath) as! CollectionViewCellResult
            let result = detailsPresenter.getLatestEventWithIndex(index: indexPath.row)
            resultCell.resultTeams.text = result.strEvent
            resultCell.homeScore.text = result.intHomeScore
            resultCell.awayScore.text = result.intAwayScore
            resultCell.date.text = result.dateEvent
            resultCell.matchTime.text = result.strTime
            resultCell.resultImg.image = UIImage(named: "result")
            return resultCell
            
        }
        return eventCell
        
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.center = self.view.center
         self.view.addSubview(indicator)
         indicator.startAnimating()
        detailsPresenter = LeaguesDetailsPresenter(networkManager: NetworkManager(),favLeague: league)
        detailsPresenter.attachView(view: self)
        let nibCellResult = UINib(nibName: CollectionViewCellResultID , bundle : nil)
        latestResult.register(nibCellResult, forCellWithReuseIdentifier: CollectionViewCellResultID)
        
        let nibCellTeams = UINib(nibName: CollectionViewCellTeamsID, bundle: nil)
        teams.register(nibCellTeams, forCellWithReuseIdentifier: CollectionViewCellTeamsID)
        let nibCell = UINib(nibName: CollectionViewCellUpComingEventsID, bundle: nil)
        upcomingEvents.register(nibCell, forCellWithReuseIdentifier: CollectionViewCellUpComingEventsID)
        if let layout = upcomingEvents.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        detailsPresenter.getComingEvents(leagueID: (league.idLeague)!)
        detailsPresenter.getLatestEvents(leagueID: (league.idLeague)!)
        detailsPresenter.getTeams(sportType: league.strSport!, country: league.strCountry!)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Flag = \(flag)")
       flag = detailsPresenter?.getFlag(league: league) ?? false
        configureUI()
        print("Flag = \(flag)")
    }
    private func configureUI()
    {
        if (flag)
              {
                  favouritButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
              }
              else
              {
                  favouritButton.setImage(UIImage(systemName: "heart"), for: .normal)
              }

    }
    
        func switchFavorite(button : UIButton ){
        switch flag {
            case true:
                detailsPresenter?.deleteFromDatabase(!flag)
                favouritButton.setImage(UIImage(systemName: "heart"), for: .normal)
                break
            case false:
                detailsPresenter?.addToDatabase(!flag)
                favouritButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)

                break
            }
            flag = !flag

            print(flag)
            
        }
        
        
    }

 


extension LeaguesDetails : LeaguesProtocol{
    func reloadLatestEventsCollectionView() {
        self.latestResult.reloadData()
    }
    
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

