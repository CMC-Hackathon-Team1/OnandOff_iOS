//
//  ReportViewController.swift
//  OnandOff
//
//  Created by 신상우 on 2023/02/16.
//

import UIKit

final class ReportViewController: UIViewController {
    private let reportTableView = UITableView().then {
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.register(ReportCell.self, forCellReuseIdentifier: ReportCell.identifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSubView()
        self.layout()

        self.view.backgroundColor = .white
        self.navigationItem.title = "신고하기"
        
        self.reportTableView.delegate = self
        self.reportTableView.dataSource = self
    }
    
    //MARK: - AddSubView
    private func addSubView() {
        self.view.addSubview(self.reportTableView)
    }
    
    //MARK: - layout
    private func layout() {
        self.reportTableView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().offset(30)
            $0.bottom.equalToSuperview()
        }
    }
}

extension ReportViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ReportType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReportCell.identifier, for: indexPath) as! ReportCell
        
        cell.describtionLabel.text = ReportType.allCases[indexPath.row].description
        
        return cell
    }
}
