//
//  ViewModel.swift
//  MusicKitPractice
//
//  Created by 한지석 on 2023/04/26.
//

import SwiftUI
import MusicKit

class ViewModel: ObservableObject {
    @Published var searchTerm = ""
    @Published var song: [Song] = []
    
    // print Song (곡 정보)
    // init 0
    // play, pause?
    
    func settingMuesicAuthorization() {
        Task {
            let status = await MusicAuthorization.request()
        }
        
    }
    
    func requestUpdatedSearchResult(for searchTerm: String) {
        Task {
            if searchTerm.isEmpty {
                self.song = []
            } else {
                do {
                    var searchRequest = MusicCatalogSearchRequest(term: searchTerm, types: [Song.self])
                    searchRequest.limit = 15
                    print("searchRequest - \(searchRequest)")
                    let searchResponse = try await searchRequest.response()
                    print("searchResponse - \(searchResponse)")
                } catch {
                    print(error)
                }
            }
        }

    }
}
