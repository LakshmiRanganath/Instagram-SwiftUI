//
//  FeedPlayer.swift
//  LearningInstagram
//
//  Created by Lakshmi Ranganatha Hema on 29/03/24.
//

import AVFoundation
import Foundation

struct FeedPlayer: Identifiable {
    var feed: Feed
    var player: AVPlayer
    var id: String {
        return feed.id
    }
}
