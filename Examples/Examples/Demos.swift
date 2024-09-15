//
//  Demos.swift
//  Examples
//
//  Created by Ömer Hamid Kamışlı on 9/14/24.
//

import SwiftUI

struct Demos: View {
    @State var path: NavigationPath = .init()
    
    var body: some View {
        NavigationStack(path: $path){
            VStack {
                Button("Network Async Await") {
                    path.append("NetworkAsyncAwait")
                }
            }
            .navigationDestination(for: String.self) { destination in
                switch destination {
                case "NetworkAsyncAwait":
                    PKSNetworkAsyncAwaitExample()
                default:
                    EmptyView()
                }
            }
            .navigationTitle("Available Demos")
        }
        
    }
}
