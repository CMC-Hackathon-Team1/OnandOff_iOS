//
//  ImageUploadViewController.swift
//  OnandOff
//
//  Created by 077tech on 2023/01/07.
//

import UIKit
import SnapKit
import Foundation

final class ImageUploadViewController: UIViewController {
    //MARK: - Properties
    weak var delegate: ImageUploadDelegate?
    
    let mainView = UIView().then{
        $0.backgroundColor = .white
        $0.roundCorners(cornerRadius: 20, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
    }
    
    private let closeButton = UIImageView().then{
        $0.image = UIImage(named: "close")?.withRenderingMode(.alwaysOriginal)
    }
    
    let mainLabel = UILabel().then{
        $0.text = "이미지 업로드"
        $0.font = UIFont(name: "notoSans", size : 16)
    }
    
    let seachFromAlbumButton = UIButton().then{
        if #available(iOS 15.0, *) {
            var configure = UIButton.Configuration.plain()
            var attributedTitle = AttributedString.init("앨범에서 찾기")
            attributedTitle.font = .notoSans(size: 14, family: .Regular)
            configure.attributedTitle = attributedTitle
            configure.imagePlacement = .leading
            configure.image = UIImage(named: "searchfromalbum")?.withRenderingMode(.alwaysOriginal)
            configure.baseForegroundColor = .black
            configure.imagePadding = 20
            $0.configuration = configure
        }
    }
    
    let line = UIView().then{
        $0.backgroundColor = UIColor.gray
    }
    
    let cameraButton = UIButton().then{
        if #available(iOS 15.0, *) {
            var configure = UIButton.Configuration.plain()
            var attributedTitle = AttributedString.init("촬영")
            attributedTitle.font = .notoSans(size: 14, family: .Regular)
            configure.attributedTitle = attributedTitle
            configure.imagePlacement = .leading
            configure.image = UIImage(named: "camera")?.withRenderingMode(.alwaysOriginal)
            configure.baseForegroundColor = .black
            configure.imagePadding = 20
            
            $0.configuration = configure
        }
    }
    
//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray
        
        setUpView()
        layout()
        addTarget()
    }
    
//MARK: - Selector
    @objc private func didClickseachFromAlbum(_ button: UIButton) {
        self.dismiss(animated: false) { [weak self] in
            self?.delegate?.didClickFindAlbumButton()
        }
    }
    
    @objc private func didClickCamera(_ button: UIButton) {
        print("didClickCamera")
    }
    
    @objc func didClickClose(sender: UITapGestureRecognizer) {
        dismiss(animated: true)
        print("didClickClose")
    }
    
//MARK: - addSubView
    func setUpView(){
        self.view.addSubview(self.mainView)
        mainView.addSubview(self.closeButton)
        mainView.addSubview(self.mainLabel)
        mainView.addSubview(self.seachFromAlbumButton)
        mainView.addSubview(self.cameraButton)
        mainView.addSubview(self.line)
    }
    
//MARK: - Layout
    func layout(){
        self.mainView.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(0)
            $0.trailing.equalToSuperview().offset(0)
            $0.leading.equalToSuperview().offset(0)
            $0.height.equalTo(238)
        }
        self.closeButton.snp.makeConstraints{
            $0.top.equalTo(self.mainView.snp.top).offset(24.08)
            $0.leading.equalTo(self.mainView.snp.leading).offset(27.68)
        }
        self.mainLabel.snp.makeConstraints{
            $0.top.equalTo(self.mainView.snp.top).offset(19.5)
            $0.centerX.equalTo(self.mainView)
        }

        self.seachFromAlbumButton.snp.makeConstraints{
            $0.top.equalTo(self.mainView.snp.top).offset(53.5)
            $0.leading.equalTo(self.mainView.snp.leading).offset(24.5)
        }
        self.line.snp.makeConstraints{
            $0.top.equalTo(self.seachFromAlbumButton.snp.bottom).offset(14)
            $0.leading.equalTo(self.mainView.snp.leading).offset(12.5)
            $0.trailing.equalTo(self.mainView.snp.trailing).offset(12.5)
            $0.size.height.equalTo(1)
        }

        self.cameraButton.snp.makeConstraints{
            $0.top.equalTo(self.line.snp.bottom).offset(9)
            $0.leading.equalTo(self.mainView.snp.leading).offset(24.5)
        }
    }
    
//MARK: - AddTarget
    private func addTarget() {
        self.seachFromAlbumButton.addTarget(self, action: #selector(self.didClickseachFromAlbum(_:)), for: .touchUpInside)
        self.cameraButton.addTarget(self, action: #selector(self.didClickCamera(_:)), for: .touchUpInside)
        
        let CloseBtn = UITapGestureRecognizer(target: self, action: #selector(didClickClose))
        closeButton.isUserInteractionEnabled = true
        closeButton.addGestureRecognizer(CloseBtn)
    }
}
