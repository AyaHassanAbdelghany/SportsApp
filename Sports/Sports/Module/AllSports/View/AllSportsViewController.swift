//
//  AllSportsViewController.swift
//  Sports
//
//  Created by ayahassan on 5/13/22.
//  Copyright © 2022 ayahassan. All rights reserved.
//

import UIKit
import Kingfisher


protocol AllSportsViewProtocal {
    
    func renderCollectionView(sports:[Sport])
}


class AllSportsViewController: UIViewController,UICollectionViewDelegateFlowLayout{

    @IBOutlet var collectionSports: UICollectionView!
    var allSportsPresenter :AllSportsPresenterProtocol!
    var sports = [Sport]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Constaint.checkNetwork()
        self.collectionSports.delegate = self
        self.collectionSports.dataSource = self
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
         layout.itemSize = CGSize(width: (collectionSports.frame.width) / 2 , height: (collectionSports.frame.width / 4) )
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
         collectionSports!.collectionViewLayout = layout
        
        
        allSportsPresenter = AllSportsPresenter(networkManager: NetworkManager())
        allSportsPresenter.attachView(view :self)
        allSportsPresenter.getAllSports()
    }

}


extension AllSportsViewController :AllSportsViewProtocal{
    
    func renderCollectionView(sports :[Sport]) {
        self.sports = sports
        collectionSports.reloadData()
      }
}
extension AllSportsViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
           return 1
       }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sportCell", for: indexPath) as! AllSportsCollectionViewCell
        
                cell.layer.shadowOpacity = 0.3
                cell.layer.shadowOffset = CGSize(width: 4, height: 4)
                cell.layer.shadowColor = UIColor.black.cgColor
                cell.viewSport.layer.cornerRadius = cell.imageSport.frame.height/3
                cell.viewSport.layer.borderColor = UIColor.black.cgColor
        
        cell.nameSport.text = sports[indexPath.row].strSport
        cell.imageSport.kf.setImage(with :URL(string: sports[indexPath.row].strSportThumb!),placeholder :UIImage(named:"sportDefault.jpg"))

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let leaguesVC = storyboard.instantiateViewController(withIdentifier:"leagues") as? LeaguesViewProtocal
        leaguesVC?.setLeagueName(leagueName: sports[indexPath.row].strSport ?? "" )
        navigationController?.pushViewController(leaguesVC! as! LeaguesViewController, animated: true)
    }
    
   }
