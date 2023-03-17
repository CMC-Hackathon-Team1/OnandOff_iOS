//
//  FeedbackViewController.swift
//  OnandOff
//
//  Created by 077tech on 2023/02/08.
//


import UIKit

final class FeedbackViewController: UIViewController{
    //MARK: - Properties
    private let logoImage = UIImageView().then{
        $0.image = UIImage(named: "onandoffLogo")?.withRenderingMode(.alwaysOriginal)
    }
    
    private let mainLabel = UILabel().then{
        $0.text = "에게 궁금하거나 제안할 점이 있다면 이메일을 보내주세요."
        $0.textColor = .black
        $0.font = .notoSans(size: 12)
    }
    
    private let textViewBorderView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 15
    }
    
    private lazy var textView = UITextView().then {
        $0.font = .notoSans(size:14)
        $0.text = "(최대 400자까지 작성할 수 있습니다.)"
        $0.backgroundColor = .white
        $0.textColor = .placeholderText
        $0.delegate = self
    }
    
    private let submitButton = UIButton(type: .system).then {
        $0.backgroundColor = .mainColor
        $0.layer.cornerRadius = 5
        $0.setTitle("문의하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .notoSans(size: 16, family: .Bold)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        self.setUpView()
        self.layout()
        self.addTarget()
        
        self.textView.delegate = self
        
        self.view.backgroundColor = .white
        self.title = "피드백/문의하기"
    }
    
    //MARK: - AddSubview
    private func setUpView(){
        self.view.addSubview(self.logoImage)
        self.view.addSubview(self.mainLabel)
        self.view.addSubview(self.textViewBorderView)
        self.view.addSubview(self.submitButton)
        
        self.textViewBorderView.addSubview(self.textView)
    }
    
    //MARK: - Selector
    @objc func didClickSubmit(sender: UITapGestureRecognizer){
        guard let text = self.textView.text else { return }
        AuthService.sendMail(content: text) { isSuccess in
            if isSuccess {
                self.defaultAlert(title: "문의 접수가 완료되었습니다.") {
                    self.navigationController?.popViewController(animated: true)
                }
            }else {
                self.defaultAlert(title: "이메일 전송이 실패하였습니다.")
            }
        }
    }
    
    //MARK: - Layout
    private func layout(){
        self.logoImage.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(40)
            $0.leading.equalToSuperview().offset(30)
            $0.height.equalTo(15)
            $0.width.equalTo(55)
        }
        
        self.mainLabel.snp.makeConstraints{
            $0.centerY.equalTo(self.logoImage.snp.centerY)
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
    }
    
    //MARK: - Target
    func addTarget(){
        self.submitButton.addTarget(self, action: #selector(self.didClickSubmit), for: .touchUpInside)
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

extension FeedbackViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
