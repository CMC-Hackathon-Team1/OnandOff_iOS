//
//  FeedbackViewController.swift
//  OnandOff
//
//  Created by 077tech on 2023/02/08.
//


import Foundation
import UIKit
import SnapKit
import Then

class FeedbackViewController: UIViewController{
    //MARK: - Datasource
    
    
    //MARK: - Properties
    let backButton = UIImageView().then{
        $0.image = UIImage(named: "backbutton")?.withRenderingMode(.alwaysOriginal)
    }
    let settingLabel = UILabel().then{
        $0.text = "피드백/문의하기"
        $0.font = UIFont(name:"NotoSans-Bold", size: 16)
    }
    let logoImage = UIImageView().then{
        $0.image = UIImage(named: "onofflogo")?.withRenderingMode(.alwaysOriginal)
    }
    let mainLabel = UILabel().then{
        $0.text = "에게 궁금하거나 제안할 점이 있다면 이메일을 보내주세요."
        $0.font = UIFont(name:"NotoSans-Regular", size: 12)
    }
    let textViewBorderView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 15
    }
    
    private lazy var textView: UITextView = {
            let textView = UITextView()
            textView.font = .systemFont(ofSize: 14, weight: .medium)
            textView.font = .notoSans(size:14)
            textView.text = "(최대 400자까지 작성할 수 있습니다.)"
            textView.backgroundColor = .white
            textView.textColor = .placeholderText
            textView.delegate = self
            return textView
        }()
    let submitButton = UIView().then{
        $0.backgroundColor = .mainColor
    }
    let submitLabel = UILabel().then{
        $0.text = "문의하기"
        $0.font = UIFont(name:"NotoSans-Bold", size: 16)
        $0.textColor = .white
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        setUpView()
        layout()
        addTarget()
        self.navigationController?.navigationBar.isHidden = true;
        self.view.backgroundColor = .white
    }
    
    //MARK: - AddSubview
    func setUpView(){
        self.view.addSubview(self.backButton)
        self.view.addSubview(self.settingLabel)
        self.view.addSubview(self.logoImage)
        self.view.addSubview(self.mainLabel)
        self.view.addSubview(self.textViewBorderView)
        self.textViewBorderView.addSubview(self.textView)
        self.view.addSubview(self.submitButton)
        self.submitButton.addSubview(self.submitLabel)
        

    }
    
    //MARK: - Selector
   
    @objc func didClickBackButton(sender: UITapGestureRecognizer){
        dismiss(animated: true)
    }
    @objc func didClickSubmit(sender: UITapGestureRecognizer){
        let VC = FeedbackConfirmViewController()
        VC.modalPresentationStyle = .overCurrentContext
        present(VC, animated: false)
    }
    
    
    //MARK: - Layout
    func layout(){
        self.backButton.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(25.28)
            $0.top.equalToSuperview().offset(55)
            $0.width.equalTo(14)
            $0.height.equalTo(16.22)
        }
        self.settingLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(50)
            $0.centerX.equalToSuperview()
        }
        self.logoImage.snp.makeConstraints{
            $0.top.equalTo(self.backButton.snp.bottom).offset(38.9)
            $0.leading.equalToSuperview().offset(30)
            $0.height.equalTo(15)
            $0.width.equalTo(55)
        }
        self.mainLabel.snp.makeConstraints{
            $0.top.equalTo(self.logoImage)
            $0.leading.equalTo(self.logoImage.snp.trailing).offset(5)
        }
        self.textViewBorderView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(31)
            $0.trailing.equalToSuperview().offset(-31)
            $0.top.equalTo(self.mainLabel.snp.bottom).offset(32)
            $0.height.equalTo(316)
        }
        self.textView.snp.makeConstraints{
            $0.top.leading.equalToSuperview().offset(5)
            $0.bottom.trailing.equalToSuperview().offset(-5)
        }
        self.submitButton.snp.makeConstraints{
            $0.top.equalTo(self.textViewBorderView.snp.bottom).offset(66)
            $0.leading.equalToSuperview().offset(34)
            $0.trailing.equalToSuperview().offset(-34)
            $0.height.equalTo(49)
        }
        self.submitLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
    }
    
    //MARK: - Target
    func addTarget(){

        let backBtn = UITapGestureRecognizer(target: self, action: #selector(didClickBackButton))
        backButton.isUserInteractionEnabled = true
        backButton.addGestureRecognizer(backBtn)
        
        let submitBtn = UITapGestureRecognizer(target: self, action: #selector(didClickSubmit))
        submitButton.isUserInteractionEnabled = true
        submitButton.addGestureRecognizer(submitBtn)
        
    }
    


}



extension FeedbackViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .placeholderText else { return }
        textView.textColor = .label
        textView.text = nil
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "(최대 400자까지 작성할 수 있습니다.)"
            textView.textColor = .placeholderText
        }
    }
}
