//
//  ReportCell.swift
//  OnandOff
//
//  Created by 신상우 on 2023/02/16.
//

import UIKit

final class ReportCell: UITableViewCell {
    static let identifier = "ReportCell"
    
    let checkImageView = UIImageView().then {
        $0.image = UIImage(named: "anonymousCheckOff")
        $0.contentMode = .scaleAspectFill
    }
    
    let describtionLabel = UILabel().then {
        $0.textColor = .black
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(self.checkImageView)
        self.addSubview(self.describtionLabel)
        
        self.checkImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().offset(14)
            $0.bottom.equalToSuperview().offset(-14)
            $0.width.height.equalTo(20)
        }
        
        self.describtionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.bottom.trailing.equalToSuperview().offset(-14)
            $0.leading.equalTo(self.checkImageView.snp.trailing).offset(9)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
