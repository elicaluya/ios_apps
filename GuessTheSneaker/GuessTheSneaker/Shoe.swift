//
//  Shoe.swift
//  GuessTheSneaker
//
//  Created by Elijah Caluya on 3/3/21.
//

import Foundation

class Shoe {
    var id: String?
    var brand: String?
    var model: String?
    var colorway: String?
    
    init(id: String?, brand: String?, model: String?, colorway: String?) {
        self.id = id
        self.brand = brand
        self.model = model
        self.colorway = colorway
    }
}
