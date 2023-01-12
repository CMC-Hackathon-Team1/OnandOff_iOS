//
//  PersonaCollectionViewCell.swift
//  OnandOff
//
//  Created by woonKim on 2023/01/03.
//
import UIKit
import SnapKit
import Then

class PersonaCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "cell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.cellSetting()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with collection: Collection) {
        imageView.image = collection.image
        persona.text = collection.persona
    }
    
    func cellSetting() {
        self.backgroundColor = .clear
        self.addSubview(imageView)
        self.addSubview(persona)
        
        imageView.contentMode = .scaleToFill
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(0)
            $0.bottom.equalToSuperview().inset(40)
        }

        persona.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(13)
            $0.leading.trailing.equalToSuperview().inset(0.5)
     
        }
    }
    
    let imageView = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let persona = UILabel().then {
        $0.font = .systemFont(ofSize: 16.5, weight: .semibold)
        $0.textColor = .black
    }
}

struct Collection {
  
    let image: UIImage?
    let persona: String?
}

let collections: [Collection] = [Collection(image: UIImage(named: "cell1"), persona: "리저브 뉴이어 커피 & 원두 출시"),
                                 Collection(image: UIImage(named: "cell1"), persona: "리저브 뉴이어 커피 & 원두 출시"),
                                 Collection(image: UIImage(named: "cell1"), persona: "리저브 뉴이어 커피 & 원두 출시")
]
