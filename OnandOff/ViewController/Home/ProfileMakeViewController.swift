//
//  ProfileMakeViewController.swift
//  OnandOff
//
//  Created by woonKim on 2023/01/08.
//

import UIKit

final class ProfileMakeViewController: UIViewController {
    //MARK: - Properties
    private var profileImage: UIImage?
    
    private let profileImageButton = UIButton().then {
        $0.setImage(UIImage(named: "ProfileInsertPhoto")?.withRenderingMode(.alwaysOriginal), for: .normal)
        $0.layer.cornerRadius = 47.5
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
    }
    
    private let personaComponent = TextFieldComponent(title: "페르소나").then {
        $0.inputTextfield.tag = 0
        $0.inputTextfield.placeholder = "최대 4글자"
    }
    
    private let nickNameComponent = TextFieldComponent(title: "닉네임").then {
        $0.inputTextfield.tag = 1
        $0.inputTextfield.placeholder = "최대 8글자"
    }
    
    private let introductionComponent = TextFieldComponent(title: "한줄소개").then {
        $0.inputTextfield.tag = 2
        $0.inputTextfield.placeholder = "최대 30자까지 가능합니다."
    }
    
    private let personaWarningLabel = UILabel().then {
        $0.text = "필수로 입력해야 합니다."
        $0.textColor = .red
        $0.font = .notoSans(size: 10)
        $0.isHidden = true
    }
    
    private let nickNameWarningLabel = UILabel().then {
        $0.text = "필수로 입력해야 합니다."
        $0.textColor = .red
        $0.font = .notoSans(size: 10)
        $0.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.layout()
        self.addTarget()
        self.configure()
    }
    
    private func configure() {
        self.navigationItem.title = "프로필 생성"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "생성하기",
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(self.didClickSubmit)).then {
            $0.tintColor = .mainColor
        }
    }
    
    private func setUpView() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.profileImageButton)
        self.view.addSubview(self.personaComponent)
        self.view.addSubview(self.nickNameComponent)
        self.view.addSubview(self.introductionComponent)
        self.view.addSubview(self.personaWarningLabel)
        self.view.addSubview(self.nickNameWarningLabel)
    }
    
    private func layout() {
        self.profileImageButton.snp.makeConstraints {
            $0.width.equalTo(95)
            $0.height.equalTo(95)
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(70)
            $0.centerX.equalToSuperview()
        }
        
        self.personaComponent.snp.makeConstraints {
            $0.top.equalTo(self.profileImageButton.snp.bottom).offset(85)
            $0.height.equalTo(25)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalTo(self.view.snp.centerX).offset(-10)
        }
        
        self.personaWarningLabel.snp.makeConstraints {
            $0.leading.equalTo(self.personaComponent.snp.leading)
            $0.top.equalTo(self.personaComponent.snp.bottom).offset(2)
        }
        
        self.nickNameComponent.snp.makeConstraints {
            $0.height.equalTo(25)
            $0.top.equalTo(self.profileImageButton.snp.bottom).offset(85)
            $0.leading.equalTo(self.view.snp.centerX).offset(10)
            $0.trailing.equalToSuperview().offset(-15)
        }
        
        self.nickNameWarningLabel.snp.makeConstraints {
            $0.leading.equalTo(self.nickNameComponent.snp.leading)
            $0.top.equalTo(self.nickNameComponent.snp.bottom).offset(2)
        }
        
        self.introductionComponent.snp.makeConstraints {
            $0.height.equalTo(25)
            $0.top.equalTo(self.personaComponent.snp.bottom).offset(46)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
        }
    }
    
    //MARK: - Selector
    @objc func didClickInsertPhotoButton(sender: UIButton) {
        let controller = ImageUploadViewController()
        controller.modalPresentationStyle = .fullScreen
        controller.delegate = self
        
        self.present(controller, animated: false)
    }
    
    @objc func didChangeText(_ sender: UITextField) {
        self.resetWarning()
        if sender.tag == 0 {
            if sender.text!.count > 4 {
                sender.deleteBackward()
            }
        } else if sender.tag == 1 {
            if sender.text!.count > 8 {
                sender.deleteBackward()
            }
        } else {
            if sender.text!.count > 30 {
                sender.deleteBackward()
            }
        }
    }
    
    @objc func didClickSubmit(_ sender: Any) {
        let personaText = self.personaComponent.inputTextfield.text ?? ""
        let nickNameText = self.nickNameComponent.inputTextfield.text ?? ""
        
        if personaText.isEmpty {
            self.personaWarningLabel.isHidden = false
            self.personaComponent.layer.sublayers?[2].backgroundColor = UIColor.red.cgColor
        }
        
        if nickNameText.isEmpty {
            self.nickNameWarningLabel.isHidden = false
            self.nickNameComponent.layer.sublayers?[2].backgroundColor = UIColor.red.cgColor
        }
        
        if !nickNameText.isEmpty && !personaText.isEmpty {
            let alert = StandardAlertController(title: nil,
                                                message: "페르소나는 한 번 생성되면 더 이상 수정할 수 없습니다.\n이대로 생성하시겠습니까?\n(페르소나 변경을 원할 시 프로필을 다시 만들어야합니다.)")
            alert.messageHighlight(highlightString: "페르소나", color: .mainColor)
            alert.messageHighlight(highlightString: "한 번 생성되면 더 이상 수정할 수 없습니다.", color: .point)
            let cancel = StandardAlertAction(title: "취소", style: .cancel)
            let create = StandardAlertAction(title: "생성", style: .basic) { _ in
                ProfileService.createProfile(profileName: self.nickNameComponent.inputTextfield.text!,
                                             personaName: self.personaComponent.inputTextfield.text!,
                                             statusMessage: self.introductionComponent.inputTextfield.text ?? "",
                                             image: self.profileImage ?? UIImage(named: "ProfileInsertPhoto")!) {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            alert.addAction(cancel)
            alert.addAction(create)
            
            self.present(alert, animated: false)
        }
    }
    
    private func resetWarning() {
        self.personaWarningLabel.isHidden = true
        self.personaComponent.layer.sublayers?[2].backgroundColor = UIColor.text4.cgColor
        self.nickNameWarningLabel.isHidden = true
        self.nickNameComponent.layer.sublayers?[2].backgroundColor = UIColor.text4.cgColor
    }
    
    //MARK: - AddTarget
    private func addTarget(){
        self.profileImageButton.addTarget(self, action: #selector(self.didClickInsertPhotoButton), for: .touchUpInside)
        self.personaComponent.inputTextfield.addTarget(self, action: #selector(self.didChangeText), for: .editingChanged)
        self.nickNameComponent.inputTextfield.addTarget(self, action: #selector(self.didChangeText), for: .editingChanged)
        self.introductionComponent.inputTextfield.addTarget(self, action: #selector(self.didChangeText), for: .editingChanged)
    }
}

extension ProfileMakeViewController: ImageUploadDelegate {
    func didClickFindAlbumButton() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        
        self.present(imagePicker, animated: true)
    }
    
    func didClickSecondMenu() {
        print("didClickSecondMenu")
    }
}

extension ProfileMakeViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        self.profileImage = selectedImage
        profileImageButton.layer.borderColor = UIColor.white.cgColor
        profileImageButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.dismiss(animated: true, completion: nil)
    }
}
