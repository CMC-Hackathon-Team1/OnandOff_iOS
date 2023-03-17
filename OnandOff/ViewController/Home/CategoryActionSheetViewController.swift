//
//  CategorySelectionViewController.swift
//  OnandOff
//
//  Created by 077tech on 2023/01/06.
//

import UIKit

final class CategoryActionSheetViewController: UIViewController {
    //MARK: - Properties
    private var categories: [CategoryItem] = []
    weak var delegate: CategoryDelegate?
    
    private let mainView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private let mainLabel = UILabel().then{
        $0.text = "카테고리"
        $0.font = .notoSans(size: 16)
    }
    
    private let closeButton = UIImageView().then{
        $0.image = UIImage(named: "close")?.withRenderingMode(.alwaysOriginal)
    }
    
    private let categoryTableView = UITableView().then {
        $0.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.identifier)
        $0.backgroundColor = .white
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        FeedService.getCategoryAPI { [weak self] items in
            self?.categories = items
            self?.categoryTableView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray
        
        setUpView()
        layout()
        addTarget()
        
        self.categoryTableView.delegate = self
        self.categoryTableView.dataSource = self
    }
    
    //MARK: - Selector
    @objc func didClickClose(sender: UITapGestureRecognizer) {
        print("didClickClose")
        self.dismiss(animated: true)
    }
    
    //MARK: - addSubView
    private func setUpView(){
        self.view.addSubview(self.mainView)
        
        self.mainView.addSubview(self.closeButton)
        self.mainView.addSubview(self.mainLabel)
        self.mainView.addSubview(self.categoryTableView)
    }
    
    //MARK: - Layout
    private func layout(){
        self.mainView.snp.makeConstraints {
            $0.bottom.trailing.leading.equalToSuperview()
            $0.height.equalTo(300)
        }
        
        self.closeButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.equalToSuperview().offset(28)
        }
        
        self.mainLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.centerX.equalToSuperview()
        }
        
        self.categoryTableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(self.mainLabel.snp.bottom).offset(16)
            $0.bottom.equalToSuperview()
        }
    }
    
    //MARK: - AddTarget
    private func addTarget() {
        let closeBtn = UITapGestureRecognizer(target: self, action: #selector(didClickClose))
        closeButton.isUserInteractionEnabled = true
        closeButton.addGestureRecognizer(closeBtn)
    }
}

//MARK: - TableViewDelegate
extension CategoryActionSheetViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
        cell.configureImage(categories[indexPath.row].categoryId)
        cell.nameLabel.text = categories[indexPath.row].categoryName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 53
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.selectedCategory(categories[indexPath.row].categoryId)
        self.dismiss(animated: true)
    }
}

