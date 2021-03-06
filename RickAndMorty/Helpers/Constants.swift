//
//  Constants.swift
//  RickAndMorty
//
//  Created by Felix Alexander Sotelo Quezada on 29-03-21.
//

import Foundation
import UIKit
struct Constants {
    
    enum RMUrl {
        static let apiUrl = "https://rickandmortyapi.com/api"
    }
    
    enum RMSystemSymbols {
        static let characters = UIImage(systemName: "person.3")
        static let locations  = UIImage(systemName: "map")
        static let location = UIImage(systemName: "mappin.and.ellipse")
    }
    
    enum Images {
        static let imgPlaceholder = UIImage(named: "RickandMortyPlaceholder")
        static let imgNotFound    = UIImage(named: "RM404")
    }
    
    enum Section {
        case main
    }
}

