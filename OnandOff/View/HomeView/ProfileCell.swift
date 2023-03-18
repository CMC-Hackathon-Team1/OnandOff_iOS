//
//  ProfileCell.swift
//  OnandOff
//
//  Created by 077tech on 2023/02/11.
//


import UIKit

final class ProfileCell: UICollectionViewCell {
    //MARK: - Properties
    static let identifier = "ProfileCell"
    
    let profileImageView = UIImageView().then{
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.text3.cgColor
        $0.layer.cornerRadius = 26.5
        $0.contentMode = .center
        $0.layer.masksToBounds = true
        $0.backgroundColor = .white
    }
    
    let profileNameLabel = UILabel().then{
        $0.text = "페르소나"
        $0.font = UIFont(name:"appleSDGothicNeo-Regular", size: 12)
        $0.textColor = .gray
        $0.textAlignment = .center
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.layout()
        self.addTarget()
        
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        self.profileImageView.contentMode = .scaleAspectFit
        self.profileImageView.image = nil
        self.profileImageView.layer.borderWidth = 1
        self.profileImageView.layer.borderColor = UIColor.text3.cgColor
    }
    
    func configureSelectedItem() {
        self.profileImageView.layer.borderWidth = 2
        self.profileImageView.layer.borderColor = UIColor.mainColor.cgColor
    }
    
    // MARK: - Selector
    
    //MARK: - addSubView
    private func setupView(){
        self.addSubview(self.profileImageView)
        self.addSubview(self.profileNameLabel)
    }
    
    //MARK: - layout
    private func layout() {
        self.profileImageView.snp.makeConstraints {
            $0.centerX.top.equalToSuperview()
            $0.height.width.equalTo(53)
        }
        
        self.profileNameLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.profileImageView.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    //MARK: - AddTarget
    private func addTarget(){
        
    }
}



