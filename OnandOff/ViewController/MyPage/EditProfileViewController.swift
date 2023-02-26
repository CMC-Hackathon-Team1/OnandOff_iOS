//
//  EdirProfileViewController.swift
//  OnandOff
//
//  Created by e2phus on 2023/02/23.
//

import UIKit
import SnapKit
import SwiftUI
import MobileCoreServices
import Alamofire


class EditProfileViewController: UIViewController {
    
    // MARK: - Properties
    let picker = UIImagePickerController()
    var profileImage: UIImage?
    
    private lazy var profileInsertPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "person"), for: .normal)
        button.backgroundColor = .systemPink
        button.tintColor = .white
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(showPhotoSelectSheet), for: .touchUpInside)
        return button
    }()
    
    private let personaLabel: UILabel = {
        let label = UILabel()
        label.font = .notoSans(size: 12, family: .Bold)
        label.textColor = #colorLiteral(red: 0.8926360011, green: 0.8926360011, blue: 0.8926360011, alpha: 1)
        label.text = "페르소나"
        return label
    }()
    
    private let personaResultLabel: UILabel = {
        let label = UILabel()
        label.font = .notoSans(size: 12, family: .Bold)
        label.textColor = #colorLiteral(red: 0.8926360011, green: 0.8926360011, blue: 0.8926360011, alpha: 1)
        label.text = "작가"
        return label
    }()
    
    private let bottomLine1: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ShortLine")
        return imageView
    }()
    
    private let nickNameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.font = .notoSans(size: 12, family: .Bold)
        return label
    }()
    
    private let nickNameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.font = .notoSans(size: 12, family: .Regular)
        textField.text = "키키"
        // textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        return textField
    }()
    
    private let bottomLine2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ShortLine")
        return imageView
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "한줄소개"
        label.font = .notoSans(size: 12, family: .Bold)
        return label
    }()
    
    private let infoTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.font = .notoSans(size: 12, family: .Regular)
        textField.text = "#시 #소설 #에세이 좋아해요"
        // textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        return textField
    }()
    
    private let bottomLine: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "LongLine")
        return imageView
    }()
    
    private lazy var changeButton: UIButton = {
        let button = UIButton()
        button.setTitle("변경", for: .normal)
        button.titleLabel?.font = .notoSans(size: 16, family: .Bold)
        button.backgroundColor = .mainColor
        button.layer.cornerRadius = 5
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        configureLayout()
        picker.delegate = self
    }
    
    // MARK: - API
    
    
    
    // MARK: - Actions
    @objc func showPhotoSelectSheet() {
        print(#function)
        let controller = ImageUploadViewController()
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
    }
    
    
    @objc func textDidChange(_ sender: UITextField) {
        if nickNameTextField.text!.count > 8 {
            nickNameTextField.deleteBackward()
        } else if infoTextField.text!.count > 30 {
            infoTextField.deleteBackward()
        }
    }
    
    @objc func didTapDeleteButton() {
        print(#function)
    }
    
    
    // MARK: - Helpers
    func addSubView() {
        view.backgroundColor = .white
        view.addSubview(profileInsertPhotoButton)
        view.addSubview(personaLabel)
        view.addSubview(personaResultLabel)
        view.addSubview(bottomLine1)
        view.addSubview(nickNameLabel)
        view.addSubview(nickNameTextField)
        view.addSubview(bottomLine2)
        view.addSubview(infoLabel)
        view.addSubview(infoTextField)
        view.addSubview(bottomLine)
        view.addSubview(changeButton)
    }
    
    func configureLayout() {
        self.title = "프로필 편집"
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "삭제하기", style: .plain, target: self, action: #selector(didTapDeleteButton))
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 0.4969086051, blue: 0.4779163599, alpha: 1)
        
        profileInsertPhotoButton.snp.makeConstraints {
            $0.width.equalTo(95)
            $0.height.equalTo(95)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(142)
            $0.centerX.equalToSuperview()
        }
        profileInsertPhotoButton.layer.cornerRadius = 95 / 2
        
        personaLabel.snp.makeConstraints {
            $0.top.equalTo(profileInsertPhotoButton.snp.bottom).offset(85)
            $0.leading.equalTo(bottomLine1.snp.leading)
        }
        
        personaResultLabel.snp.makeConstraints {
            $0.height.equalTo(13.5)
            $0.top.equalTo(personaLabel.snp.top)
            $0.leading.equalTo(personaLabel.snp.trailing).offset(15)
            $0.bottom.equalTo(personaLabel.snp.bottom).offset(-0.2)
        }
        
        bottomLine1.snp.makeConstraints {
            $0.top.equalTo(personaLabel.snp.bottom).offset(6.5)
            $0.centerX.equalToSuperview().offset(-85)
        }
        
        nickNameLabel.snp.makeConstraints {
            $0.top.equalTo(profileInsertPhotoButton.snp.bottom).offset(85)
            $0.centerX.equalToSuperview().offset(30)
        }
        
        nickNameTextField.snp.makeConstraints {
            $0.height.equalTo(13.5)
            $0.top.equalTo(nickNameLabel.snp.top)
            $0.leading.equalTo(nickNameLabel.snp.trailing).offset(15)
            $0.bottom.equalTo(nickNameLabel.snp.bottom).offset(-0.2)
        }
        
        bottomLine2.snp.makeConstraints {
            $0.top.equalTo(nickNameLabel.snp.bottom).offset(6.5)
            $0.leading.equalTo(nickNameLabel.snp.leading)
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(personaLabel.snp.bottom).offset(46)
            $0.leading.equalTo(personaLabel.snp.leading)
        }
        
        infoTextField.snp.makeConstraints {
            $0.height.equalTo(13.5)
            $0.top.equalTo(infoLabel.snp.top)
            $0.leading.equalTo(infoLabel.snp.trailing).offset(15)
            $0.bottom.equalTo(infoLabel.snp.bottom).offset(-0.2)
        }
        
        bottomLine.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(6.5)
            $0.leading.equalTo(bottomLine1.snp.leading)
            $0.trailing.equalTo(bottomLine2.snp.trailing)
        }
        
        changeButton.snp.makeConstraints {
            $0.top.equalTo(bottomLine.snp.bottom).offset(50)
            $0.centerX.equalTo(view.snp.centerX)
            $0.height.equalTo(50)
            $0.width.equalTo(322)
        }
    }
}
    
    
// MARK: - UIImagePickerControllerDelegate
extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        profileImage = selectedImage
        
        profileInsertPhotoButton.contentMode = .scaleAspectFill
        profileInsertPhotoButton.clipsToBounds = true
        profileInsertPhotoButton.layer.cornerRadius = profileInsertPhotoButton.frame.width / 2
        profileInsertPhotoButton.layer.masksToBounds = true
        profileInsertPhotoButton.layer.borderColor = UIColor.white.cgColor
        // profileInsertPhotoButton.layer.borderWidth = 2
        profileInsertPhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        self.dismiss(animated: true, completion: nil)
    }
}


