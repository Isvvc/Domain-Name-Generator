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
            Section {
                Toggle("Swap vowels in TLD", isOn: $vowelSwap)
            }
            
            Section {
                Toggle("Combine vowels in TLD", isOn: $vowelCombo)
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
