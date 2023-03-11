//
//  TextFieldComponent.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/07.
//

import UIKit

final class TextFieldComponent: UIView {
    let titleLabel = UILabel().then {
        $0.font = .notoSans(size: 12, family: .Bold)
        $0.textColor = .black
        $0.sizeToFit()
    }
    
    let inputTextfield = UITextField().then {
        $0.textColor = .black
        $0.font = .notoSans(size: 12, family: .Regular)
    }
    
    private var lineLayer: CALayer?
    
    init(title: String) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        
        self.addSubview(self.titleLabel)
        self.addSubview(self.inputTextfield)
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        if self.lineLayer == nil {
            _ = CALayer().then {
                $0.backgroundColor = UIColor.text4.cgColor
                self.layer.addSublayer($0)
                self.lineLayer = $0
                $0.frame = CGRect(x: 0,
                                  y: self.frame.height,
                                  width: self.frame.width,
                                  height: 1)
            }
        }
    }
    
    private func layout() {
        let contentText: NSString = self.titleLabel.text! as NSString
        let size = contentText.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 25),
                                                   options: .usesLineFragmentOrigin,
                                                   attributes: [.font : UIFont.notoSans(size: 13)],
                                                   context: nil)
        
        self.titleLabel.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
            $0.width.equalTo(size.width)
        }
        
        self.inputTextfield.snp.makeConstraints {
            $0.leading.equalTo(self.titleLabel.snp.trailing).offset(16)
            $0.centerY.trailing.equalToSuperview()
        }
    }
}

