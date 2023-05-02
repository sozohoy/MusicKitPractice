//
//  ViewModel.swift
//  MusicKitPractice
//
//  Created by 한지석 on 2023/04/26.
//

import SwiftUI
import MusicKit
import ComposableArchitecture

struct SearchMusic1: ReducerProtocol {
    
    struct State: Equatable {
        var searchTerm = ""
        var music: MusicItemCollection<Song> = []
    }
    
    enum Action: Equatable {
        case openAppleMusic(searchUrl: URL?)
        case cancelButtonTapped
        case doneButtonTapped
        case searchTermChanged(String)
        case setMusic(MusicItemCollection<Song>)
        case resetMusic
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .searchTermChanged(let term):
            state.searchTerm = term
            return .task {
                guard !term.isEmpty else {
                    return .resetMusic
                }
                print("task")
                print(term)
                do {
                    var searchRequest = MusicCatalogSearchRequest(term: term, types: [Song.self])
                    searchRequest.limit = 15
                    let searchResponse = try await searchRequest.response()
                    print(searchResponse)
                    return .setMusic(searchResponse.songs)
                } catch {
                    print("Something Wrong")
                    return .resetMusic
                }
            }
            
        case .openAppleMusic(let searchUrl):
            if let url = searchUrl {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            } else {
                print("error")
            }
            return .none
            
        case .doneButtonTapped:
            print("done")
            return .none
            
        case .cancelButtonTapped:
            print("cancel")
            return .none
            
        case let .setMusic(songs):
            state.music = songs
            return .none
            
        case .resetMusic:
            state.music = []
            return .none
        }
    }
    
}


class SearchMusicViewModel: ObservableObject {
    
    @Published var searchTerm = ""
    @Published var song = SearchMusic()
    
    func settingMuesicAuthorization() {
        Task {
            _ = await MusicAuthorization.request()
        }
    }
    
    //                    MusicCatalogResourceRequest<Song>(matching: \.id, equalTo: MusicItemID(rawValue: searchTerm))
    func requestUpdatedSearchResult(for searchTerm: String) {
        Task {
            if searchTerm.isEmpty {
                await self.reset()
            } else {
                do {
                    //                    print("searchRequest - \(searchRequest)")
                    var searchRequest = MusicCatalogSearchRequest(term: searchTerm, types: [Song.self])
                    searchRequest.limit = 15
                    let searchResponse = try await searchRequest.response()
                    await self.apply(searchResponse: searchResponse, for: searchTerm)
                } catch {
                    await self.reset()
                }
            }
        }
    }
    
    @MainActor
    private func apply(searchResponse: MusicCatalogSearchResponse, for searchTerm: String) {
        if self.searchTerm == searchTerm {
            self.song.searchedSong = searchResponse.songs
        }
    }
    
    @MainActor
    private func reset() {
        self.song.searchedSong = []
    }
    
    
    
}

//    private let player = ApplicationMusicPlayer.shared
//    private var playerState = ApplicationMusicPlayer.shared.state
//    private var isPlaying: Bool {
//        return (playerState.playbackStatus == .playing)
//    }
//    private var musicSubscription: MusicSubscription? // 구독이 필요하지 않음
