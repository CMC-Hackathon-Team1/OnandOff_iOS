//
//  MyPageCell.swift
//  OnandOff
//
//  Created by e2phus on 2023/01/03.
//
import UIKit
import SnapKit

final class MyPageCell: UICollectionViewCell {
   
    // MARK: - Properties
    private let identifier = "MyPageCell"
    
    private let postDateLabel: UILabel = {
        let label = UILabel()
        label.font = .notoSans(size: 14, family: .Bold)
        label.textColor = .black
        label.text = "2022/09/24"
        label.sizeToFit()
        return label
    }()
    
    private lazy var heartButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "heart.fill"), for: .normal)
        button.addTarget(self, action: #selector(didTapHeartButton), for: .touchUpInside)
        return button
    }()
    
    private let likeCountLabel: UILabel = {
        let label = UILabel()
        label.font = .notoSans(size: 11, family: .Regular)
        label.textColor = #colorLiteral(red: 0.5924945474, green: 0.5924944878, blue: 0.5924944282, alpha: 1)
        label.text = "12"
        label.sizeToFit()
        return label
    }()
    
    private lazy var ellipsisButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "ellipsis"), for: .normal)
        button.addTarget(self, action: #selector(didTapEllipsisButton), for: .touchUpInside)
        return button
    }()
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "carrot")?.withRenderingMode(.alwaysOriginal)
        return imageView
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "MyContent"
        label.font = .notoSans(size: 14)
        label.textColor = .text1
        return label
    }()


    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
        self.addSubView()
        self.configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @objc func didTapHeartButton() {
        print(#function)
    }
    
    @objc func didTapEllipsisButton() {
        print(#function)
    }
    
    // MARK: - Helpers
    private func configure() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = .init(width: 1, height: 1)
        self.layer.shadowOpacity = 0.7
        self.layer.position = self.center
    }
    
    private func addSubView() {
        self.addSubview(self.postDateLabel)
        self.addSubview(self.heartButton)
        self.addSubview(self.likeCountLabel)
        self.addSubview(self.ellipsisButton)
        self.addSubview(self.postImageView)
        self.addSubview(self.contentLabel)
    }
    
    private func configureLayout() {
        postDateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(16)
            // make.width.equalTo(74)
            // make.height.equalTo(21)
        }
        
        heartButton.snp.makeConstraints { make in
            make.centerY.equalTo(postDateLabel)
            make.leading.equalToSuperview().offset(268)
            make.width.equalTo(12)
            make.height.equalTo(12)
        }
        
        likeCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(postDateLabel)
            make.leading.equalToSuperview().offset(286)
            // make.width.equalTo(12)
            // make.height.equalTo(17)
        }
        
        
        ellipsisButton.snp.makeConstraints { make in
            make.centerY.equalTo(postDateLabel)
            make.leading.equalToSuperview().offset(315)
            make.width.equalTo(12)
            make.height.equalTo(12)
        }
        
        postImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(postDateLabel).offset(16)
            make.width.height.equalTo(299)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(postImageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
        }
    }
}
