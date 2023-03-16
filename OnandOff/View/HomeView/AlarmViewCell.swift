//
//  AlarmViewCell.swift
//  OnandOff
//
//  Created by 077tech on 2023/02/17.
//
import UIKit
import SnapKit
import Then

final class AlarmViewCell: UICollectionViewCell {
    //MARK: - Properties
    static let identifier = "SettingCell"
    
    let imageViewMain = UIImageView().then{
        $0.image = UIImage(named: "megaphone")?.withRenderingMode(.alwaysOriginal)
    }
    var title = UILabel().then{
        $0.text = "2.0 버전 업데이트 안내"
        $0.font = UIFont(name:"NotoSans-Bold", size: 14)
    }
    
    var timeLabel = UILabel().then{
        $0.text = "4시간 전"
        $0.font = .notoSans(size: 12)
        $0.textColor = .systemGray4
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
        
        self.backgroundColor = .white
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selector
    
    
    //MARK: - addSubView
    private func setupView(){
        self.addSubview(imageViewMain)
        self.addSubview(title)
        self.addSubview(timeLabel)
        self.addSubview(arrow)
        self.addSubview(line)
    }
    
    //MARK: - layout
    private func setupLayout(){
        self.imageViewMain.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(35.75)
            $0.width.height.equalTo(25)
        }
        self.title.snp.makeConstraints{
            $0.top.equalToSuperview().offset(7)
            $0.leading.equalTo(imageViewMain.snp.trailing).offset(20.75)
        }
        self.timeLabel.snp.makeConstraints{
            $0.top.equalTo(title.snp.bottom).offset(2)
            $0.leading.equalTo(imageViewMain.snp.trailing).offset(20.75)
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
