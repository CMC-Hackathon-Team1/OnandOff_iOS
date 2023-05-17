//
//  BlockProfileCell.swift
//  OnandOff
//
//  Created by 신상우 on 2023/05/18.
//

import UIKit

final class BlockProfileCell: UITableViewCell {
    static let identifier = "BlockProfileCell"
    
    //MARK: - Properties
    private let profileImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 26.5
    }
    
    private let nameLabel = UILabel().then {
        $0.font = .notoSans(size: 14, family: .Bold)
        $0.textColor = .text1
        $0.text = "테스트 네임"
    }
    
    private let unBlockButton = UIButton(type: .system).then {
        var configure = UIButton.Configuration.filled()
        var attString = AttributedString("차단 해제")
        attString.font = .notoSans(size: 13, family: .Regular)
        configure.titlePadding = 0.5
        configure.attributedTitle = attString
        configure.baseBackgroundColor = .mainColor
        configure.baseForegroundColor = .white
        $0.configuration = configure
        $0.layer.cornerRadius = 6
    }
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        self.selectionStyle = .none
        
        self.addSubView()
        self.layout()
        self.addTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selector
    @objc private func didClickUnLockButton() {
        //해제할 profile ID object로 전달하기
        NotificationCenter.default.post(name: .unBlockProfile, object: nil)
    }
    
    //MARK: - AddSubView
    private func addSubView() {
        self.contentView.addSubview(self.profileImageView)
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.unBlockButton)
    }
    
    //MARK: - Layout
    private func layout() {
        self.profileImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(26)
            $0.width.height.equalTo(53)
            $0.centerY.equalToSuperview()
        }
        
        self.nameLabel.snp.makeConstraints {
            $0.leading.equalTo(self.profileImageView.snp.trailing).offset(12)
            $0.centerY.equalTo(self.profileImageView)
        }
        
        self.unBlockButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(26)
            $0.centerY.equalTo(self.profileImageView)
        }
    }
    
    private func addTarget() {
        self.unBlockButton.addTarget(self, action: #selector(self.didClickUnLockButton), for: .touchUpInside)
    }
}
