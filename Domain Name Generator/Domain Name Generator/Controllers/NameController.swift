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
    
    //MARK: Generation
    
    func generate(name: String) {
        var results: [String] = []
        
        var simpleName = name.lowercased()
        simpleName = simpleName.filter { CharacterSet(charactersIn: String($0)).isSubset(of: CharacterSet.lowercaseLetters) }
        
        var perfectName = simpleName
        while perfectName.count > 1 {
            results.append(contentsOf: perfectMatches(name: perfectName))
            perfectName = String(perfectName.dropLast())
        }
        
        if UserDefaults.standard.bool(forKey: Key.vowelSwap) {
            appendNewContents(of: vowelSwap(name: simpleName, combo: false), to: &results)
            
            if UserDefaults.standard.bool(forKey: Key.vowelCombo) {
                appendNewContents(of: vowelSwap(name: simpleName, combo: true), to: &results)
            }
        }
        
        self.results = results
        self.simpleName = simpleName
    }
    
    private func perfectMatches(name: String) -> [String] {
        var matches: [String] = []
        
        for tld in tlds {
            let length = tld.count
            if name.suffix(length) == tld,
               length < name.count {
                var domain = name
                domain.insert(".", at: domain.index(domain.endIndex, offsetBy: -1 * length))
                matches.append(domain)
            }
        }
        
        return matches
    }
    
    private func vowelSwap(name: String, combo: Bool) -> [String] {
        var matches: [String] = []
        let wildcardedName = wildcard(name, combo: combo)
        
        for tld in tlds {
            let wildcardedTLD = wildcard(tld, combo: combo)
            let length = wildcardedTLD.count
            if wildcardedName.count > length,
               wildcardedName.suffix(length) == wildcardedTLD {
                var domain = String(name.prefix(upTo: name.index(name.endIndex, offsetBy: -1 * length)))
                domain.append(".\(tld)")
                matches.append(domain)
            }
        }
        
        return matches
    }
    
    //MARK: Helper
    
    private func wildcard(_ string: String, combo: Bool = false) -> String {
        var result = string.replacingOccurrences(of: "a", with: "*")
            .replacingOccurrences(of: "e", with: "*")
            .replacingOccurrences(of: "i", with: "*")
            .replacingOccurrences(of: "o", with: "*")
            .replacingOccurrences(of: "u", with: "*")
            .replacingOccurrences(of: "y", with: "*")
        
        if combo {
            var previous = result[result.startIndex]
            var index = result.index(after: result.startIndex)
            while index < result.endIndex {
                if previous == "*",
                   result[index] == "*" {
                    result.remove(at: index)
                } else {
                    previous = result[index]
                    index = result.index(after: index)
                }
            }
        }
        
        return result
    }
    
    private func appendNewContents<T: Comparable>(of newElements: [T], to results: inout [T]) {
        for newElement in newElements where !results.contains(newElement) {
            results.append(newElement)
        }
    }
    
}
