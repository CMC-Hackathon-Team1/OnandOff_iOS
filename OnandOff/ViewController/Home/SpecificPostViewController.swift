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
    //MARK: - Properties
    let mainCollectionView =  UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(SpecificPostCell.self, forCellWithReuseIdentifier: SpecificPostCell.identifier)
        $0.backgroundColor = .white

        if let layout = $0.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
        }
        $0.showsHorizontalScrollIndicator = false
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray
        
        setUpView()
        layout()
        addTarget()
        
        self.mainCollectionView.delegate = self
        self.mainCollectionView.dataSource = self
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
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpecificPostCell.identifier, for: indexPath) as! SpecificPostCell
        cell.parentViewController = self
        if indexPath.row == 0{
            cell.closeButton.isHidden = false
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
