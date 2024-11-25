//
//  PageIndicatorCollectionReusableView.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 25/11/24.
//

import UIKit

class PageIndicatorCollectionReusableView: UICollectionReusableView {
    static let identifier = "PageIndicatorCollectionReusableView"
    
    let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.numberOfPages = 3
        pc.currentPage = 0
        pc.pageIndicatorTintColor = UIColor(color: .pageIndicator).withAlphaComponent(0.5)
        pc.currentPageIndicatorTintColor = UIColor(color: .pageIndicator)
        pc.translatesAutoresizingMaskIntoConstraints = false
        return pc
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: topAnchor),
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor),
            pageControl.leadingAnchor.constraint(equalTo: leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(totalPages: Int) {
        self.pageControl.numberOfPages = totalPages
    }
    
    func currentPage(_ page: Int) {
        pageControl.currentPage = page
    }
}
