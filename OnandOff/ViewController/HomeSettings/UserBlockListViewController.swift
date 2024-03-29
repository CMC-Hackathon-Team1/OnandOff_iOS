//
//  UserBlockListViewController.swift
//  OnandOff
//
//  Created by 신상우 on 2023/05/18.
//

import UIKit

final class UserBlockListViewController: UIViewController {
    //MARK: - Properties
    var userList = [BlockProfileItem]()
    
    private let tableView = UITableView().then {
        $0.separatorStyle = .none
        $0.register(BlockProfileCell.self, forCellReuseIdentifier: BlockProfileCell.identifier)
        $0.backgroundColor = .white
    }
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "차단된 계정"
        
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.willUnBlockProfile), name: .unBlockProfile, object: nil)
        
        ProfileService.fetchBlockProfileList() { [weak self] model in
            self?.userList = model.result ?? []
            self?.tableView.reloadData()
        }
    }
    
    //MARK: - Selector
    @objc private func willUnBlockProfile(_ notification: Notification) {
        let alert = StandardAlertController(title: nil, message: "해당 유저를 차단 해제하시겠어요?")
        alert.messageHighlight(highlightString: "차단 해제", color: .point)
        
        let cancel = StandardAlertAction(title: "취소", style: .cancel)
        let ok = StandardAlertAction(title: "차단 해제", style: .basic) { _ in
            let toProfileId = notification.object as! Int
            ProfileService.blockProfile(toProfileId, block: false) { statusCode in
                switch statusCode {
                case 3704:
                    let alert = StandardAlertController(title: nil, message: "차단 해제하였습니다.\n검색을 통해 해당 유저를 다시 만나 볼 수 있습니다.")
                    alert.messageHighlight(highlightString: "차단 해제", color: .point)
                    let ok = StandardAlertAction(title: "확인", style: .basic) { _ in
                        ProfileService.fetchBlockProfileList() { [weak self] model in
                            self?.userList = model.result ?? []
                            self?.tableView.reloadData()
                        }
                    }
                    alert.addAction(ok)
                    
                    self.present(alert, animated: false)
                default:
                    self.defaultAlert(title: "차단 해제 실패")
                }
            }
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        self.present(alert, animated: false)
    }
}

extension UserBlockListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BlockProfileCell.identifier, for: indexPath) as! BlockProfileCell
        cell.configureCell(self.userList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 61
    }
}
