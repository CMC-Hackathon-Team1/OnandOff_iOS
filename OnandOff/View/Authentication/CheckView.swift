//
//  CheckView.swift
//  OnandOff
//
//  Created by e2phus on 2023/02/17.
//


import UIKit
import SnapKit

protocol CheckViewDelegate: AnyObject {
    func tapAgreeButton(_ view: UIView)
}

class CheckView: UIView {
    
    weak var delegate: CheckViewDelegate?
    
    init(firstSentence: String, secondSentence: String, checkButton: UIButton, imageName: String?) {
        super.init(frame: .zero)
        
        let label = UILabel()
        let attributedTitle = NSMutableAttributedString(string: firstSentence,
                                                        attributes: [.font: UIFont.notoSans(size: 14, family: .Bold),
                                                                    .foregroundColor: #colorLiteral(red: 0.4056565464, green: 0.7636143565, blue: 0.6924937367, alpha: 1)])
        attributedTitle.append(NSAttributedString(string: secondSentence,
                                                  attributes: [.font: UIFont.notoSans(size: 14, family: .Bold),
                                                               .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]))
        label.attributedText = attributedTitle

        lazy var nextImage: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: imageName ?? "")
            return imageView
        }()
        
        addSubview(checkButton)
        checkButton.snp.makeConstraints {
            $0.left.equalTo(snp.left)
            $0.centerY.equalTo(snp.centerY)
            $0.height.width.equalTo(30)
        }
        
        addSubview(label)
        label.snp.makeConstraints {
            $0.centerY.equalTo(checkButton.snp.centerY)
            $0.height.equalTo(14)
            $0.left.equalTo(checkButton.snp.right).offset(9)
            // $0.right.equalTo(snp.right).offset(24)
        }
        
        addSubview(nextImage)
        nextImage.snp.makeConstraints {
            $0.right.equalTo(snp.right)
            $0.centerY.equalTo(checkButton.snp.centerY)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapCheckButton() {
        print(#function)
        delegate?.tapAgreeButton(self)
    }
}
