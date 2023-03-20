//
//  StandardActionSheetAction.swift
//  OnandOff
//
//  Created by 신상우 on 2023/03/20.
//

import UIKit

final class StandardActionSheetAction: UIButton {
    let handler: ((StandardActionSheetAction) -> Void)?
    let lineLayer = CALayer().then {
        $0.backgroundColor = UIColor.text3.cgColor
    }
    
    init(title: String?, image: UIImage?, handler: ((StandardActionSheetAction) -> Void)? = nil) {
        self.handler = handler
     
        super.init(frame: .zero)
        var configuration = UIButton.Configuration.plain()
        configuration.title = "     \(title ?? "")"
        configuration.image = image
        configuration.imagePlacement = .leading
        configuration.baseForegroundColor = .black
        configuration.buttonSize = .large
        
        self.contentHorizontalAlignment = .leading
    
        self.configuration = configuration
        
        self.layer.addSublayer(lineLayer)

        self.addTarget(self, action: #selector(didClickAction), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.lineLayer.frame = .init(x: 10, y: 0, width: self.frame.width - 20, height: 1)
    }
    
    @objc private func didClickAction(_ button: UIButton) {
        NotificationCenter.default.post(name: .dismissStandardActionSheet, object: nil)
        guard let handler else { return }
        handler(self)
    }
}
