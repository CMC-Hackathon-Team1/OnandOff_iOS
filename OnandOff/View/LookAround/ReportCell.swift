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
        $0.contentMode = .scaleAspectFit
    }
    
    let describtionLabel = UILabel().then {
        $0.textColor = .black
    }
    
    let otherTextField = UITextField().then {
        let attribute = NSAttributedString(string: "기타 신고 사유를 입력하세요. (20자 이내)",
                                           attributes: [.foregroundColor : UIColor.lightGray,
                                                        .font : UIFont.notoSans(size: 12)])
        $0.attributedPlaceholder = attribute
        $0.attributedText = attribute
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .white
        
        self.contentView.addSubview(self.checkImageView)
        self.contentView.addSubview(self.describtionLabel)
        self.contentView.addSubview(self.otherTextField)
        
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
        
        self.otherTextField.snp.makeConstraints {
            $0.leading.equalTo(self.describtionLabel.snp.leading)
            $0.trailing.equalToSuperview().offset(-40)
            $0.top.equalTo(self.checkImageView.snp.bottom)
            $0.height.equalTo(20)
        }
        _ = UIView().then { // UnderLine
            $0.backgroundColor = .lightGray
            self.otherTextField.addSubview($0)
            $0.snp.makeConstraints { make in
                make.height.equalTo(1)
                make.leading.trailing.equalToSuperview()
                make.bottom.equalToSuperview()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }  
}
