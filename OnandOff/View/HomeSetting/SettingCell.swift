//
//  SettingCell.swift
//  OnandOff
//
//  Created by 077tech on 2023/02/08.
//
import UIKit
import SnapKit
import Then

final class SettingCell: UICollectionViewCell {
    //MARK: - Properties
    static let identifier = "SettingCell"
    
    let settingImage = UIImageView().then{
        $0.image = UIImage(named: "")?.withRenderingMode(.alwaysOriginal)
    }
    var title = UILabel().then{
        $0.text = "설정 이름"
        $0.font = .notoSans(size: 14)
    }
    
    let arrow = UIImageView().then{
        $0.image = UIImage(named: "rightArrow")?.withRenderingMode(.alwaysOriginal)
    }
    let line = UIView().then{
        $0.backgroundColor = UIColor.systemGray4
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
    
    
    //MARK: - addSubView
    private func setupView(){
        self.addSubview(settingImage)
        self.addSubview(title)
        self.addSubview(arrow)
        self.addSubview(line)
    }
    
    //MARK: - layout
    private func setupLayout(){
        self.settingImage.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(35.75)
            $0.width.height.equalTo(25)
        }
        self.title.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(settingImage.snp.trailing).offset(20.75)
        }
        self.arrow.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-41)
            $0.width.equalTo(4.69)
            $0.height.equalTo(9.38)
        }
        self.line.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(31)
            $0.trailing.equalToSuperview().offset(-31)
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview()
        }
        
    }
    
    //MARK: - AddTarget
    private func addTarget(){
        
    }
    
    
}
