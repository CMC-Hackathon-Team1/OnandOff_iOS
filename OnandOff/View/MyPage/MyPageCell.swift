//
//  MyPageCell.swift
//  OnandOff
//
//  Created by e2phus on 2023/01/03.
//
import UIKit
import SnapKit

final class MyPageCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier = "MyPageCell"
    weak var delegate: FeedDelegate?
    
    private let postDateLabel = UILabel().then {
        $0.font = .notoSans(size: 14, family: .Bold)
        $0.textColor = .black
        $0.text = "2022/09/24"
        $0.sizeToFit()
    }
    
    private let heartButton = UIButton().then {
        $0.setImage(#imageLiteral(resourceName: "heart.fill"), for: .normal)
    }
    
    private let ellipsisButton = UIButton().then {
        let button = UIButton()
        $0.setImage(#imageLiteral(resourceName: "ellipsis"), for: .normal)
    }
    
    private let likeCountLabel = UILabel().then {
        $0.font = .notoSans(size: 11, family: .Regular)
        $0.textColor = #colorLiteral(red: 0.5924945474, green: 0.5924944878, blue: 0.5924944282, alpha: 1)
        $0.text = "0"
        $0.sizeToFit()
    }
    
    private let postImageView = ImgPageControlView().then {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }
    
    private let contentLabel = UILabel().then {
        $0.text = "MyContent"
        $0.font = .notoSans(size: 14)
        $0.textColor = .text1
    }

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
        self.addSubView()
        self.configureLayout()
        self.addTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @objc func didTapEllipsisButton(_ button: UIButton) {
        self.delegate?.didClickEllipsisButton(id: button.tag)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.postImageView.resetImageView()
        self.postImageView.snp.updateConstraints {
            $0.height.equalTo(0)
        }
        self.contentLabel.snp.updateConstraints {
            $0.top.equalTo(self.postImageView.snp.bottom)
        }
    }
    
    private func subLayout(item: MyPageItem) {
        if item.feedImgList != [] {
            self.postImageView.isHidden = false
            self.postImageView.snp.updateConstraints {
                $0.height.equalTo(303)
            }
            self.contentLabel.snp.updateConstraints {
                $0.top.equalTo(self.postImageView.snp.bottom).offset(16)
            }
        }
    }
    
    func configureCell(_ item: MyPageItem) {
        self.ellipsisButton.tag = item.feedId
        self.postDateLabel.text = self.convertDateFormat(item.createdAt)
        self.contentLabel.text = item.feedContent
        self.likeCountLabel.text = "\(item.likeNum)"
        self.subLayout(item: item)
        self.postImageView.setImageSlider(images: item.feedImgList)
    }
    
    private func convertDateFormat(_ oldDate: String) -> String {
        var newDate = ""
        if let idx = oldDate.firstIndex(of: "T") {
            newDate = String(oldDate.prefix(upTo: idx)).replacingOccurrences(of: "-", with: "/")
        }
        
        return newDate
    }
    
    // MARK: - Helpers
    private func configure() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 2
    }
    
    private func addSubView() {
        self.addSubview(self.postDateLabel)
        self.addSubview(self.heartButton)
        self.addSubview(self.likeCountLabel)
        self.addSubview(self.ellipsisButton)
        self.addSubview(self.postImageView)
        self.addSubview(self.contentLabel)
    }
    
    private func configureLayout() {
        self.postDateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(16)
        }
        
        self.heartButton.snp.makeConstraints { make in
            make.centerY.equalTo(postDateLabel)
            make.trailing.equalTo(self.likeCountLabel.snp.leading).offset(-4.5)
            make.width.height.equalTo(12)
        }
        
        self.likeCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(postDateLabel)
            make.trailing.equalTo(self.ellipsisButton.snp.leading).offset(-16)
        }
        
        self.ellipsisButton.snp.makeConstraints { make in
            make.centerY.equalTo(postDateLabel)
            make.trailing.equalToSuperview().offset(-15)
            make.width.height.equalTo(12)
        }
        
        self.postImageView.snp.makeConstraints { make in
            make.top.equalTo(postDateLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(22)
            make.trailing.equalToSuperview().offset(-22)
            make.height.equalTo(0)
        }
        
        self.contentLabel.snp.makeConstraints { make in
            make.top.equalTo(postImageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    private func addTarget() {
        self.ellipsisButton.addTarget(self, action: #selector(didTapEllipsisButton), for: .touchUpInside)
    }
}
