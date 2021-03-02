//
//  Member.swift
//  TableViewApp
//
//  Created by Elijah Caluya on 3/1/21.
//

import Foundation

// Class for storing info about each member
class Member {
    // Prototype cell is determined by the sub unit of each member where a different image is used to represent each one
    enum SubUnit: String {
        case oneThird = "LOONA 1/3"
        case oddEye = "Odd Eye Circle"
        case yyxy = "Yyxy"
        case solo = "Solo"
    }
    
    var stageName: String
    var unit: SubUnit
    var firstName: String
    var lastName: String
    var birthday: String
    var debut: String
    var color: String
    var animal: String
    var pic: String
    
    init(stageName: String, unit: SubUnit, firstName: String, lastName: String, birthday: String, debut: String, color: String, animal: String, pic: String) {
        self.stageName = stageName
        self.unit = unit
        self.firstName = firstName
        self.lastName = lastName
        self.birthday = birthday
        self.debut = debut
        self.color = color
        self.animal = animal
        self.pic = pic
    }
}
