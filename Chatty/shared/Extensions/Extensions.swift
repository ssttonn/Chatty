//
//  Extensions.swift
//  Chatty
//
//  Created by GONOSEN on 12/08/2022.
//

import Foundation
import Lottie

extension AnimationView{
    func initCustomBehavior(){
        // 1. Set animation content mode
        contentMode = .scaleAspectFit
        
        // 2. Set animation loop mode
        
        loopMode = .loop
        
        // 3. Adjust animation speed
        
        animationSpeed = 0.5
        
        // 4. Play animation
        play()
    }
}

struct JSON {
    static let encoder = JSONEncoder()
    static let decoder = JSONDecoder()
}

extension Encodable {
    subscript(key: String) -> Any? {
        return dictionary[key]
    }
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSON.encoder.encode(self))) as? [String: Any] ?? [:]
    }
}

extension Model{
    var entity: T?{
        _entity
    }
    
    mutating func withEntity(entity: T) {
        _entity = entity
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.entity?.id == rhs.entity?.id
    }
}

extension UIBarButtonItem{
    static func menuButton(_ target: Any?, action: Selector, imageName: String) -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        return menuBarItem
    }
}

extension UIStoryboard{
    static var main: UIStoryboard{
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
}
