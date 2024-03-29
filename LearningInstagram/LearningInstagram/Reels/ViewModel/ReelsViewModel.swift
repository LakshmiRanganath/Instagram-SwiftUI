//
//  FeedViewModel.swift
//  LearningInstagram
//
//  Created by Lakshmi Ranganatha Hema on 21/03/24.
//

import Combine
import Foundation
import AVKit
import SwiftUI


class ReelsViewModel: ObservableObject {
    @Published var feeds = [Feed]()
    @Published var feedPlayers = [FeedPlayer]()
    var cancellables = Set<AnyCancellable>()
    var currentIndex = 0
    
    init(feeds: [Feed]) {
        self.feeds = feeds
        formFeedPlayers()
    }
        
    func formFeedPlayers() {
        feedPlayers = feeds.map { feed -> FeedPlayer in
            let player = AVPlayer(url: URL(string: feed.videoUrl ?? "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)
            return FeedPlayer(feed: feed, player: player)
        }
    }
    
    func reArrangeFeedsArray(basedOn feed: Feed) {
        if let index = feeds.firstIndex(of: feed) {
            currentIndex = index
            let endIndexSlice = feeds[currentIndex..<feeds.count]
            let startIndexSlice = feeds[0..<currentIndex]
            let updatedFeeds = Array(endIndexSlice + startIndexSlice) as? [Feed]
            feeds = updatedFeeds ?? []
                
            if feedPlayers.isEmpty && !feeds.isEmpty {
                formFeedPlayers()
            }
            
            let endPlayerIndexSlice = feedPlayers[currentIndex..<feeds.count]
            let startPlayerIndexSlice = feedPlayers[0..<currentIndex]
            let updatedPlayerFeeds = Array(endPlayerIndexSlice + startPlayerIndexSlice) as? [FeedPlayer]
            feedPlayers = updatedPlayerFeeds ?? []
        }
    }
}
