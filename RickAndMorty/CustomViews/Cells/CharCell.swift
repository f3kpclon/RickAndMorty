//
//  CharCell.swift
//  RickAndMorty
//
//  Created by Felix Alexander Sotelo Quezada on 05-04-21.
//

import UIKit

class CharCell: UICollectionViewCell {
    
    static let reuseID = "CharCell"
    
    let avatarImg       = RMAvatarIV(frame: .zero)
    let charName        = RMTittleLabel(textAlignment: .left, fontSize: 20)
    let charLocation    = RMSecondaryLabel(textAlignment: .left, fontSize: 14)
    let charImgLocation = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame:  frame)
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func config() {
        charImgLocation.image   = Constants.RMSystemSymbols.location
        charImgLocation.tintColor  = .secondaryLabel
        addSubViews(avatarImg,charName,charLocation,charImgLocation)
        setConstraints()
    }
    
    private func setConstraints() {
        let padding : CGFloat = 8
        charImgLocation.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            MARK: Image Constraints
            avatarImg.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarImg.heightAnchor.constraint(equalTo: contentView.widthAnchor),
//            MARK: titleLabel constraints
            charName.topAnchor.constraint(equalTo: avatarImg.bottomAnchor, constant: padding),
            charName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            charName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -padding),
            charName.heightAnchor.constraint(equalToConstant: 30),
//            MARK: LoactionImg Constraint
            charImgLocation.topAnchor.constraint(equalTo: charName.bottomAnchor, constant: padding),
            charImgLocation.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            charImgLocation.heightAnchor.constraint(equalToConstant: 20),
            charImgLocation.widthAnchor.constraint(equalToConstant: 20),
//            MARK: CharLabel Constraints
            charLocation.centerYAnchor.constraint(equalTo: charImgLocation.centerYAnchor),
            charLocation.leadingAnchor.constraint(equalTo: charImgLocation.trailingAnchor, constant: padding),
            charLocation.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            charLocation.heightAnchor.constraint(equalToConstant: 20)
        
        ])
    }
    
    func setCharacters(characters: Character)  {
        charName.text           = characters.name
        charLocation.text       = characters.location.localName
        downloadImage(for: characters.image)
    }
    
    func downloadImage(for avatarString: String)  {
        NetworkManager.shared.downloadImage(from: avatarString) {[weak self] image in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.avatarImg.image = image
            }
        }
    }
}
