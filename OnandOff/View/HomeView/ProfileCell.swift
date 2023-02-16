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
    let borderView = UIView().then{
        $0.backgroundColor = .mainColor
        $0.roundCorners(cornerRadius: 25, maskedCorners: [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner])
    }
    let profileImage = UIImageView().then{
        $0.backgroundColor = .white
        $0.roundCorners(cornerRadius: 25, maskedCorners: [.layerMaxXMaxYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMinYCorner])
    }
    let profileName = UILabel().then{
        $0.text = "페르소나"
        $0.font = UIFont(name:"appleSDGothicNeo-Regular", size: 12)
        $0.textColor = .gray
        $0.textAlignment = .center
    }
    let plusButton = UIImageView().then{
        $0.image = UIImage(named: "ProfileMakePlus")?.withRenderingMode(.alwaysOriginal)
        $0.isHidden = true
    }

    
//MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.setupLayout()
        self.addTarget()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selector
//    @objc func didClickProfile(sender: UITapGestureRecognizer) {
//            print("didClickProfile")
//        }
    //MARK: - addSubView
    private func setupView(){
        self.addSubview(self.borderView)
        borderView.addSubview(self.profileImage)
        self.addSubview(self.profileName)
        profileImage.addSubview(self.plusButton)
    }
    
    //MARK: - layout
    private func setupLayout(){
        self.borderView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(5)
            $0.height.width.equalTo(50)
        }
        self.profileImage.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.width.equalTo(47)
        }
        self.profileName.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.profileImage.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview()
        }
        plusButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(15)
        }

    }
    
    //MARK: - AddTarget
    private func addTarget(){
        
        }
    }



