//
//  Picture.swift
//  coloring_book
//
//  Created by Crystal Tang on 11/24/19.
//  Copyright © 2019 Crystal Tang. All rights reserved.
//

import UIKit

import Foundation

class Picture {
    var name: String
    var preview: String
    var colorDictionary: [Int: UIColor] = [:]
    var blueprint : [Block]
    var numColors : Int
    var numBlocks: Int
    
    //    init(preview: String) {
    //        self.preview = preview
    //    }
    //
    init(name: String, preview: String, colorDictionary: [Int: UIColor], blueprint: [Block]){
        self.name = name
        self.preview = preview
        self.colorDictionary = colorDictionary
        self.blueprint = blueprint
        self.numColors = colorDictionary.count
        self.numBlocks = blueprint.count
    }
    
    func getName() -> String {
        return name
    }
    
    func getPreview() -> String {
        return preview
    }
    
    func getColorDictionary() -> [Int: UIColor] {
        return colorDictionary
    }
    
    func getBlueprint() -> [Block] {
        return blueprint
    }
    
    func getNumColors() -> Int {
        return numColors
    }
    
    func getNumBlocks() -> Int {
        return numBlocks
    }
}
