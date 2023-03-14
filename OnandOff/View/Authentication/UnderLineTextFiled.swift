//
//  UnderLineTextFiled.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/14.
//

import UIKit

enum InputType {
    case password
    case other
}

final class UnderLineTextField: UIView {
    private let inputType: InputType
    private var guideText: String?
    private let identifier: String
    
    weak var delegate: UnderLineTextFieldDelegate?
    
    var getText: String? {
        return self.textField.text
    }
    
    var underLineColor: UIColor? {
        get { return underLineView.backgroundColor }
        set { self.underLineView.backgroundColor = newValue }
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .notoSans(size: 13, family: .Bold)
        $0.textColor = .black
    }
    
    private let textField = UITextField().then {
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.textColor = .black
        $0.clearButtonMode = .whileEditing
        $0.font = .notoSans(size: 13)
    }
    
    private let underLineView = UIView().then {
        $0.backgroundColor = .darkGray
    }
    
    private let guideLabel = UILabel().then {
        $0.font = .notoSans(size: 10)
        $0.textColor = .text3
    }
    
    //MARK: - Init
    init(_ type: InputType, title: String, identifier: String) {
        self.identifier = identifier
        self.inputType = type
        self.titleLabel.text = title
        super.init(frame: .zero)
        self.addSubView()
        self.layout()
        self.addTarget()
        
        if type == .password {
            self.textField.isSecureTextEntry = true
            self.textField.clearsOnBeginEditing = true
        }
    }
    
    init(_ type: InputType, title: String, guide: String, identifier: String) {
        self.identifier = identifier
        self.guideText = guide
        self.inputType = type
        self.guideLabel.text = guide
        self.titleLabel.text = title
        super.init(frame: .zero)
        self.addSubView()
        self.addSubview(self.guideLabel)
        self.layoutWithGuide()
        self.addTarget()
        
        if type == .password {
            self.textField.isSecureTextEntry = true
            self.textField.clearsOnBeginEditing = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didChangeText(_ textfield: UITextField) {
        delegate?.didChangeText(textfield, identifier: self.identifier)
    }
    
    func warningGuideLabel(content: String) {
        self.guideLabel.text = content
        self.guideLabel.textColor = .point
        self.underLineColor = .point
    }
    
    func resetGuideLabel() {
        self.guideLabel.text = self.guideText
        self.guideLabel.textColor = .text3
        self.underLineColor = .darkGray
    }
    
    private func addSubView() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.textField)
        self.addSubview(self.underLineView)
        self.addSubview(self.guideLabel)
    }
    
    private func layout() {
        let contentText: NSString = self.titleLabel.text! as NSString
        let size = contentText.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 25),
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font : UIFont.notoSans(size: 14, family: .Bold)],
                                            context: nil)
        self.titleLabel.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
            $0.width.equalTo(size.width)
        }
        
        self.textField.snp.makeConstraints {
            $0.leading.equalTo(self.titleLabel.snp.trailing).offset(16)
            $0.trailing.centerY.equalToSuperview()
        }
        
        self.underLineView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    private func layoutWithGuide() {
        let contentText: NSString = self.titleLabel.text! as NSString
        let size = contentText.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: 25),
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font : UIFont.notoSans(size: 14, family: .Bold)],
                                            context: nil)
        self.titleLabel.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
            $0.width.equalTo(size.width)
        }
        
        self.textField.snp.makeConstraints {
            $0.leading.equalTo(self.titleLabel.snp.trailing).offset(16)
            $0.trailing.centerY.equalToSuperview()
        }
        
        self.underLineView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        self.guideLabel.snp.makeConstraints {
            $0.top.equalTo(self.underLineView.snp.bottom).offset(2)
            $0.leading.equalTo(self.titleLabel)
        }
    }
    
    private func addTarget() {
        self.textField.addTarget(self, action: #selector(self.didChangeText), for: .editingChanged)
    }
}
