//
//  NameView.swift
//  Domain Name Generator
//
//  Created by Isaac Lyons on 9/24/20.
//

import SwiftUI

struct NameView: View {
    
    @StateObject private var nameController = NameController()
    
    @State private var name: String = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $name)
            }
            
            Section {
                Button("Generate") {
                    print(name)
                }
            }
        }
        .navigationTitle("Domains")
    }
}

struct NameView_Previews: PreviewProvider {
    static var previews: some View {
        NameView()
    }
}
