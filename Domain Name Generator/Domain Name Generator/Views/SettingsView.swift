//
//  SettingsView.swift
//  Domain Name Generator
//
//  Created by Isaac Lyons on 9/24/20.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage(Key.vowelSwap) var vowelSwap: Bool = false
    @AppStorage(Key.vowelCombo) var vowelCombo: Bool = false
    
    var body: some View {
        Form {
            Section(footer: Text("Alexina generates both alexi.na and alexi.ne")) {
                Toggle("Swap vowels in TLD", isOn: $vowelSwap)
            }
            
            if vowelSwap {
                Section(footer: Text("Alexina generates both alexi.na and alexin.ai" + "\n" +
                                        "Alexandrea generates both alexandr.ea and alexand.re")) {
                    Toggle("Combine vowels in TLD", isOn: $vowelCombo)
                }
            }
        }
        .navigationTitle("Settings")
    }
}

struct Settings_View_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
