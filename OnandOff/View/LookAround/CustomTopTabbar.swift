//
//  CustomTopTabbar.swift
//  OnandOff
//
//  Created by SangWoo's MacBook on 2023/01/01.
//

import UIKit
import Then
import SnapKit

enum topTabBarItem {
    case exploration
    case following
}

final class CustomTopTabbar: UIView {
    //MARK: - Properties
    var selectedItem: topTabBarItem = .exploration
    weak var delegate: TopTapBarDelegate?
    
    private let explorationButton = UIButton(type: .system).then {
        $0.setTitle("탐색", for: .normal)
        $0.setTitleColor(.mainColor, for: .normal)
        $0.titleLabel?.font = .notoSans(size: 14, family: .Bold)
        $0.tag = 0
    }
    
    private let followingButton = UIButton(type: .system).then {
        $0.setTitle("팔로잉", for: .normal)
        $0.setTitleColor(.text4, for: .normal)
        $0.titleLabel?.font = UIFont.notoSans(size: 14)
        $0.tag = 1
    }
    
    private var lineLayer: CALayer?
    private var indicatorLayer: CALayer?
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubView()
        self.layout()
        self.addTarget()
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
        
        if self.indicatorLayer == nil {
            _ = CALayer().then {
                $0.backgroundColor = UIColor.mainColor.cgColor
                self.layer.addSublayer($0)
                self.indicatorLayer = $0
                $0.frame = CGRect(x: 0,
                                  y: self.frame.height-0.5,
                                  width: self.frame.width/2,
                                  height: 2)
            }
        }
    }
    
    //MARK: - Method
    private func highlightFollwing() {
        UIView.animate(withDuration: 1.0) {
            self.indicatorLayer!.frame = .init(x: self.frame.width/2,
                                              y: self.frame.height-0.5,
                                              width: self.frame.width/2,
                                              height: 2)
        }
        
        self.followingButton.setTitleColor(.mainColor, for: .normal)
        self.followingButton.titleLabel?.font = .notoSans(size: 14, family: .Bold)
        
        self.explorationButton.setTitleColor(.text4, for: .normal)
        self.explorationButton.titleLabel?.font = .notoSans(size: 14)
        
        self.selectedItem = .following
        self.delegate?.didClickFollwingItem()
    }
    
    private func highlightExploration() {
        UIView.animate(withDuration: 1.0) {
            self.indicatorLayer!.frame = .init(x: 0,
                                              y: self.frame.height-0.5,
                                              width: self.frame.width/2,
                                              height: 2)
        }
        
        self.followingButton.setTitleColor(.text4, for: .normal)
        self.followingButton.titleLabel?.font = .notoSans(size: 14)
        
        self.explorationButton.setTitleColor(.mainColor, for: .normal)
        self.explorationButton.titleLabel?.font = .notoSans(size: 14, family: .Bold)
        
        self.selectedItem = .exploration
        self.delegate?.didClickExplorationItem()
    }
    
    //MARK: - Selector
    @objc private func didClickTopTabBar(_ button: UIButton) {
        switch button.tag {
        case 0: self.highlightExploration()
        case 1: self.highlightFollwing()
        default: break
        }
    }
    
    //MARK: - addSubView
    private func addSubView() {
        self.addSubview(self.explorationButton)
        self.addSubview(self.followingButton)
    }
    
    //MARK: - Layout
    private func layout() {
        self.explorationButton.snp.makeConstraints {
            $0.leading.top.bottom.equalTo(self)
            $0.trailing.equalTo(self.snp.centerX)
        }
        
        self.followingButton.snp.makeConstraints {
            $0.trailing.top.bottom.equalTo(self)
            $0.leading.equalTo(self.snp.centerX)
        }
    }
    
    //MARK: - AddTarget
    private func addTarget() {
        self.explorationButton.addTarget(self, action: #selector(self.didClickTopTabBar(_:)), for: .touchUpInside)
        self.followingButton.addTarget(self, action: #selector(self.didClickTopTabBar(_:)), for: .touchUpInside)
    }
}
