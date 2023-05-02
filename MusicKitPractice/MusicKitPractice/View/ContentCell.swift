//
//  ContentCell.swift
//  MusicKitPractice
//
//  Created by 한지석 on 2023/05/01.
//

import SwiftUI
import MusicKit

struct ContentCell: View {
    
    // MARK: - Properties
    
    let artwork: Artwork?
    let title: String
    let artistName: String
    
    // MARK: - View
    
    var body: some View {
        HStack {
            if let existingArtwork = artwork {
                VStack {
                    Spacer()
                    ArtworkImage(existingArtwork, width: 56)
                        .cornerRadius(6)
                    Spacer()
                }
            }
            VStack(alignment: .leading) {
                Text(title)
                    .lineLimit(1)
                    .foregroundColor(.primary)
                if !artistName.isEmpty {
                    Text(artistName)
                        .lineLimit(1)
                        .foregroundColor(.secondary)
                        .padding(.top, -4.0)
                }
            }
        }
    }
}


