//
//  ContentView.swift
//  MusicKitPractice
//
//  Created by 한지석 on 2023/04/26.
//

import SwiftUI
import MusicKit

struct ContentView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                    
            }
        }
        .searchable(text: $viewModel.searchTerm, prompt: "Music")
        .onChange(of: viewModel.searchTerm, perform: viewModel.requestUpdatedSearchResult)
        .onAppear {
            viewModel.settingMuesicAuthorization()
        }
        
    }
    

    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
