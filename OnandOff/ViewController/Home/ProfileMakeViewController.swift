//
//  ProfileMakeViewController.swift
//  OnandOff
//
//  Created by woonKim on 2023/01/08.
//

import UIKit
import SnapKit
import Then

class ProfileMakeViewController: UIViewController {
    
    let picker = UIImagePickerController()
    
    let profileMakeBtn = UIButton().then {
        $0.frame.size.width = 12
        $0.frame.size.height = 19
        $0.setImage(UIImage(named: "backbutton"), for: .normal)
        $0.addTarget(self, action: #selector(backToHome), for: .touchUpInside)
    }
    
    let profileMakeLbl = UILabel().then {
        $0.font = .notoSans(size: 16, family: .Bold)
        $0.text = "프로필 생성"
    }
    
    let makeBtn = UIButton().then {
        $0.setTitle("생성하기", for: .normal)
        $0.setTitleColor(UIColor.mainColor, for: .normal)
        $0.titleLabel?.font = .notoSans(size: 14, family: .Regular)
    }
    
    lazy var profileInsertPhotoImgView = UIImageView().then {
        $0.image = UIImage(named: "ProfileInsertPhoto")
    }
    
    let personaLbl = UILabel().then {
        $0.font = .notoSans(size: 13.5, family: .Bold)
        $0.text = "페르소나"
    }
    
    let personaTxField = UITextField().then {
        $0.font = .notoSans(size: 13.5, family: .Bold)
        $0.textColor = UIColor.mainColor
        $0.placeholder = "최대 4글자"
        $0.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    }
    
    let shortLine1 = UIImageView().then {
        $0.image = UIImage(named: "ShortLine")
    }
    
    let nickNameLbl = UILabel().then {
        $0.font = .notoSans(size: 13.5, family: .Bold)
        $0.text = "닉네임"
    }
    
    let nickNameTxField = UITextField().then {
        $0.font = .notoSans(size: 13.5, family: .Bold)
        $0.textColor = UIColor.mainColor
        $0.placeholder = "최대 8글자"
        $0.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    }
    
    let shortLine2 = UIImageView().then {
        $0.image = UIImage(named: "ShortLine")
    }
    
    let introduceLbl = UILabel().then {
        $0.font = .notoSans(size: 13.5, family: .Bold)
        $0.text = "한줄소개"
    }
    
    let introduceTxField = UITextField().then {
        $0.font = .notoSans(size: 13.5, family: .Bold)
        $0.textColor = UIColor.mainColor
        $0.placeholder = "최대 30글자"
        $0.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
    }
    
    let longLine = UIImageView().then {
        $0.image = UIImage(named: "LongLine")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        layout()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(insertPhoto))
        profileInsertPhotoImgView.isUserInteractionEnabled = true
        profileInsertPhotoImgView.addGestureRecognizer(tapGestureRecognizer)
        
        picker.delegate = self
    }
    
    func setUpView() {
        view.backgroundColor = .white
        view.addSubview(profileMakeBtn)
        view.addSubview(profileMakeLbl)
        view.addSubview(makeBtn)
        view.addSubview(profileInsertPhotoImgView)
        view.addSubview(personaLbl)
        view.addSubview(personaTxField)
        view.addSubview(shortLine1)
        view.addSubview(nickNameLbl)
        view.addSubview(nickNameTxField)
        view.addSubview(shortLine2)
        view.addSubview(introduceLbl)
        view.addSubview(introduceTxField)
        view.addSubview(longLine)
    }
    
    func layout() {
        
        profileMakeBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(12)
            $0.leading.equalToSuperview().inset(25)
        }
        
        profileMakeLbl.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(12)
            $0.centerX.equalToSuperview()
        }
        
        makeBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(7.5)
            $0.trailing.equalToSuperview().inset(25)
        }
        
        profileInsertPhotoImgView.snp.makeConstraints {
            $0.width.equalTo(95)
            $0.height.equalTo(95)
            $0.top.equalTo(profileMakeLbl.snp.bottom).offset(70)
            $0.centerX.equalToSuperview()
        }
        
        personaLbl.snp.makeConstraints {
            $0.top.equalTo(profileInsertPhotoImgView.snp.bottom).offset(85)
            $0.leading.equalTo(shortLine1.snp.leading)
        }
        
        personaTxField.snp.makeConstraints {
            $0.height.equalTo(13.5)
            $0.top.equalTo(personaLbl.snp.top)
            $0.leading.equalTo(personaLbl.snp.trailing).offset(15)
            $0.bottom.equalTo(personaLbl.snp.bottom).offset(-0.2)
        }
        
        shortLine1.snp.makeConstraints {
            $0.top.equalTo(personaLbl.snp.bottom).offset(6.5)
            $0.centerX.equalToSuperview().offset(-85)
        }
        
        nickNameLbl.snp.makeConstraints {
            $0.top.equalTo(profileInsertPhotoImgView.snp.bottom).offset(85)
            $0.centerX.equalToSuperview().offset(30)
        }
        
        nickNameTxField.snp.makeConstraints {
            $0.height.equalTo(13.5)
            $0.top.equalTo(nickNameLbl.snp.top)
            $0.leading.equalTo(nickNameLbl.snp.trailing).offset(15)
            $0.bottom.equalTo(nickNameLbl.snp.bottom).offset(-0.2)
        }
        
        shortLine2.snp.makeConstraints {
            $0.top.equalTo(nickNameLbl.snp.bottom).offset(6.5)
            $0.leading.equalTo(nickNameLbl.snp.leading)
        }
        
        introduceLbl.snp.makeConstraints {
            $0.top.equalTo(personaLbl.snp.bottom).offset(46)
            $0.leading.equalTo(personaLbl.snp.leading)
        }
        
        introduceTxField.snp.makeConstraints {
            $0.height.equalTo(13.5)
            $0.top.equalTo(introduceLbl.snp.top)
            $0.leading.equalTo(introduceLbl.snp.trailing).offset(15)
            $0.bottom.equalTo(introduceLbl.snp.bottom).offset(-0.2)
        }
        
        longLine.snp.makeConstraints {
            $0.top.equalTo(introduceLbl.snp.bottom).offset(6.5)
            $0.leading.equalTo(shortLine1.snp.leading)
            $0.trailing.equalTo(shortLine2.snp.trailing)
        }
    }

    @objc func backToHome(sender: UIButton!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func insertPhoto(sender: UIButton!) {
  
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        let library = UIAlertAction(title: "사진앨범", style: .default) { (action) in self.openLibrary()}
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alert.addAction(library)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func openLibrary() {

      picker.sourceType = .photoLibrary
      present(picker, animated: false, completion: nil)
    }
    
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        
        if personaTxField.text!.count > 4 {
            personaTxField.deleteBackward()
        } else if nickNameTxField.text!.count > 8 {
            nickNameTxField.deleteBackward()
        } else if introduceTxField.text!.count > 30 {
            introduceTxField.deleteBackward()
        }
    }
}

extension ProfileMakeViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
       
            profileInsertPhotoImgView.image = img
            profileInsertPhotoImgView.layer.cornerRadius = profileInsertPhotoImgView.frame.height/2
            profileInsertPhotoImgView.clipsToBounds = true
        }
        dismiss(animated: true, completion: nil)
    }
}
