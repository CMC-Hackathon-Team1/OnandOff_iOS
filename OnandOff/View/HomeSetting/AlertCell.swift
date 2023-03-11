//
//  SettingCell.swift
//  OnandOff
//
//  Created by 077tech on 2023/02/08.
//
import UIKit
import SnapKit
import Then

final class AlertCell: UICollectionViewCell {
    //MARK: - Properties
    static let identifier = "AlertCell"
    

    var mainTitle = UILabel().then{
        $0.text = "Main"
        $0.font = UIFont(name:"NotoSans-Bold", size: 14)
    }
    var subTitle = UILabel().then{
        $0.text = "Sub"
        $0.font = UIFont(name:"NotoSans-Regular", size: 14)
    }
    let onoffToggle = UIImageView().then{
        $0.image = UIImage(named: "toggleoff")?.withRenderingMode(.alwaysOriginal)
    }
    
    let toggleArray = ["toggleoff","toggleon"]
    var toggleIndex = 0
    
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
    @objc func didClickToggle(sender: UITapGestureRecognizer){
        self.toggleIndex = (self.toggleIndex >= self.toggleArray.count-1) ? 0 : self.toggleIndex+1
        self.onoffToggle.image = UIImage(named:toggleArray[toggleIndex])
        if self.toggleIndex == 0{
            print(toggleIndex)
        }else{
            print(toggleIndex)
        }
    }
    
    //MARK: - addSubView
    private func setupView(){
        self.addSubview(mainTitle)
        self.addSubview(subTitle)
        self.addSubview(onoffToggle)
    }
    
    //MARK: - layout
    private func setupLayout(){
        self.mainTitle.snp.makeConstraints{
            $0.top.equalToSuperview().offset(18)
            $0.leading.equalToSuperview().offset(31)
        }
        self.subTitle.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-18)
            $0.leading.equalToSuperview().offset(31)
        }
        self.onoffToggle.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-33.5)
            $0.width.equalTo(35)
            $0.height.equalTo(30)
        }
        
    }
    
    //MARK: - AddTarget
    private func addTarget(){
        let toggleBtn = UITapGestureRecognizer(target: self, action: #selector(didClickToggle))
        onoffToggle.isUserInteractionEnabled = true
        onoffToggle.addGestureRecognizer(toggleBtn)
    }
    
    
}
