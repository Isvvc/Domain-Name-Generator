//
//  NameController.swift
//  Domain Name Generator
//
//  Created by Isaac Lyons on 9/24/20.
//

import Foundation

class NameController: ObservableObject {
    
    var tlds: [String]
    
    init() {
        let tldsURL = Bundle.main.url(forResource: "TLDs", withExtension: "txt")!
        let tldsString = try! String(contentsOf: tldsURL)
        let tlds = tldsString.components(separatedBy: .newlines)
        self.tlds = tlds.dropFirst().dropLast()
    }
}
