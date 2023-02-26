//
//  EditPostViewController.swift
//  OnandOff
//
//  Created by 077tech on 2023/01/06.
//

import UIKit
import SnapKit

class EditPostViewController: UIViewController {
    
//MARK: - Properties
    let heading = UILabel().then {
        $0.textAlignment = .center
        $0.text = "글 수정하기"
        $0.font = UIFont(name: "notoSans", size : 16)
    }
    let backButton = UIButton().then{
        $0.setImage(UIImage(named: "backbutton")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    let submitButton = UIButton().then{
        $0.setTitle("작성", for: .normal)
        $0.setTitleColor(UIColor.mainColor, for: .normal)
        $0.titleLabel?.font = .notoSans(size: 14, family: .Bold)
    }
    let photoButton = UIImageView().then{
        $0.image = UIImage(named: "photoButton")?.withRenderingMode(.alwaysOriginal)
    }
    let line = UIView().then{
        $0.backgroundColor = UIColor.gray
    }
    let line2 = UIView().then{
        $0.backgroundColor = UIColor.gray
    }
    let line3 = UIView().then{
        $0.backgroundColor = UIColor.gray
    }
    let emptyView = UIView().then{
        $0.backgroundColor = UIColor.white
    }
    
    let category = UILabel().then{
        $0.textAlignment = .center
        $0.text = "카테고리"
        $0.font = UIFont(name: "notoSans", size : 16)
    }
    let categoryButton = UIImageView().then{
        $0.image = UIImage(named: "rightArrow")?.withRenderingMode(.alwaysOriginal)
    }
    let hashtag = UITextField().then{
        $0.placeholder = "해시태그를 달아보세요. (ex: #에세이, #수필)"
        $0.font = UIFont(name: "notoSans", size : 16)
    }
    private lazy var textView: UITextView = {
            let textView = UITextView()
            textView.font = .systemFont(ofSize: 14, weight: .medium)
            textView.font = .notoSans(size:14)
            textView.text = "작가 키키님의 하루를 기록하고 공유해주세요."
            textView.backgroundColor = .white
            textView.textColor = .placeholderText
            textView.delegate = self
            return textView
        }()
    let bottomline = UIView().then{
        $0.backgroundColor = UIColor.black
    }
    let anonymousCheck = UIImageView().then{
        $0.image = UIImage(named: "anonymousCheck")?.withRenderingMode(.alwaysOriginal)
    }
    let anonymousLabel = UILabel().then {
      $0.textAlignment = .center
      $0.text = "비공개"
      $0.font = UIFont(name: "notoSans", size : 14)
    }

    let checkArray = ["anonymousCheck","anonymousCheckOff"]
    var index = 0
    
//MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setUpView()
        layout()
        addTarget()
    }
    
//MARK: - Selector
    @objc private func didClickBack(_ button: UIButton) {
        self.dismiss(animated: true)
        print("didClickBack")
    }
    @objc private func didClickSubmit(_ button: UIButton) {
        print("didClickSubmit")
    }
    @objc func didClickPhoto(sender: UITapGestureRecognizer) {
        print("didClickPhoto")
    }
    @objc func didClickCategory(sender: UITapGestureRecognizer) {
        let VC = CategorySelectonViewController()
        VC.modalPresentationStyle = .fullScreen
        present(VC, animated: true)
        print("didClickCategory")
    }
    @objc func didClickAnonymous(sender: UITapGestureRecognizer) {
        print("didClickAnonymous")
        self.index = (self.index >= self.checkArray.count-1) ? 0 : self.index+1
        self.anonymousCheck.image = UIImage(named:checkArray[index])
    }
    
//MARK: - addSubView
    func setUpView(){
        self.view.addSubview(self.heading)
        self.view.addSubview(self.backButton)
        self.view.addSubview(self.submitButton)
        self.view.addSubview(self.photoButton)
        self.view.addSubview(self.line)
        self.view.addSubview(self.emptyView)
        emptyView.addSubview(self.category)
        emptyView.addSubview(self.categoryButton)
        self.view.addSubview(self.line2)
        self.view.addSubview(self.hashtag)
        self.view.addSubview(self.line3)
        self.view.addSubview(self.textView)
        self.view.addSubview(self.bottomline)
        self.view.addSubview(self.anonymousCheck)
        self.view.addSubview(self.anonymousLabel)
    }
    
//MARK: - Layout
    private func layout(){
        self.heading.snp.makeConstraints{
            $0.top.equalToSuperview().offset(40)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
        }
        self.backButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(43.88)
            $0.leading.equalToSuperview().offset(0)
            $0.trailing.equalTo(self.heading.snp.leading).offset(50)
            $0.height.equalTo(heading.snp.height)
        }
        self.submitButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(43.88)
            $0.leading.equalTo(self.heading.snp.trailing).offset(-50)
            $0.trailing.equalToSuperview().offset(0)
            $0.height.equalTo(heading.snp.height)
        }
        self.photoButton.snp.makeConstraints{
            $0.top.equalTo(self.heading.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(163)
            $0.trailing.equalToSuperview().offset(-163)
        }
        self.line.snp.makeConstraints{
            $0.top.equalTo(self.photoButton.snp.bottom).offset(36.5)
            $0.size.height.equalTo(1)
            $0.leading.equalToSuperview().offset(13)
            $0.trailing.equalToSuperview().offset(-13)
        }
        self.emptyView.snp.makeConstraints{
            $0.top.equalTo(self.line.snp.bottom).offset(10)
            $0.size.height.equalTo(32)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
        }
        self.category.snp.makeConstraints{
            $0.leading.equalTo(self.emptyView.snp.leading).offset(0)
            $0.centerY.equalTo(self.emptyView)
        }
        self.categoryButton.snp.makeConstraints{
            $0.trailing.equalTo(self.emptyView.snp.trailing).offset(0)
            $0.centerY.equalTo(self.emptyView)
        }
        self.line2.snp.makeConstraints{
            $0.top.equalTo(self.emptyView.snp.bottom).offset(10)
            $0.size.height.equalTo(1)
            $0.leading.equalToSuperview().offset(13)
            $0.trailing.equalToSuperview().offset(-13)
        }
        self.hashtag.snp.makeConstraints{
            $0.top.equalTo(self.line2.snp.bottom).offset(10)
            $0.size.height.equalTo(30)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        self.line3.snp.makeConstraints{
            $0.top.equalTo(self.hashtag.snp.bottom).offset(10)
            $0.size.height.equalTo(1)
            $0.leading.equalToSuperview().offset(13)
            $0.trailing.equalToSuperview().offset(-13)
        }
        self.textView.snp.makeConstraints{
            $0.top.equalTo(self.line3.snp.bottom).offset(10)
            $0.size.height.equalTo(370)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        self.bottomline.snp.makeConstraints{
            $0.top.equalTo(self.textView.snp.bottom).offset(10)
            $0.size.height.equalTo(1)
            $0.leading.equalToSuperview().offset(0)
            $0.trailing.equalToSuperview().offset(0)
        }
        self.anonymousCheck.snp.makeConstraints{
            $0.top.equalTo(self.bottomline.snp.bottom).offset(17.5)
            $0.leading.equalToSuperview().offset(20)
        }
        
        self.anonymousLabel.snp.makeConstraints{
            $0.top.equalTo(self.bottomline.snp.bottom).offset(16)
            $0.leading.equalTo(self.anonymousCheck.snp.trailing).offset(10.75)
        }
        
    }
    
//MARK: - AddTarget
    private func addTarget() {
        self.backButton.addTarget(self, action: #selector(self.didClickBack(_:)), for: .touchUpInside)
        self.submitButton.addTarget(self, action: #selector(self.didClickSubmit(_:)), for: .touchUpInside)
        
        let tapGestureCategory = UITapGestureRecognizer(target: self, action: #selector(didClickCategory(sender:)))
        emptyView.addGestureRecognizer(tapGestureCategory)
        
        let PhotoBtn = UITapGestureRecognizer(target: self, action: #selector(didClickPhoto))
        photoButton.isUserInteractionEnabled = true
        photoButton.addGestureRecognizer(PhotoBtn)
        
        let ImgBtn = UITapGestureRecognizer(target: self, action: #selector(didClickAnonymous))
        anonymousCheck.isUserInteractionEnabled = true
        anonymousCheck.addGestureRecognizer(ImgBtn)
    }
    
}



extension EditPostViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .placeholderText else { return }
        textView.textColor = .label
        textView.text = nil
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "작가 키키님의 하루를 기록하고 공유해주세요."
            textView.textColor = .placeholderText
        }
    }
}


