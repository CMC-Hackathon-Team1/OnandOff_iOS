//
//  ReportViewController.swift
//  OnandOff
//
//  Created by 신상우 on 2023/02/16.
//

import UIKit

final class ReportViewController: UIViewController {
    private let feedId: Int
    
    private var selectedType: ReportType? {
        didSet {
            if selectedType != nil {
                self.agreeButton.isEnabled = true
            }
        }
    }
    
    private let reportTableView = UITableView().then {
        $0.rowHeight = UITableView.automaticDimension
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.register(ReportCell.self, forCellReuseIdentifier: ReportCell.identifier)
    }
    
    private let agreeButton = mainButton(type: .system).then {
        $0.isEnabled = false
        $0.setTitle("동의", for: .normal)
    }
    
    //MARK: - Init
    init(_ feedId: Int) {
        self.feedId = feedId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubView()
        self.layout()
        self.addTarget()

        self.view.backgroundColor = .white
        self.navigationItem.title = "신고하기"
        
        self.reportTableView.delegate = self
        self.reportTableView.dataSource = self
    }
    
    //MARK: - Selector
    @objc private func didClickAgreeButton() {
        guard let selectedType else { return }
        
        if self.selectedType != nil {
            let alert = StandardAlertController(title: nil, message: "해당 게시글을 신고하시겠습니까?")
            let cancel = StandardAlertAction(title: "취소", style: .cancel)
            let report = StandardAlertAction(title: "신고", style: .basic) { _ in
                FeedService.reportFeed(feedId: self.feedId, categoryId: selectedType.rawValue, content: nil) { response in
                    self.respondToStatusCode(response)
                }
            }
            alert.addAction([cancel, report])
            
            self.present(alert, animated: false)
        }
    }
    
    private func respondToStatusCode(_ res: ReportModel) {
        var message = "다시 시도해주세요."
        switch res.statusCode {
        case 100: message = "신고가 완료되었습니다."
        case 400: print(" 올바르지 않은 paramerter")
        case 401: print("인증 에러")
        case 501: print("DB 에러")
        default: message = res.message
        }
        let alert = StandardAlertController(title: nil, message: message)
        let ok = StandardAlertAction(title: "확인", style: .basic)
        alert.addAction(ok)
        
        self.present(alert, animated: true)
    }
    
    //MARK: - AddSubView
    private func addSubView() {
        self.view.addSubview(self.reportTableView)
        self.view.addSubview(self.agreeButton)
    }
    
    //MARK: - layout
    private func layout() {
        self.reportTableView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.bottom.equalTo(self.agreeButton.snp.top)
        }
        
        self.agreeButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(34)
            $0.trailing.equalToSuperview().offset(-34)
            $0.height.equalTo(49)
            $0.centerY.equalToSuperview().offset(40)
        }
    }
    
    //MARK: - AddTarget
    private func addTarget() {
        self.agreeButton.addTarget(self, action: #selector(didClickAgreeButton), for: .touchUpInside)
    }
}

extension ReportViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ReportType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReportCell.identifier, for: indexPath) as! ReportCell
        let reportType = ReportType.allCases[indexPath.row]
        let isHidden = ReportType.allCases.count-1 == indexPath.row ? false : true
        cell.otherTextField.isHidden = isHidden
        
        if let selectedType = selectedType {
            let image = selectedType == reportType ? UIImage(named: "anonymousCheck") : UIImage(named: "anonymousCheckOff")
            cell.checkImageView.image = image
        }
        cell.describtionLabel.text = reportType.description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedType = ReportType.allCases[indexPath.row]
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight
    }
    
}
