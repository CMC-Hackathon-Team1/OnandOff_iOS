//
//  EdirProfileViewController.swift
//  OnandOff
//
//  Created by e2phus on 2023/02/23.
//

import UIKit
import SnapKit
import Alamofire

final class EditProfileViewController: UIViewController {
    // MARK: - Properties
    var profileImage: UIImage?
    
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
    
    private let nickNameComponent = TextFieldComponent(title: "닉네임")
    
    private let introductionComponent = TextFieldComponent(title: "한줄소개")
    
    private let changeButton = UIButton(type: .system).then {
        $0.setTitle("변경", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .notoSans(size: 16, family: .Bold)
        $0.backgroundColor = .mainColor
        $0.layer.cornerRadius = 5
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.addSubView()
        self.configureLayout()
        self.addTarget()
        
        MyPageService.fetchProfile(27) { item in
            self.personaComponent.inputTextfield.text = item.personaName
            self.nickNameComponent.inputTextfield.text = item.profileName
            self.introductionComponent.inputTextfield.text = item.statusMessage
            
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
        self.present(controller, animated: false)
    }
    
//    @objc func textDidChange(_ sender: UITextField) {
//        if nickNameTextField.text!.count > 8 {
//            nickNameTextField.deleteBackward()
//        } else if infoTextField.text!.count > 30 {
//            infoTextField.deleteBackward()
//        }
//    }
    
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
    
    func configureLayout() {
        self.title = "프로필 편집"
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "삭제하기", style: .plain, target: self, action: #selector(didTapDeleteButton))
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 0.4969086051, blue: 0.4779163599, alpha: 1)
        
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
    }
}
    
// MARK: - UIImagePickerControllerDelegate
extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        profileImage = selectedImage
        profileImageButton.contentMode = .scaleAspectFill
        profileImageButton.clipsToBounds = true
        profileImageButton.layer.cornerRadius = profileImageButton.frame.width / 2
        profileImageButton.layer.masksToBounds = true
        profileImageButton.layer.borderColor = UIColor.white.cgColor
        profileImageButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.dismiss(animated: true, completion: nil)
    }
}
