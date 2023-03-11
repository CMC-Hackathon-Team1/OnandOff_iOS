//
//  ImgPageControlView.swift
//  OnandOff
//
//  Created by 신상우 on 2023/02/25.
//

import UIKit

final class ImgPageControlView: UIView {
    private let scrollView = UIScrollView().then {
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
    }
    
    private let pageControl = UIPageControl().then {
        $0.tintColor = .purple
        $0.currentPage = 0
        $0.pageIndicatorTintColor = .text3
        $0.currentPageIndicatorTintColor = .mainColor
        $0.hidesForSinglePage = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.scrollView)
        self.addSubview(self.pageControl)
        
        self.scrollView.delegate = self
        
        self.scrollView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
        
        self.pageControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImageSlider(images: [String]) { // scrolliVew에 imageView 추가하는 함수
        self.pageControl.numberOfPages = images.count
        let width = UIScreen.main.bounds.width-88
        for index in 0..<images.count {
            DispatchQueue.global().async {
                guard let url = URL(string: images[index]) else { return }
                do {
                    let data = try Data(contentsOf: url)
                    DispatchQueue.main.async {
                        _ = UIImageView().then {
                            $0.image = UIImage(data: data)
                            $0.contentMode = .scaleAspectFit
                            $0.clipsToBounds = true
                            
                            let xPosition = width * CGFloat(index)
                            $0.frame = CGRect(x: xPosition, y: 0, width: width, height: 303)
                            
                            self.scrollView.contentSize.width = width * CGFloat(index+1)
                            self.scrollView.addSubview($0)
                        }
                    }
                } catch(let error) {
                    print(error)
                }
            }
        }
    }
    
    func resetImageView() {
        self.scrollView.subviews.forEach {
            $0.removeFromSuperview()
        }
    }
}
extension ImgPageControlView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) { // scrollView가 스와이프 될 때 발생 될 이벤트
        self.pageControl.currentPage = Int(round(scrollView.contentOffset.x / (UIScreen.main.bounds.width-88)))
    }
}
