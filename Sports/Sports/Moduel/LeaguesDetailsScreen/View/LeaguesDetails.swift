//
//  LeaguesDetails.swift
//  Sports
//
//  Created by Rawan Bahnasy on 5/12/22.
//  Copyright © 2022 ayahassan. All rights reserved.
//

import UIKit
class LeaguesDetails: UIViewController, UICollectionViewDataSource , UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var upcomingEvents: UICollectionView!
    
    @IBOutlet weak var latestResult: UICollectionView!
    
    @IBOutlet weak var teams: UICollectionView!
    let CollectionViewCellUpComingEventsID = "CollectionViewCellUpComingEvents"
    
    let CollectionViewCellTeamsID = "CollectionViewCellTeams"
    
    var events = [Event]()
    var teamsArr = [Team]()
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == upcomingEvents ){
            return events.count
        }
        if (collectionView == teams){
            return 5
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
        let event = events[indexPath.row]
        eventCell.img.image = UIImage(named: "up_coming")
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
         //   let team = teamsArr[indexPath.row]
            teamsCell.teamsImg.image = UIImage(named:"Real_Madrid")
            return teamsCell
        }
        return eventCell
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    let nibCellTeams = UINib(nibName: CollectionViewCellTeamsID, bundle: nil)
    teams.register(nibCellTeams, forCellWithReuseIdentifier: CollectionViewCellTeamsID)
        
        let nibCell = UINib(nibName: CollectionViewCellUpComingEventsID, bundle: nil)
        upcomingEvents.register(nibCell, forCellWithReuseIdentifier: CollectionViewCellUpComingEventsID)
        if let layout = upcomingEvents.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
//        upcomingEvents.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
      
        
        for _ in 1...5{
            var event = Event()
            event.strEvent = "A vs B"
            event.dateEvent = "5/13/2022"
            event.strTime = "3:00"
            events.append(event)
        }
        upcomingEvents.reloadData()
        teams.reloadData()
        // Do any additional setup after loading the view.
    }
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let header =  upcomingEvents.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath) as! HeaderCollectionReusableView
//        header.configure()
//        return header
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: view.frame.size.width, height: 10)
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


