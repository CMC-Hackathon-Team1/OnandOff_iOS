//
//  StandardAlertAction.swift
//  OnandOff
//
//  Created by 신상우 on 2023/02/18.
//

import UIKit

enum StandardAlertStyle {
    case cancel
    case basic
}

class StandardAlertAction: UIButton {
    let handler: ((StandardAlertAction) -> Void)?
    
    init(title: String?, style: StandardAlertStyle, handler: ((StandardAlertAction) -> Void)? = nil)  {
        self.handler = handler
        super.init(frame: .zero)

        switch style {
        case .cancel:
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.mainColor.cgColor
            self.setTitleColor(.mainColor, for: .normal)
            self.backgroundColor = .white
            
        case .basic:
            self.setTitleColor(.white, for: .normal)
            self.backgroundColor = .mainColor
        }
        self.titleLabel?.font = .notoSans(size: 16,family: .Bold)
        self.setTitle(title, for: .normal)
        self.addTarget(self, action: #selector(didClickAction), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selector
    @objc private func didClickAction() {
        NotificationCenter.default.post(name: .dismissStandardAlert, object: nil)
        guard let handler = handler else { return }
        handler(self)
    }
}
