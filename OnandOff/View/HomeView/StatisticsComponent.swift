//
//  StatisticsComponent.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/09.
//

import UIKit

final class StatisticsComponent: UIView {
    //MARK: - Properties
    let imageIconLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 50)
        $0.textAlignment = .center
    }
    
    let statisticLabel = UILabel().then {
        $0.contentMode = .top
        $0.textColor = .black
        $0.font = .notoSans(size: 12, family: .Regular)
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.imageIconLabel)
        self.addSubview(self.statisticLabel)
        self.layout()
        
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func highlightColor(_ text: String, pointStr: String) {
        let attribute = NSMutableAttributedString(string: text)
        attribute.addAttribute(.foregroundColor, value: UIColor.mainColor, range: (text as NSString).range(of: pointStr))
        self.statisticLabel.attributedText = attribute
    }
    
    private func layout() {
        self.imageIconLabel.snp.makeConstraints {
            $0.centerX.top.equalToSuperview()
            $0.width.height.equalTo(60)
        }
        
        self.statisticLabel.snp.makeConstraints {
            $0.width.equalTo(92)
            $0.top.equalTo(self.imageIconLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
    }
}
