//
//  NameView.swift
//  Domain Name Generator
//
//  Created by Isaac Lyons on 9/24/20.
//

import SwiftUI

struct NameView: View {
    
    @EnvironmentObject var nameController: NameController
    
    @State private var name: String = ""
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $name)
                    .disableAutocorrection(true)
            }
            
            Section {
                Button("Generate") {
                    nameController.generate(name: name)
                }
            }
            
            Section {
                ForEach(nameController.results, id: \.self) { domain in
                    Text(domain)
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
