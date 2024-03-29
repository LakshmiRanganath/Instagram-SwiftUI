//
//  Feedzview.swift
//  LearningInstagram
//
//  Created by Lakshmi Ranganatha Hema on 20/03/24.
//

import AVFoundation
import SwiftUI

struct ReelsView: View {
    @ObservedObject var reelsViewModel: ReelsViewModel
    @State var scrollPosition: String?
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(reelsViewModel
                    .feedPlayers) { feedPlayer in
                    ReelsCell(feed: feedPlayer.feed, player: feedPlayer.player)
                        .id(feedPlayer.id)
                        .onAppear(perform: {
                            feedPlayer.player.seek(to: .zero)
                            feedPlayer.player.play()
                        })
                        .onDisappear(perform: {
                            feedPlayer.player.pause()
                        })
                }
            }
            .scrollTargetLayout()
        }
        .toolbarBackground(.hidden, for: .navigationBar)
        .scrollIndicators(.hidden)
        .scrollPosition(id: $scrollPosition)
        .scrollTargetBehavior(.paging)
        .ignoresSafeArea()
        .onChange(of: scrollPosition ?? "", { oldPosition, newPosition in
            Task {
                self.playVideoOnScroll(newFeedId: newPosition, oldFeedId: oldPosition)
            }
        })
    }

    func playFirstVideoIfRequired() {
        guard scrollPosition == nil, let firstFeedPlayer = reelsViewModel.feedPlayers.first else { return }
        
        DispatchQueue.main.async {
            firstFeedPlayer.player.seek(to: .zero)
            firstFeedPlayer.player.play()
        }
    }
    
    func playVideoOnScroll(newFeedId: String, oldFeedId: String) {
        guard let previousFeedPlayer = reelsViewModel.feedPlayers.first(where: {
            $0.id == oldFeedId
        }) else { return }
        
        DispatchQueue.main.async {
            previousFeedPlayer.player.pause()
        }
        guard let currentFeedPlayer = reelsViewModel.feedPlayers.first(where: {
            $0.id == newFeedId
        }) else { return }
        
        DispatchQueue.main.async {
            currentFeedPlayer.player.seek(to: .zero)
            currentFeedPlayer.player.play()
        }
    }
}

#Preview {
    ReelsView(reelsViewModel: ReelsViewModel(feeds: []))
}
