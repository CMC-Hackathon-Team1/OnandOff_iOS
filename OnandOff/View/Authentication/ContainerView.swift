//
//  ContainerView.swift
//  OnandOff
//
//  Created by e2phus on 2023/02/10.
//

import UIKit
import SnapKit

protocol ContainerViewDelegate: AnyObject {
    func resetTextField(_ view: UIView)
}

class ContainerView: UIView {
    
    weak var delegate: ContainerViewDelegate?
    
    init(title: String, textField: UITextField, leftOffset: UInt) {
        super.init(frame: .zero)
        let label = UILabel()
        label.text = title
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        
        lazy var cancelButton: UIButton = {
            let button = UIButton(type: .system)
            button.setImage(#imageLiteral(resourceName: "Icon"), for: .normal)
            button.tintColor = #colorLiteral(red: 0.7810429931, green: 0.7810428739, blue: 0.7810428739, alpha: 1)
            button.snp.makeConstraints {
                $0.height.width.equalTo(16)
            }
            button.clipsToBounds = true
            button.layer.cornerRadius = 16 / 2
            button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
            return button
        }()
        
        addSubview(label)
        label.snp.makeConstraints {
            $0.left.equalTo(snp.left)
            $0.height.equalTo(18)
            $0.centerY.equalTo(snp.centerY)
        }
        
        addSubview(textField)
        textField.snp.makeConstraints {
            $0.centerY.equalTo(snp.centerY)
            $0.height.equalTo(18)
            $0.left.equalTo(snp.left).offset(leftOffset)
            // $0.right.equalTo(snp.right).offset(24)
        }
        
        addSubview(cancelButton)
        cancelButton.snp.makeConstraints {
            $0.centerY.equalTo(label.snp.centerY)
            $0.right.equalTo(snp.right)
        }
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func cancelButtonTapped() {
        delegate?.resetTextField(self)
    }
}
