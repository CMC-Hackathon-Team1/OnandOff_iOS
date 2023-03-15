//
//  ReportActionSheet.swift
//  OnandOff
//
//  Created by 신상우 on 2023/02/16.
//

import UIKit

final class ReportActionSheet: UIView {
    weak var delegate: LookAroundDelegate?
    private let feedId: Int
    
    private let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular)).then {
        $0.alpha = 0.5
    }
    
    private let frameView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.layer.shadowOpacity = 1.0
        $0.layer.shadowOffset = .zero
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "신고하기"
        $0.font = .notoSans(size: 14)
        $0.textColor = .black
    }
    
    let cancelButton = UIButton(type: .system).then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = .black
    }
    
    let reportFeedButton = UIButton(type: .system).then {
        let image = UIImage(named: "Warning")?.withRenderingMode(.alwaysOriginal)
        let title = "게시글 신고하기"
        
        if #available (iOS 15.0, *) {
            var configure = UIButton.Configuration.plain()
            configure.image = image
            configure.title = "게시글 신고하기"
            configure.baseForegroundColor = .black
            configure.imagePadding = 20
            configure.imagePlacement = .leading
            $0.configuration = configure
        } else {
            //ios 15미만  이미지 - 텍스트 패딩 처리 해주어야함
            $0.setImage(image, for: .normal)
            $0.setTitle(title, for: .normal)
            $0.setTitleColor(.black, for: .normal)
        }
    }
    
    //MARK: - Init
    init(_ feedId: Int) {
        self.feedId = feedId
        super.init(frame: .zero)
        self.addSubView()
        self.layout()
        self.addTarget() 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - addTarget
    private func addTarget() {
        self.cancelButton.addTarget(self, action: #selector(self.willRemoveFromSuperView), for: .touchUpInside)
        self.reportFeedButton.addTarget(self, action: #selector(self.didClickReportButton), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.willRemoveFromSuperView))
        self.blurEffectView.addGestureRecognizer(tap)
    }
    
    //MARK: - Selector
    @objc private func willRemoveFromSuperView() {
        self.removeFromSuperview()
    }
    
    @objc private func didClickReportButton() {
        self.removeFromSuperview()
        NotificationCenter.default.post(name: .presentReportVC, object: self.feedId)
    }
    
    //MARK: - AddSubView
    private func addSubView() {
        self.addSubview(self.blurEffectView)
        self.addSubview(self.frameView)
        
        self.frameView.addSubview(self.titleLabel)
        self.frameView.addSubview(self.cancelButton)
        self.frameView.addSubview(self.reportFeedButton)
    }
    
    //MARK: - Layout
    private func layout() {
        self.blurEffectView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
        
        self.frameView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(104)
        }
        
        self.titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(18.5)
        }
        
        self.cancelButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(22)
            $0.top.equalToSuperview().offset(23)
            $0.width.height.equalTo(13)
        }
        
        self.reportFeedButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(22)
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(13)
        }
    }
}
