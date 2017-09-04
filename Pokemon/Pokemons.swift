//
//  Pokemons.swift
//  Pokemon
//
//  Created by Jennifer Liu on 9/3/17.
//  Copyright © 2017 Jennifer Liu. All rights reserved.
//

import UIKit

class Pokemons {
    
    var latitude: Double?
    var longitude: Double?
    var image: String?
    var name: String?
    var destination: String?
    var power: Double?
    var isCatch: Bool?
    init(latitude: Double, longitude: Double, image: String, name: String, destination: String, power: Double){
        self.latitude = latitude
        self.longitude = longitude
        self.image = image
        self.name = name
        self.destination = destination
        self.power = power
        self.isCatch = false
        
    }
    
    

}
