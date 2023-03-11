//
//  SpecificPostViewController.swift
//  OnandOff
//
//  Created by 077tech on 2023/01/07.
//


import Foundation
import UIKit
import Then
import SnapKit


class SpecificPostViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    //MARK: - Datasource
    var feedImgListArray = [String]()
    var hashTagListArray = [String]()
    var feedIndivIdArray = [Int]()
    var personaNameArray = [String]()
    var profileNameArray = [String]()
    var feedContentArray = [String]()
    var profileImgArray = [String]()
    var createdAtArray = [String]()
    var isLikeArray = [Bool]()
    var isFollowingArray = [Bool]()
    
    //MARK: - Properties
    let mainCollectionView =  UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(SpecificPostCell.self, forCellWithReuseIdentifier: SpecificPostCell.identifier)
        $0.backgroundColor = .white

        if let layout = $0.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
        $0.showsHorizontalScrollIndicator = false
    }
    
    
    var feedIdArray = [Int]()
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray
        
        setUpView()
        layout()
        addTarget()
        
        print("adssadas")
        print(feedIdArray)
        print("adssadas")
        self.mainCollectionView.delegate = self
        self.mainCollectionView.dataSource = self
        
        feedImgListArray = []
        hashTagListArray = []
        feedIndivIdArray = []
        personaNameArray = []
        profileNameArray = []
        feedContentArray = []
        profileImgArray = []
        createdAtArray = []
        isLikeArray = []
        isFollowingArray = []
        
        if feedIdArray.count != 0{
            for i in 0...feedIdArray.count-1{
    //            GetSpecificPostDataRequest().getSpecificPostRequestData(self, feedId: feedIdArray[i], profileId: 3114)
                GetSpecificPostDataRequest().getSpecificPostRequestData(self, feedId: 1, profileId: 1610)
                mainCollectionView.reloadData()
            }
        }

    }
    
    //MARK: - Alamofire
    func didSuccessGetSpecificPost(_ response: GetSpecificPostModel){
        print("didSuccessGetSpecificPost")
        
        feedImgListArray.append(response.feedImgList![0]!)
        hashTagListArray.append(response.hashTagList![0]!)
        feedIndivIdArray.append(response.feedId!)
        personaNameArray.append(response.personaName!)
        profileNameArray.append(response.profileName!)
        feedContentArray.append(response.feedContent!)
        profileImgArray.append(response.profileImg!)
        createdAtArray.append(response.createdAt!)
        isLikeArray.append(response.isLike!)
        isFollowingArray.append(response.isFollowing!)
        
        print(feedImgListArray)
        print(hashTagListArray)
        print(feedIndivIdArray)
        print(personaNameArray)
        print(profileNameArray)
        print(feedContentArray)
        print(profileImgArray)
        print(createdAtArray)
        print(isLikeArray)
        print(isFollowingArray)
        
        print("didSuccessGetSpecificPost")
    }
    //MARK: - Selector
    
    //MARK: - addSubView
    func setUpView(){
        self.view.addSubview(self.mainCollectionView)
        
    }
    
    
    //MARK: - Layout
    func layout(){
        self.mainCollectionView.snp.makeConstraints{
            $0.bottom.top.trailing.leading.equalToSuperview()
        }
        
        
    }
    
    //MARK: - AddTarget
    private func addTarget() {
        
    }
    
    //MARK: COLLECTIONVIEW
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedIdArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpecificPostCell.identifier, for: indexPath) as! SpecificPostCell
        cell.parentViewController = self
        if indexPath.row == 0{
            cell.closeButton.isHidden = false
        }
        
        if personaNameArray.count != 0{
            cell.nameLabel.text = "\(personaNameArray[indexPath.row]) \(profileNameArray[indexPath.row])"
            cell.dateLabel.text = "\(createdAtArray[indexPath.row])"
            cell.tagLabel.text = "\(hashTagListArray[indexPath.row])"
            cell.contentLabel.text = "\(feedContentArray[indexPath.row])"
        }
        

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width , height: self.view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpecificPostCell.identifier, for: indexPath) as! SpecificPostCell
        
        
    }
}
