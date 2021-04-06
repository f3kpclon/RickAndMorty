//
//  RMCharacter.swift
//  RickAndMorty
//
//  Created by Felix Alexander Sotelo Quezada on 30-03-21.
//

import Foundation

struct Character: Codable, Hashable {
    let id      : Int
    let name    : String
    let status  : String
    let species : String
    let gender  : String
    let location: CharLocation
    let image   : String
}

struct CharLocation: Codable, Hashable {
    let localName : String
    let localUrl : String
    
    enum CodingKeys : String, CodingKey {
        case localName = "name"
        case localUrl  = "url"
    }
}
