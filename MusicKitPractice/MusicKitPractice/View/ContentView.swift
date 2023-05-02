//
//  ContentView.swift
//  MusicKitPractice
//
//  Created by 한지석 on 2023/04/26.
//

import SwiftUI

import ComposableArchitecture
import MusicKit


struct ContentView: View {
    
    @StateObject private var viewModel = SearchMusicViewModel()
    let store: StoreOf<SearchMusic1>
    
    private var searchResultsList: some View {
        WithViewStore(self.store, observe: {$0}) { viewStore in
            List(viewStore.music.isEmpty ? [] : viewStore.music) { music in
                ContentCell(artwork: music.artwork, title: music.title, artistName: music.artistName)
                    .onTapGesture {
                        viewStore.send(.openAppleMusic(searchUrl: music.url))
                    }
            }
        }
    }
    
    var body: some View {
        WithViewStore(self.store,
                      observe: { $0 }) { viewStore in
            NavigationView {
                searchResultsList
            }
            .searchable(text: viewStore.binding(get: \.searchTerm, send: SearchMusic1.Action.searchTermChanged))
//            .onAppear {
//                viewModel.settingMuesicAuthorization()
//            }
        }
    }
    

    
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
