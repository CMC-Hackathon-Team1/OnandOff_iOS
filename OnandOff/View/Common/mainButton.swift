//
//  mainButton.swift
//  OnandOff
//
//  Created by 신상우 on 2023/02/18.
//

import UIKit

class mainButton: UIButton {

    override var isEnabled: Bool {
        didSet {
            let color: UIColor =  isEnabled ? .mainColor : .text3
            self.backgroundColor = color
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .mainColor
        self.layer.cornerRadius = 5
        self.titleLabel?.font = .notoSans(size: 16, family: .Bold)
        self.setTitleColor(.white, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
