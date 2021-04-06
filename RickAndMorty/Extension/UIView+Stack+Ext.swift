//
//  UIView+Ext.swift
//  RickAndMorty
//
//  Created by Felix Alexander Sotelo Quezada on 05-04-21.
//

import UIKit

extension UIView {
    
    func addSubViews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}

extension UIStackView {
    func addStacks(_ stacks: UIView...)  {
        for stack in stacks {
            addArrangedSubview(stack)
        }
    }
}
