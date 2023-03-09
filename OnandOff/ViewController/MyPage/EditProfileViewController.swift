//
//  EdirProfileViewController.swift
//  OnandOff
//
//  Created by e2phus on 2023/02/23.
//

import UIKit
import SnapKit
import Alamofire

// 이미지 관련 처리 필요 + 삭제 API 추가 필요
final class EditProfileViewController: UIViewController {
    // MARK: - Properties
    private var profileImage: UIImage?
    private var oldNickName = ""
    private var oldIntroduction = ""
    
    private let profileImageButton = UIButton(type: .system).then {
        $0.setImage(UIImage(named: "ProfileInsertPhoto")?.withRenderingMode(.alwaysOriginal), for: .normal)
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
    }
    
    private let personaComponent = TextFieldComponent(title: "페르소나").then {
        $0.inputTextfield.textColor = .text4
        $0.titleLabel.textColor = .text4
        $0.inputTextfield.isEnabled = false
    }
    
    private let nickNameComponent = TextFieldComponent(title: "닉네임").then { $0.inputTextfield.tag = 0 }
    
    private let introductionComponent = TextFieldComponent(title: "한줄소개").then { $0.inputTextfield.tag = 1 }
    
    private let changeButton = UIButton(type: .system).then {
        $0.setTitle("변경", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .notoSans(size: 16, family: .Bold)
        $0.backgroundColor = .text3
        $0.layer.cornerRadius = 5
        $0.isEnabled = false
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.addSubView()
        self.layout()
        self.addTarget()
        self.configureNavigation()
        
        MyPageService.fetchProfile(1610) { item in
            self.personaComponent.inputTextfield.text = item.personaName
            self.nickNameComponent.inputTextfield.text = item.profileName
            self.introductionComponent.inputTextfield.text = item.statusMessage
            self.oldIntroduction = item.statusMessage
            self.oldNickName = item.profileName
            
            DispatchQueue.global().async {
                guard let url = URL(string: item.profileImgUrl) else { return }
                do {
                    let data = try Data(contentsOf: url)
                    DispatchQueue.main.async {
                        self.profileImageButton.setImage(UIImage(data: data)?.withRenderingMode(.alwaysOriginal), for: .normal)
                        
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Actions
    @objc func showPhotoSelectSheet() {
        let controller = ImageUploadViewController()
        controller.modalPresentationStyle = .fullScreen
        controller.delegate = self
        
        self.present(controller, animated: false)
    }
    
    @objc func didChangeText(_ sender: UITextField) {
        if sender.tag == 0 {
            if sender.text!.count > 8 {
                sender.deleteBackward()
            }
        } else {
            if sender.text!.count > 30 {
                sender.deleteBackward()
            }
        }
        let newIntroduction = self.introductionComponent.inputTextfield.text ?? ""
        let newNickName = self.nickNameComponent.inputTextfield.text ?? ""
        
        if (newIntroduction == oldIntroduction && newNickName == oldNickName) || newNickName == "" {
            self.changeButton.backgroundColor = .text3
            self.changeButton.isEnabled = false
        } else {
            self.changeButton.backgroundColor = .mainColor
            self.changeButton.isEnabled = true
        }
    }
    
    @objc func didClickChangeButton(_ sender: UIButton) {
        let profileName = self.nickNameComponent.inputTextfield.text!
        let introduction = self.introductionComponent.inputTextfield.text ?? ""
        ProfileService.editProfile(1610, profileName: profileName, statusMessage: introduction, image: self.profileImage, defaultImage: false)
    }
    
    @objc func didTapDeleteButton() {
        print(#function)
    }
    
    // MARK: - Helpers
    private func addSubView() {
        self.view.addSubview(self.profileImageButton)
        self.view.addSubview(self.personaComponent)
        self.view.addSubview(self.nickNameComponent)
        self.view.addSubview(self.introductionComponent)
        view.addSubview(changeButton)
    }
    
    private func configureNavigation() {
        self.title = "프로필 편집"
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "삭제하기", style: .plain, target: self, action: #selector(didTapDeleteButton))
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 0.4969086051, blue: 0.4779163599, alpha: 1)
    }
    
    private func layout() {
        self.profileImageButton.snp.makeConstraints {
            $0.width.equalTo(95)
            $0.height.equalTo(95)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(142)
            $0.centerX.equalToSuperview()
        }
        
        self.profileImageButton.layer.cornerRadius = 95 / 2
        
        self.personaComponent.snp.makeConstraints {
            $0.top.equalTo(self.profileImageButton.snp.bottom).offset(85)
            $0.height.equalTo(25)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalTo(self.view.snp.centerX).offset(-10)
        }
        
        self.nickNameComponent.snp.makeConstraints {
            $0.height.equalTo(25)
            $0.top.equalTo(self.profileImageButton.snp.bottom).offset(85)
            $0.leading.equalTo(self.view.snp.centerX).offset(10)
            $0.trailing.equalToSuperview().offset(-15)
        }
        
        self.introductionComponent.snp.makeConstraints {
            $0.height.equalTo(25)
            $0.top.equalTo(self.personaComponent.snp.bottom).offset(46)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
        }
        
        self.changeButton.snp.makeConstraints {
            $0.top.equalTo(self.introductionComponent.snp.bottom).offset(50)
            $0.centerX.equalTo(view.snp.centerX)
            $0.height.equalTo(50)
            $0.width.equalTo(322)
        }
    }
    
    //MARK: - AddTarget
    private func addTarget() {
        self.profileImageButton.addTarget(self, action: #selector(showPhotoSelectSheet), for: .touchUpInside)
        self.nickNameComponent.inputTextfield.addTarget(self, action: #selector(didChangeText), for: .editingChanged)
        self.introductionComponent.inputTextfield.addTarget(self, action: #selector(didChangeText), for: .editingChanged)
        self.changeButton.addTarget(self, action: #selector(didClickChangeButton), for: .touchUpInside)
    }
}

//MARK: - delegate
extension EditProfileViewController: ImageUploadDelegate {
    func didClickFindAlbumButton() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true)
    }
    
    func didClickSecondMenu() {
        print(self)
    }
}
    
// MARK: - UIImagePickerControllerDelegate
extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        self.profileImage = selectedImage
        profileImageButton.layer.borderColor = UIColor.white.cgColor
        profileImageButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.dismiss(animated: true, completion: nil)
    }
}
