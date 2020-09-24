//
//  ContentView.swift
//  Domain Name Generator
//
//  Created by Isaac Lyons on 9/24/20.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var nameController = NameController()
    
    var body: some View {
        NavigationView {
            NameView()
        }
        .environmentObject(nameController)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
