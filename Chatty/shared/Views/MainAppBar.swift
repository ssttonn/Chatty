//
//  MainAppBar.swift
//  Chatty
//
//  Created by GONOSEN on 12/08/2022.
//

import UIKit

class MainAppBar: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        let viewFromXib = Bundle.main.loadNibNamed("MainAppBar", owner: self)
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
}
