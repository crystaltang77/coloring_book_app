//
//  Block.swift
//  coloring_book
//
//  Created by Crystal Tang on 11/24/19.
//  Copyright © 2019 Crystal Tang. All rights reserved.
//
//  Specs: block object

import Foundation

class Block {
    var code: Int?
    var coordinateX: Int
    var coordinateY: Int
    var isTapped: Bool
    
    init(code: Int, coordinateX: Int, coordinateY: Int){
        self.code = code
        self.coordinateX = coordinateX
        self.coordinateY = coordinateY
        self.isTapped = false
    }
    
    func getCode() -> Int? {
        return code
    }
    
    func getCoordinateX() -> Int {
        return coordinateX
    }
    
    func getCoordinateY() -> Int {
        return coordinateY
    }
    
    func getIsTapped() -> Bool {
        return isTapped
    }
    
    func tapped() {
        if (isTapped == false) {
            isTapped = true
        }
        else {
            isTapped = false
        }
    }
}
