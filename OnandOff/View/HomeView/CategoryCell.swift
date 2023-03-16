//
//  CategoryCell.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/10.
//

import UIKit

final class CategoryCell: UITableViewCell {
    static let identifier = "CategoryCell"
    
    let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    let nameLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .notoSans(size: 14)
    }
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(self.iconImageView)
        self.addSubview(self.nameLabel)
        
        self.layout()
        
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureImage(_ id: Int) {
        if id == 1 {
            self.iconImageView.image = UIImage(named: "culture")?.withRenderingMode(.alwaysOriginal)
        } else if id == 2 {
            self.iconImageView.image = UIImage(named: "sport")?.withRenderingMode(.alwaysOriginal)
        } else if id == 3 {
            self.iconImageView.image = UIImage(named: "selfdev")?.withRenderingMode(.alwaysOriginal)
        } else if id == 4 {
            self.iconImageView.image = UIImage(named: "ellipsis")?.withRenderingMode(.alwaysOriginal)
        }
    }
    
    private func layout() {
        self.iconImageView.snp.makeConstraints {
            $0.width.equalTo(24)
            $0.height.equalTo(36)
            $0.leading.equalToSuperview().offset(24)
            $0.centerY.equalToSuperview()
        }
        
        self.nameLabel.snp.makeConstraints {
            $0.leading.equalTo(self.iconImageView.snp.trailing).offset(15)
            $0.centerY.equalToSuperview()
        }
    }
}
