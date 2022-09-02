//
//  DotsAnimationView.swift
//  Chatty
//
//  Created by GONOSEN on 13/08/2022.
//

import UIKit

import UIKit

class MainButton: UIButton {
    
    // MARK: - Subvies
    
    private let dotsAnimationView = DotsAnimationView(dotSize: .init(width: 10, height: 10), dotColor: .white, animationTime: 0.9)
    
    // MARK: - Properties
    
    private var buttonTitle: String?
    public var radius: CGFloat = 8.0
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        
        buttonTitle = title(for: .normal)
        
        setupUI()
    }
}

// MARK: - Setups
private extension MainButton {
    func setupUI() {
        clipsToBounds = true
        layer.cornerRadius = radius
        
        addSubview(dotsAnimationView)
        dotsAnimationView.translatesAutoresizingMaskIntoConstraints = false
        dotsAnimationView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        dotsAnimationView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        dotsAnimationView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        dotsAnimationView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        dotsAnimationView.isHidden = true
    }
}

// MARK: - Public
extension MainButton {
    
    func startAnimation() {
        setTitle(nil, for: .normal)
        dotsAnimationView.isHidden = false
        dotsAnimationView.startAnimation()
    }
    
    func stopAnimation() {
        dotsAnimationView.stopAnimation()
        dotsAnimationView.isHidden = true
        setTitle(buttonTitle, for: .normal)
    }
}
