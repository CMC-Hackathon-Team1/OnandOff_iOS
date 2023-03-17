//
//  CustomActionSheet.swift
//  OnandOff
//
//  Created by SangWoo's MacBook on 2023/01/03.
//

import UIKit

final class CustomActionSheet: UIView {
    //MARK: - Properties
    private let ASFrame: CGRect
    private var categories: [CategoryItem] = []
    private var currentCategoryId = 0
    private let categoryTableView: UITableView!
    
    private let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular)).then {
        $0.alpha = 0.5
    }

    //MARK: - Init
    init(frame: CGRect, ASFrame: CGRect, currentCategoryId: Int) {
        self.ASFrame = ASFrame
        self.categoryTableView = UITableView(frame: ASFrame).then {
            $0.backgroundColor = .white
        }
        self.currentCategoryId = currentCategoryId
        super.init(frame: frame)
        
        self.configureTableView()
        self.addSubView()
        self.layout()
        self.setTapGesture()
        FeedService.getCategoryAPI { [weak self] items in
            self?.categories = items
            self?.categoryTableView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Gesture
    private func setTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.didTapBlurView))
        self.blurEffectView.addGestureRecognizer(tap)
    }
    
    //MARK: - Method
    private func configureTableView() {
        self.categoryTableView.backgroundColor = .white
        self.categoryTableView.layer.cornerRadius = 8.5
        self.categoryTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        self.categoryTableView.delegate = self
        self.categoryTableView.dataSource = self
    }
    
    //MARK: - Selector
    @objc private func didTapBlurView() {
        self.removeFromSuperview()
    }
    
    //MARK: - draw
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let path = UIBezierPath().then {
            $0.move(to: .init(x: ASFrame.origin.x + 30, y: ASFrame.origin.y))
            $0.addLine(to: .init(x: ASFrame.origin.x + 40, y: ASFrame.origin.y - 15))
            $0.addLine(to: .init(x: ASFrame.origin.x + 50, y: ASFrame.origin.y))
        }
        
        _ = CAShapeLayer().then {
            $0.path = path.cgPath
            $0.fillColor = UIColor.white.cgColor
            self.layer.addSublayer($0)
        }
    }
    
    //MARK: - addSubView
    private func addSubView() {
        self.addSubview(self.blurEffectView)
        self.addSubview(self.categoryTableView)
    }
    
    //MARK: - layout
    private func layout() {
        self.blurEffectView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
}

extension CustomActionSheet: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].categoryName
        cell.textLabel?.textColor = .black
        cell.textLabel?.font = .notoSans(size: 12)
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        
        if categories[indexPath.row].categoryId == self.currentCategoryId {
            cell.textLabel?.text = "카테고리 전체"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if categories[indexPath.row].categoryId == self.currentCategoryId {
            NotificationCenter.default.post(name: .selectCategory, object: nil)
        } else {
            NotificationCenter.default.post(name: .selectCategory, object: categories[indexPath.row])
        }
        
        self.removeFromSuperview()
    }
}

