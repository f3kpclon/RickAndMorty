//
//  RMAvatarIV.swift
//  RickAndMorty
//
//  Created by Felix Alexander Sotelo Quezada on 02-04-21.
//

import UIKit

class RMAvatarIV: UIImageView {
    
    let cache = NetworkManager.shared.cache
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

private extension RMAvatarIV {
    
    func config()  {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = Constants.Images.imgPlaceholder
        translatesAutoresizingMaskIntoConstraints = false
    }
}
