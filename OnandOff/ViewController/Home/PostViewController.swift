//
//  PostViewController.swift
//  OnandOff
//
//  Created by 077tech on 2023/01/06.
//

import UIKit
import PhotosUI

final class PostViewController: UIViewController {
    //MARK: - Properties
    private let selectedProfileItem: ProfileItem
    private var selectedCategoryId: Int = 0
    private var selectedImages: [UIImage] = []
    private var isEditMode = false
    private var feedId: Int?
    private var isAnonymous: Bool = false {
        didSet {
            let imageName = isAnonymous ? "anonymousCheck" : "anonymousCheckOff"
            self.anonymousCheckButton.setImage(UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    private let photoButton = UIButton().then {
        $0.setImage(UIImage(named: "photoButton")?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    private let separatorLineView = UIView().then {
        $0.backgroundColor = .gray
    }
    
    private let categoryFrameView = UIView()
    
    private let categoryLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .black
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
        $0.attributedPlaceholder = NSAttributedString(string: "해시태그를 달아보세요. (ex: #에세이, #수필)",
                                                      attributes: [.foregroundColor : UIColor.text3])
        $0.textColor = .black
        $0.font = .notoSans(size: 16)
    }
    
    private let separatorLineView3 = UIView().then {
        $0.backgroundColor = UIColor.gray
    }
    
    private let contentTextView = UITextView().then {
        $0.font = .notoSans(size:14)
        $0.textColor = .text3
        $0.backgroundColor = .white
    }
    
    private let bottomline = UIView().then{
        $0.backgroundColor = .black
    }
    
    private let anonymousCheckButton = UIButton().then {
        $0.setImage(UIImage(named: "anonymousCheckOff")?.withRenderingMode(.alwaysOriginal), for: .normal)
        $0.contentMode = .scaleAspectFit
    }
    
    private let anonymousLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .black
        $0.text = "비공개"
        $0.font = .notoSans(size: 14)
    }
    
    //MARK: - Init
    //작성
    init(_ profileItem: ProfileItem) {
        self.selectedProfileItem = profileItem
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.title = "글 작성하기"
        self.isEditMode = false
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "작성", style: .plain, target: self, action: #selector(self.didClickSubmit)).then {
            $0.tintColor = .mainColor
        }
        self.contentTextView.textColor = .text3
        self.contentTextView.text = "\(self.selectedProfileItem.profileName + self.selectedProfileItem.personaName)님의 하루를 기록하고 공유해주세요."
    }
    
    //수정
    init(_ profileItem: ProfileItem, feedId: Int) {
        self.selectedProfileItem = profileItem
        self.feedId = feedId
        super.init(nibName: nil, bundle: nil)
        self.isEditMode = true
        self.photoButton.isEnabled = false
        self.navigationItem.title = "글 수정하기"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(self.didClickEditButton)).then {
            $0.tintColor = .mainColor
        }
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "calendarleft")?.withRenderingMode(.alwaysOriginal),
                                                                style: .plain, target: self, action: #selector(self.dismissVC))
        FeedService.getFeedWithFeedId(self.selectedProfileItem.profileId, feedId: feedId) { item in
            self.contentTextView.text = item.feedContent
            self.hashtagTextfield.textColor = .black
            self.hashtagTextfield.text = item.hashTagList.joined(separator: "#")
            self.selectedCategoryId = item.categoryId
            if item.isSecret == "PUBLIC" { self.isAnonymous = false }
            DispatchQueue.global().async {
                for urlString in item.feedImgList {
                    guard let url = URL(string: urlString) else { return }
                    
                    do {
                        let data = try Data(contentsOf: url)
                        self.selectedImages.append(UIImage(data: data) ?? UIImage())
                    } catch let error {
                        print(error)
                    }
                }
                DispatchQueue.main.async {
                    if !self.selectedImages.isEmpty { self.photoButton.setImage(self.selectedImages[0], for: .normal) }
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        self.setUpView()
        self.layout()
        self.addTarget()
        
        self.contentTextView.delegate = self
        if !self.isEditMode { self.navigationController?.navigationBar.isHidden = false }
        self.tabBarController?.tabBar.isHidden = true
        
        self.defaultAlert(title: nil, message: "적절하지 못하거나 불쾌감을 줄 수 있는 컨텐츠나 폭력적인 사용자는 강력한 서비스 이용 제재를 받을 수 있습니다.")
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
    @objc private func dismissVC() {
        self.dismiss(animated: true)
    }
    //적절하거나 불쾌감을 줄 수 있는 컨텐츠는 제재를 받을 수 있습니다
    @objc private func didClickSubmit(_ button: UIButton) {
        if self.contentTextView.text.isEmpty || self.contentTextView.text == "\(self.selectedProfileItem.profileName + self.selectedProfileItem.personaName)님의 하루를 기록하고 공유해주세요." {
            let alert = StandardAlertController(title: "작성된 내용이 없습니다.", message: nil)
            let ok = StandardAlertAction(title: "확인", style: .basic)
            alert.addAction(ok)
            
            self.present(alert, animated: false)
            return
        }
        
        if self.selectedCategoryId == 0 {
            let alert = StandardAlertController(title: "선택된 카테고리가 없습니다.", message: nil)
            let ok = StandardAlertAction(title: "확인", style: .basic)
            alert.addAction(ok)
            
            self.present(alert, animated: false)
            return
        }
        
        let hastag = self.hashtagTextfield.text!.split(separator: "#").map { String($0) }
        let isSecret = self.isAnonymous ? "PRIVATE" : "PUBLIC"
        
        FeedService.createFeed(self.selectedProfileItem.profileId,
                               categoryId: self.selectedCategoryId,
                               hasTagList: hastag,
                               content: self.contentTextView.text!,
                               isSecret: isSecret,
                               images: self.selectedImages) { res in
            switch res.statusCode {
            case 100: self.defaultAlert(title: "게시글 작성 완료") {
                self.navigationController?.popToRootViewController(animated: true)
            }
            case 2208:
                self.defaultAlert(title: res.message) {
                    self.navigationController?.popViewController(animated: true)
                }
            default: self.defaultAlert(title: res.message)
            }
        }
    }
    
    @objc private func didClickEditButton(_ button: UIButton) {
        if self.contentTextView.text.isEmpty || self.contentTextView.text == "\(self.selectedProfileItem.profileName + self.selectedProfileItem.personaName)님의 하루를 기록하고 공유해주세요." {
            let alert = StandardAlertController(title: "작성된 내용이 없습니다.", message: nil)
            let ok = StandardAlertAction(title: "확인", style: .basic)
            alert.addAction(ok)
            
            self.present(alert, animated: false)
            return
        }
        
        if self.selectedCategoryId == 0 {
            let alert = StandardAlertController(title: "선택된 카테고리가 없습니다.", message: nil)
            let ok = StandardAlertAction(title: "확인", style: .basic)
            alert.addAction(ok)
            
            self.present(alert, animated: false)
            return
        }
        
        let hastag = self.hashtagTextfield.text!.split(separator: "#").map { String($0) }
        let isSecret = self.isAnonymous ? "PRIVATE" : "PUBLIC"
        FeedService.editFeed(self.selectedProfileItem.profileId,
                             feedId: self.feedId!,
                               categoryId: self.selectedCategoryId,
                               hashTagList: hastag,
                               content: self.contentTextView.text!,
                               isSecret: isSecret) {
            let model = MypageTempModel(feedContent: self.contentTextView.text!, feedId: self.feedId!, hashTag: hastag)
            NotificationCenter.default.post(name: .changeFeed, object: model)
            self.dismiss(animated: true)
        }
    }
    
    @objc func didClickPhoto(sender: UITapGestureRecognizer) {
        let actionSheetVC = ActionSheetViewController(title: "프로필 사진 업로드",
                                                      firstImage: UIImage(named: "searchfromalbum")?.withRenderingMode(.alwaysOriginal) ?? UIImage(),
                                                      firstText: "앨범에서 찾기",
                                                      secondImage: UIImage(named: "camera")?.withRenderingMode(.alwaysOriginal) ?? UIImage(),
                                                      secondText: "촬영")
        actionSheetVC.delegatePhoto = self
        
        self.present(actionSheetVC, animated: false)
    }
    
    @objc func didClickCategory(sender: UITapGestureRecognizer) {
        let categoryVC = CategoryActionSheetViewController()
        categoryVC.delegate = self
        categoryVC.modalPresentationStyle = .overFullScreen
        
        self.present(categoryVC, animated: true)
    }
    
    @objc func didClickAnonymous(sender: UITapGestureRecognizer) {
        self.isAnonymous = !self.isAnonymous
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
        self.view.addSubview(self.anonymousCheckButton)
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
            $0.height.equalTo(1)
            $0.leading.equalToSuperview().offset(13)
            $0.trailing.equalToSuperview().offset(-13)
        }
        
        self.hashtagTextfield.snp.makeConstraints{
            $0.top.equalTo(self.separatorLineView2.snp.bottom).offset(10)
            $0.height.equalTo(30)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        self.separatorLineView3.snp.makeConstraints{
            $0.top.equalTo(self.hashtagTextfield.snp.bottom).offset(10)
            $0.height.equalTo(1)
            $0.leading.equalToSuperview().offset(13)
            $0.trailing.equalToSuperview().offset(-13)
        }
        
        self.contentTextView.snp.makeConstraints{
            $0.top.equalTo(self.separatorLineView3.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalTo(self.bottomline.snp.top).offset(-16)
        }
        
        self.bottomline.snp.makeConstraints{
            $0.bottom.equalTo(self.anonymousCheckButton.snp.top).offset(-16)
            $0.height.equalTo(1)
            $0.trailing.leading.equalToSuperview()
        }
        
        self.anonymousCheckButton.snp.makeConstraints{
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(30)
        }
        
        self.anonymousLabel.snp.makeConstraints{
            $0.centerY.equalTo(self.anonymousCheckButton.snp.centerY)
            $0.leading.equalTo(self.anonymousCheckButton.snp.trailing).offset(10)
        }
    }
    
    //MARK: - AddTarget
    private func addTarget() {
        self.photoButton.addTarget(self, action: #selector(self.didClickPhoto), for: .touchUpInside)
        self.anonymousCheckButton.addTarget(self, action: #selector(self.didClickAnonymous), for: .touchUpInside)
        
        let categoryTapGesture = UITapGestureRecognizer(target: self, action: #selector(didClickCategory(sender:)))
        self.categoryFrameView.addGestureRecognizer(categoryTapGesture)
    }
}

extension PostViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .text3 else { return }
        textView.textColor = .black
        textView.text = nil
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "\(self.selectedProfileItem.profileName + self.selectedProfileItem.personaName)님의 하루를 기록하고 공유해주세요."
            textView.textColor = .text3
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK: - ImageUploadDelegate
extension PostViewController: CategoryDelegate {
    func selectedCategory(_ categoryId: Int) {
        self.selectedCategoryId = categoryId
    }
}

//MARK: - PHPickerDelegate
extension PostViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        self.selectedImages = []
        picker.dismiss(animated: true)
        
        for item in results {
            let itemProvider = item.itemProvider
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self] result, error in
                    guard let image = result as? UIImage else { return }
                    self?.selectedImages.append(image)
                    if self?.selectedImages.count == 1 {
                        DispatchQueue.main.async {
                            self?.photoButton.setImage(image, for: .normal)
                        }
                    }
                }
            }
        }
    }
}

extension PostViewController: ActionSheetPhotoDelegate {
    func didClickFirstItem() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images
        let photoPickerVC = PHPickerViewController(configuration: configuration)
        photoPickerVC.delegate = self
        self.present(photoPickerVC, animated: true)
    }
    
    func didClickSecondItem() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.cameraDevice = .front
        imagePicker.cameraCaptureMode = .photo
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true)
    }
}

extension PostViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImage: UIImage?
        if let img = info[.originalImage] as? UIImage { selectedImage = img }
        if let img = info[.editedImage] as? UIImage { selectedImage = img }
        guard let selectedImage else { return }
        self.selectedImages = [selectedImage]
        self.photoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
}
