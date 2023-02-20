//
//  CheckView.swift
//  OnandOff
//
//  Created by e2phus on 2023/02/17.
//


import UIKit
import SnapKit

// protocol ContainerViewDelegate: AnyObject {
//     func resetTextField(_ view: UIView)
// }

class CheckView: UIView {
    
    // weak var delegate: ContainerViewDelegate?
    
    init(firstSentence: String, secondSentence: String, imageName: String?) {
        super.init(frame: .zero)
        
        let label = UILabel()
        let attributedTitle = NSMutableAttributedString(string: firstSentence,
                                                        attributes: [.font: UIFont.notoSans(size: 14, family: .Bold),
                                                                    .foregroundColor: #colorLiteral(red: 0.4056565464, green: 0.7636143565, blue: 0.6924937367, alpha: 1)])
        attributedTitle.append(NSAttributedString(string: secondSentence,
                                                  attributes: [.font: UIFont.notoSans(size: 14, family: .Bold),
                                                               .foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]))
        label.attributedText = attributedTitle

        lazy var checkButton: UIButton = {
            let button = UIButton(type: .system)
            button.setImage(#imageLiteral(resourceName: "anonymousCheckOff"), for: .normal)
            button.tintColor = #colorLiteral(red: 0.1529411765, green: 0.1450980392, blue: 0.1215686275, alpha: 1)
            button.snp.makeConstraints {
                $0.height.width.equalTo(16)
            }
            button.clipsToBounds = true
            button.layer.cornerRadius = 16 / 2
            button.addTarget(self, action: #selector(didTapcheckButton), for: .touchUpInside)
            return button
        }()
        
        lazy var nextImage: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: imageName ?? "")
            return imageView
        }()
        
        addSubview(checkButton)
        checkButton.snp.makeConstraints {
            $0.left.equalTo(snp.left)
            $0.centerY.equalTo(snp.centerY)
        }
        
        addSubview(label)
        label.snp.makeConstraints {
            $0.centerY.equalTo(snp.centerY)
            $0.height.equalTo(14)
            $0.left.equalTo(checkButton.snp.right).offset(9)
            // $0.right.equalTo(snp.right).offset(24)
        }
        
        addSubview(nextImage)
        nextImage.snp.makeConstraints {
            $0.right.equalTo(snp.right)
            $0.centerY.equalTo(snp.centerY)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapcheckButton() {
        print(#function)
        // delegate?.resetTextField(self)
    }
}
