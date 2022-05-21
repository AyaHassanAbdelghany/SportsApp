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

    @IBAction func favoritePressed(_ sender: UIButton) {
        switchFavorite(button: sender)

    }
    
    
    @IBAction func backPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)

    }
    
    
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
    var league  = League()
    var events = [Event]()
    var teamsArr = [Team]()
    var sports = [Sport]()
      var flag : Bool = false
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == upcomingEvents ){
            print("testoooo",detailsPresenter.getUpcomingEventCount())
            return detailsPresenter.getUpcomingEventCount()-1
        }
        if (collectionView == teams){
            return detailsPresenter.getTeamsCount()
        }
        return detailsPresenter.getLatestEventCount()
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
           switch collectionView {
              case teams:
        let detailsTeamsVC = self.storyboard?.instantiateViewController(withIdentifier:"teamsDetails") as? ViewControllerTeamsDetails
        detailsTeamsVC?.team = teamsArr[indexPath.row]
        present(detailsTeamsVC!, animated: true, completion: nil)
            break
            default:
            break
        }
        
    }
          
       
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let eventCell = upcomingEvents.dequeueReusableCell(withReuseIdentifier: CollectionViewCellUpComingEventsID, for : indexPath ) as! CollectionViewCellUpComingEvents
        if(detailsPresenter.getUpcomingEventCount()>0){
        let event = detailsPresenter.getUpcomingEventWithIndex(index: indexPath.row)
        eventCell.img.kf.setImage(with: URL(string: event.strThumb ?? "" ), placeholder: UIImage(named: "eventsbg"))
        eventCell.eventName.text = event.strEvent
        eventCell.eventDate.text = event.dateEvent
        eventCell.eventTime.text = event.strTime
        }
        if(collectionView == teams){
            let teamsCell = teams.dequeueReusableCell(withReuseIdentifier: CollectionViewCellTeamsID, for : indexPath) as! CollectionViewCellTeams
            if(detailsPresenter.getTeamsCount()>0){
            let team = detailsPresenter.getTeamsWithIndex(index: indexPath.row)
                teamsCell.teamsImg.kf.setImage(with: URL(string: team.strTeamBadge ?? "" ))
                teamsArr.append(team)
            }
            
            return teamsCell
        }
        if (collectionView == latestResult){
            let resultCell = latestResult.dequeueReusableCell(withReuseIdentifier: CollectionViewCellResultID, for: indexPath) as! CollectionViewCellResult
            if(detailsPresenter.getLatestEventCount()>0){
            let result = detailsPresenter.getLatestEventWithIndex(index: indexPath.row)
            resultCell.resultTeams.text = result.strEvent
            resultCell.homeScore.text = result.intHomeScore
            resultCell.awayScore.text = result.intAwayScore
            resultCell.date.text = result.dateEvent
            resultCell.matchTime.text = result.strTime
                resultCell.resultImg.kf.setImage(with: URL(string: result.strThumb ?? "" ), placeholder: UIImage(named: "eventsbg"))
            }
            return resultCell
        }
        return eventCell
        
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .horizontal
           layout.itemSize = CGSize(width:
            upcomingEvents.frame.width, height: upcomingEvents.frame.height)
           upcomingEvents.collectionViewLayout = layout
        let latestLayout = UICollectionViewFlowLayout()
        latestLayout.scrollDirection = .vertical
                  latestLayout.itemSize = CGSize(width:
                   latestResult.frame.width, height: latestResult.frame.height)
                  latestResult.collectionViewLayout = latestLayout
        let teamsLayout = UICollectionViewFlowLayout()
        teamsLayout.scrollDirection = .horizontal
                         teamsLayout.itemSize = CGSize(width:
                          teams.frame.width/2, height: teams.frame.height)
                         teams.collectionViewLayout = teamsLayout
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
        detailsPresenter.getEvents(leagueID: (league.idLeague)!)
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

