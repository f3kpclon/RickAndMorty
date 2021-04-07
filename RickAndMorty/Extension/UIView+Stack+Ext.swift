//
//  UIView+Ext.swift
//  RickAndMorty
//
//  Created by Felix Alexander Sotelo Quezada on 05-04-21.
//

import UIKit

//MARK: UIView Extenesion
extension UIView {
    
    func addSubViews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
    func customActivityIndicator() {
        
        let view = UIView()
        //    setting up a background for a view so it would make content under it look like not active
        view.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.7)

        //    adding "loading" view to a parent view
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            view.leftAnchor.constraint(equalTo: self.leftAnchor),
            view.rightAnchor.constraint(equalTo: self.rightAnchor),
        ])
        

        //    creating array with images, which will be animated
        var imagesArray = [UIImage(named: "RMActivity\(1)")!]
        for i in 1...4 {
            imagesArray.append(UIImage(named: "RMActivity\(i)")!)
        }

        //    creating UIImageView with array of images
        //    setting up animation duration and starting animation
        let activityImage = UIImageView()
        activityImage.animationImages = imagesArray
        activityImage.animationDuration = TimeInterval(0.5)
        activityImage.startAnimating()

        //    adding UIImageView on "loading" view
        //    setting up auto-layout anchors so it would be in center of "loading" view with 30x30 size
        view.addSubview(activityImage)
        activityImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityImage.widthAnchor.constraint(equalToConstant: 90),
            activityImage.heightAnchor.constraint(equalToConstant: 90 )
        ])
       
    }

    func removeActivityIndicator() {
            //    checking if a view has subviews on it
            guard let self = self.subviews.last else { return }
            //    removing last subview with an assumption that last view is a "loading" view
            self.removeFromSuperview()
    }
}
//MARK: UIStackView Extenesion
extension UIStackView {
    func addStacks(_ stacks: UIView...)  {
        for stack in stacks {
            addArrangedSubview(stack)
        }
    }
}
