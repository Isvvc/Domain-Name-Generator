//
//  NameController.swift
//  Domain Name Generator
//
//  Created by Isaac Lyons on 9/24/20.
//

import Foundation

class NameController: ObservableObject {
    
    @Published var results: [String] = []
    @Published var simpleName: String = ""
    
    var tlds: [String]
    
    init() {
        let tldsURL = Bundle.main.url(forResource: "TLDs", withExtension: "txt")!
        let tldsString = try! String(contentsOf: tldsURL)
        let tlds = tldsString.components(separatedBy: .newlines).map { $0.lowercased() }
        self.tlds = tlds.dropFirst().dropLast()
    }
    
    func generate(name: String) {
        var results: [String] = []
        
        var simpleName = name.lowercased()
        simpleName = simpleName.filter { CharacterSet(charactersIn: String($0)).isSubset(of: CharacterSet.lowercaseLetters) }
        
        var perfectName = simpleName
        while perfectName.count > 1 {
            results.append(contentsOf: perfectMatches(name: perfectName))
            perfectName = String(perfectName.dropLast())
        }
        
        self.results = results
        self.simpleName = simpleName
    }
    
    private func perfectMatches(name: String) -> [String] {
        var matches: [String] = []
        
        for tld in tlds {
            let length = tld.count
            if name.suffix(length) == tld {
                var domain = name
                domain.insert(".", at: domain.index(domain.endIndex, offsetBy: -1 * length))
                matches.append(domain)
            }
        }
        
        return matches
    }
    
}
