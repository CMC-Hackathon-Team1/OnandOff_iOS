//
//  PostViewController.swift
//  OnandOff
//
//  Created by 077tech on 2023/01/06.
//

import UIKit
import Photos

final class PostViewController: UIViewController {
    
    //MARK: - Properties
    private let photoButton = UIButton().then {
        $0.setImage(UIImage(named: "photoButton")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    private let separatorLineView = UIView().then {
        $0.backgroundColor = .gray
    }
    
    private let categoryFrameView = UIView()
    
    private let categoryLabel = UILabel().then {
        $0.textAlignment = .center
        $0.text = "카테고리"
        $0.font = .notoSans(size: 16, family: .Bold)
    }
    
    private let rightArrowImageView = UIImageView().then {
        $0.image = UIImage(named: "rightArrow")?.withRenderingMode(.alwaysOriginal)
    }
    
    private let separatorLineView2 = UIView().then {
        $0.backgroundColor = UIColor.gray
    }
    
    private let hashtagTextfield = UITextField().then {
        $0.placeholder = "해시태그를 달아보세요. (ex: #에세이, #수필)"
        $0.font = .notoSans(size: 16)
    }
    
    private let separatorLineView3 = UIView().then {
        $0.backgroundColor = UIColor.gray
    }
    
    private let contentTextView = UITextView().then {
        $0.font = .notoSans(size:14)
        $0.text = "작가 키키님의 하루를 기록하고 공유해주세요."
        $0.backgroundColor = .white
        $0.textColor = .placeholderText
        
    }
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

        self.setUpView()
        self.layout()
        self.addTarget()

        self.contentTextView.delegate = self
        
        self.navigationItem.title = "글 작성하기"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "작성", style: .plain, target: self, action: #selector(self.didClickSubmit)).then {
            $0.tintColor = .mainColor
        }
    }
    
//MARK: - Delegate
    func sendCategoryNumber(data: Int) {
        DispatchQueue.main.async {
            if data == 1{
                self.categoryLabel.text = "문화/예술"
            }else if data == 2{
                self.categoryLabel.text = "스포츠"
            }else if data == 3{
                self.categoryLabel.text = "자기계발"
            }else{
                self.categoryLabel.text = "기타"
            }
        }
    }
    
//MARK: - Selector
    @objc private func didClickBack(_ button: UIButton) {
        dismiss(animated: true)
        print("didClickBack")
    }
    
    @objc private func didClickSubmit(_ button: UIButton) {
        print("didClickSubmit")
    }
    
    @objc func didClickPhoto(sender: UITapGestureRecognizer) {
        let controller = ImageUploadViewController()
        controller.modalPresentationStyle = .fullScreen
        controller.delegate = self
        
        self.present(controller, animated: false)
    }
    
    @objc func didClickCategory(sender: UITapGestureRecognizer) {
        let VC = CategoryActionSheetViewController()
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
    private func setUpView(){
        self.view.addSubview(self.photoButton)
        self.view.addSubview(self.separatorLineView)
        self.view.addSubview(self.categoryFrameView)
        
        self.categoryFrameView.addSubview(self.categoryLabel)
        self.categoryFrameView.addSubview(self.rightArrowImageView)
        
        self.view.addSubview(self.separatorLineView2)
        self.view.addSubview(self.hashtagTextfield)
        self.view.addSubview(self.separatorLineView3)
        self.view.addSubview(self.contentTextView)
        self.view.addSubview(self.bottomline)
        self.view.addSubview(self.anonymousCheck)
        self.view.addSubview(self.anonymousLabel)
    }
    
//MARK: - Layout
    private func layout(){
        self.photoButton.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(40)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(64)
        }
        
        self.separatorLineView.snp.makeConstraints{
            $0.top.equalTo(self.photoButton.snp.bottom).offset(36.5)
            $0.height.equalTo(1)
            $0.leading.equalToSuperview().offset(13)
            $0.trailing.equalToSuperview().offset(-13)
        }
        
        self.categoryFrameView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(13)
            $0.trailing.equalToSuperview().offset(-13)
            $0.top.equalTo(self.separatorLineView.snp.bottom)
            $0.height.equalTo(55)
        }
        
        self.categoryLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(12)
        }
        
        self.rightArrowImageView.snp.makeConstraints{
            $0.trailing.equalToSuperview().offset(-12)
            $0.centerY.equalToSuperview()
        }
        
        self.separatorLineView2.snp.makeConstraints{
            $0.top.equalTo(self.categoryFrameView.snp.bottom)
            $0.size.height.equalTo(1)
            $0.leading.equalToSuperview().offset(13)
            $0.trailing.equalToSuperview().offset(-13)
        }
        
        self.hashtagTextfield.snp.makeConstraints{
            $0.top.equalTo(self.separatorLineView2.snp.bottom).offset(10)
            $0.size.height.equalTo(30)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        self.separatorLineView3.snp.makeConstraints{
            $0.top.equalTo(self.hashtagTextfield.snp.bottom).offset(10)
            $0.size.height.equalTo(1)
            $0.leading.equalToSuperview().offset(13)
            $0.trailing.equalToSuperview().offset(-13)
        }
        self.contentTextView.snp.makeConstraints{
            $0.top.equalTo(self.separatorLineView3.snp.bottom).offset(10)
            $0.size.height.equalTo(370)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        self.bottomline.snp.makeConstraints{
            $0.top.equalTo(self.contentTextView.snp.bottom).offset(10)
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
        self.photoButton.addTarget(self, action: #selector(self.didClickPhoto), for: .touchUpInside)
        
        let categoryTapGesture = UITapGestureRecognizer(target: self, action: #selector(didClickCategory(sender:)))
        self.categoryFrameView.addGestureRecognizer(categoryTapGesture)
        
        let ImgBtn = UITapGestureRecognizer(target: self, action: #selector(didClickAnonymous))
        anonymousCheck.isUserInteractionEnabled = true
        anonymousCheck.addGestureRecognizer(ImgBtn)
    }
    
}

extension PostViewController: UITextViewDelegate {
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

extension PostViewController: ImageUploadDelegate {
    func didClickFindAlbumButton() {
        print("")
    }
    
    func didClickSecondMenu() {
        print("")
    }
}

