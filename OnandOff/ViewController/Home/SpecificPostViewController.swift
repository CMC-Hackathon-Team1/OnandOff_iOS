//
//  SpecificPostViewController.swift
//  OnandOff
//
//  Created by 077tech on 2023/01/07.
//

import Foundation
import UIKit
import Then
import SnapKit


class SpecificPostViewController: UIViewController {
//MARK: - Properties
    let mainView = UIView().then{
        $0.backgroundColor = .white
        $0.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
    }
    let closeButton = UIImageView().then{
        $0.image = UIImage(named: "close")?.withRenderingMode(.alwaysOriginal)
    }
    let ellipsisButton = UIImageView().then{
        $0.image = UIImage(named: "ellipsis")?.withRenderingMode(.alwaysOriginal)
    }
    private let profileImageView = UIImageView().then {
        $0.layer.cornerRadius = 26.5
        $0.backgroundColor = .lightGray
    }
    private let nameLabel = UILabel().then {
        $0.text = "작가 키키"
        $0.textColor = .text1
        $0.font = .notoSans(size: 14, family: .Bold)
    }
    private let dateLabel = UILabel().then {
        $0.text = "2022/09/24"
        $0.textColor = .text4
        $0.font = .notoSans(size: 12)
    }
    private let tagLabel = UILabel().then {
        $0.text = "#시#소설#에세이 좋아해요"
        $0.textColor = .text4
        $0.font = .notoSans(size: 12)
    }
    private lazy var heartButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "heart.fill"), for: .normal)
//        button.addTarget(self, action: #selector(didTapHeartButton), for: .touchUpInside)
        return button
    }()
    private let likeCountLabel: UILabel = {
        let label = UILabel()
        label.font = .notoSans(size: 11, family: .Regular)
        label.textColor = #colorLiteral(red: 0.5924945474, green: 0.5924944878, blue: 0.5924944282, alpha: 1)
        label.text = "12"
        label.sizeToFit()
        return label
    }()
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "carrot")?.withRenderingMode(.alwaysOriginal)
        return imageView
    }()
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "MyContent"
        label.font = .notoSans(size: 14)
        label.textColor = .text1
        return label
    }()
    
//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray
        
        setUpView()
        layout()
        addTarget()
    }
//MARK: - Selector
    
    
    
//MARK: - addSubView
    func setUpView(){
        self.view.addSubview(self.mainView)
        mainView.addSubview(self.closeButton)
        mainView.addSubview(self.ellipsisButton)
        mainView.addSubview(self.profileImageView)
        mainView.addSubview(self.nameLabel)
        mainView.addSubview(self.dateLabel)
        mainView.addSubview(self.heartButton)
        mainView.addSubview(self.likeCountLabel)
        mainView.addSubview(self.tagLabel)
        mainView.addSubview(self.postImageView)
        mainView.addSubview(self.contentLabel)
    }
    
    
//MARK: - Layout
    func layout(){
        
    }
    
//MARK: - AddTarget
    private func addTarget() {
        
    }
    
}





