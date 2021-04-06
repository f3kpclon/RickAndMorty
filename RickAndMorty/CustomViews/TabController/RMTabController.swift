//
//  RMTabController.swift
//  RickAndMorty
//
//  Created by Felix Alexander Sotelo Quezada on 29-03-21.
//

import UIKit

class RMTabController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemPurple
        viewControllers = [createCharactersNC(), createLocationNC()]
    }
}
private extension RMTabController {
    func createCharactersNC() -> UINavigationController {
        let characterVC = RMCharactersVC()
        characterVC.title = "Characters"
        characterVC.tabBarItem = UITabBarItem(title: "Characters",  image: Constants.RMSystemSymbols.characters , tag: 0)
        return UINavigationController(rootViewController: characterVC)
    }
    
    func createLocationNC() -> UINavigationController {
        let locationVC = RMLocationsVC()
        locationVC.title = "Locations"
        locationVC.tabBarItem = UITabBarItem(title: "Locations", image:Constants.RMSystemSymbols.locations , tag: 1)
        return UINavigationController(rootViewController: locationVC)
    }
}
