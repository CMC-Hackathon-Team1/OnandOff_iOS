//
//  SpecificPostCell.swift
//  OnandOff
//
//  Created by 077tech on 2023/02/22.
//
import Foundation
import UIKit
import Then
import SnapKit


class SpecificPostCell: UICollectionViewCell {
    
//MARK: - Properties
    static let identifier = "SpecificPostCell"
    
    let closeButton = UIImageView().then{
        $0.image = UIImage(named: "close")?.withRenderingMode(.alwaysOriginal)
        $0.isHidden = true
    }
    let ellipsisButton = UIImageView().then{
        $0.image = UIImage(named: "ellipsis")?.withRenderingMode(.alwaysOriginal)
    }
    let profileImageView = UIImageView().then {
        $0.layer.cornerRadius = 20
        $0.backgroundColor = .lightGray
    }
    let nameLabel = UILabel().then {
        $0.text = "작가 키키"
        $0.textColor = .text1
        $0.font = .notoSans(size: 12, family: .Bold)
    }
    let dateLabel = UILabel().then {
        $0.text = "2022/09/24"
        $0.textColor = .text4
        $0.font = .notoSans(size: 11)
    }
    let tagLabel = UILabel().then {
        $0.text = "#시#소설#에세이 좋아해요"
        $0.textColor = .text4
        $0.font = .notoSans(size: 14, family: .Bold)
    }
    let heartButton = UIImageView().then{
        $0.image = UIImage(named: "heart")?.withRenderingMode(.alwaysOriginal)
    }
    let likeCountLabel: UILabel = {
        let label = UILabel()
        label.font = .notoSans(size: 11, family: .Regular)
        label.textColor = #colorLiteral(red: 0.5924945474, green: 0.5924944878, blue: 0.5924944282, alpha: 1)
        label.text = "12"
        label.sizeToFit()
        return label
    }()
    let postImageView = UIImageView().then {
        $0.image = UIImage(named: "photoButton")?.withRenderingMode(.alwaysOriginal)
    }
    let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "예전의 어린 나는 가슴 속에 나침반이 하나 있었다. 그래서 어디로 가야 할지 모를 때 가슴 속의 나침반이 나의 길로 나를 이끌었다. 언제부터인가 나는 돈에 집착하기 시작했고 가슴 속의 나침반은 어이상 작동하지 않았다. 몸에 쇳가루가 많이 묻으면 나침반은 돌지 않는법. 나의 순결한 나침반이 우울증을 앓던 날 나는 그렇게 나의 길을 잃었다. 박광수, <참 서툰 사람들>"
        label.font = .notoSans(size: 14)
        label.textColor = .text1
        label.numberOfLines = 0
        return label
    }()
    let lastline = UIView().then {
        $0.backgroundColor = UIColor.lightGray
    }
    
    let checkArray = ["heart","heart.fill"]
    var index = 0
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        layout()
        addTarget()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var parentViewController: UIViewController?
    
//MARK: - Selector
    @objc func didClickEllipsis(sender: UITapGestureRecognizer) {
        print("didClickEllipsis")
        let VC = EditOrDeleteViewController()
        VC.modalPresentationStyle = .fullScreen
        parentViewController?.present(VC, animated: true)
    }
    @objc func didClickClose(sender: UITapGestureRecognizer) {
        print("didClickClose")
        parentViewController?.dismiss(animated: true)
    }
    @objc func didClickHeart(sender: UITapGestureRecognizer) {
        print("didClickHeart")
        self.index = (self.index >= self.checkArray.count-1) ? 0 : self.index+1
        self.heartButton.image = UIImage(named:checkArray[index])
    }
    
    
//MARK: - addSubView
    func setUpView(){
        self.addSubview(self.closeButton)
        self.addSubview(self.ellipsisButton)
        self.addSubview(self.profileImageView)
        self.addSubview(self.nameLabel)
        self.addSubview(self.dateLabel)
        self.addSubview(self.heartButton)
        self.addSubview(self.likeCountLabel)
        self.addSubview(self.tagLabel)
        self.addSubview(self.postImageView)
        self.addSubview(self.contentLabel)
        self.addSubview(self.lastline)
    }
    
    
//MARK: - Layout
    func layout(){
        self.closeButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(20.8)
            $0.leading.equalToSuperview().offset(28.42)
        }
        self.ellipsisButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(26.5)
            $0.trailing.equalToSuperview().offset(-27.23)
        }
        self.profileImageView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(60)
            $0.leading.equalToSuperview().offset(24)
            $0.width.height.equalTo(42)
        }
        self.nameLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(65)
            $0.leading.equalTo(self.profileImageView.snp.trailing).offset(11)
        }
        self.dateLabel.snp.makeConstraints{
            $0.top.equalTo(self.nameLabel.snp.bottom).offset(0)
            $0.leading.equalTo(self.profileImageView.snp.trailing).offset(11)
        }
        self.heartButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(65.68)
            $0.trailing.equalToSuperview().offset(-25.03)
        }
        self.likeCountLabel.snp.makeConstraints{
            $0.top.equalTo(self.heartButton.snp.bottom).offset(1.79)
            $0.trailing.equalToSuperview().offset(-28)
        }
        self.tagLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(122)
            $0.leading.equalToSuperview().offset(24)
        }
        self.postImageView.snp.makeConstraints{
            $0.top.equalTo(self.tagLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(23)
            $0.trailing.equalToSuperview().offset(-23)
            $0.size.height.equalTo(342)
        }
        self.contentLabel.snp.makeConstraints{
            $0.top.equalTo(self.postImageView.snp.bottom).offset(28)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-32)
            $0.size.height.equalTo(142)
        }
        self.lastline.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(0)
            $0.size.height.equalTo(1)
            $0.leading.equalToSuperview().offset(13)
            $0.trailing.equalToSuperview().offset(-13)
        }
        
    }
    
//MARK: - AddTarget
    private func addTarget() {
        
        let Ellipsis = UITapGestureRecognizer(target: self, action: #selector(didClickEllipsis))
        ellipsisButton.isUserInteractionEnabled = true
        ellipsisButton.addGestureRecognizer(Ellipsis)
        
        let Close = UITapGestureRecognizer(target: self, action: #selector(didClickClose))
        closeButton.isUserInteractionEnabled = true
        closeButton.addGestureRecognizer(Close)
        
        let Heart = UITapGestureRecognizer(target: self, action: #selector(didClickHeart))
        heartButton.isUserInteractionEnabled = true
        heartButton.addGestureRecognizer(Heart)
    }
    
    
}
