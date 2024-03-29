//
//  FeedCell.swift
//  LearningInstagram
//
//  Created by Lakshmi Ranganatha Hema on 20/03/24.
//

import AVFoundation
import SwiftUI

struct ReelsCell: View {
    let feed: Feed
    var player: AVPlayer
    
    init(feed: Feed, player: AVPlayer) {
        self.feed = feed
        self.player = player
    }
    
    var body: some View {
        ZStack {
            ReelsVideoPlayer(player: player)
                .containerRelativeFrame([.horizontal, .vertical])
                
            VStack {
                Spacer()
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        if let name = feed.author?.name {
                            Text(name)
                                .fontWeight(.medium)
                        }
                        if let title = feed.title {
                            Text(title)
                        }
                    }
                    .foregroundStyle(.green)
                    .font(.headline)
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        Button {
                            
                        } label: {
                            VStack {
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(.gray)
                                Text("27")
                                    .font(.footnote)
                                    .foregroundStyle(.gray)
                            }
                            
                        }
                        
                        Button {
                            
                        } label: {
                            VStack {
                                Image(systemName: "ellipses.bubble.fill")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundStyle(.gray)
                                Text("15")
                                    .font(.footnote)
                                    .foregroundStyle(.gray)
                            }
                        }
                            
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "bookmark.fill")
                                .resizable()
                                .frame(width: 15, height: 25)
                                .foregroundStyle(.gray)
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "arrowshape.turn.up.right.fill")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(.gray)
                        }
                    }
                }
                .padding(.bottom, 60)
            }
            .padding()
        }
        .ignoresSafeArea()
        .onTapGesture {
            switch self.player.timeControlStatus {
            case .paused:
                Task {
                    self.player.play()
                }
            case .waitingToPlayAtSpecifiedRate:
                break
            case .playing:
                Task {
                    self.player.pause()
                }
            @unknown default:
                break
            }
        }
    }
}

//#Preview {
//    FeedCell(feed: Feed(id: "", videoUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4", title: "WhatCarCanYouGetForAGrand", tags: ["Navaratri", "Happy Soul"], videoDurationInSeconds: 168, author: FeedAuthor(name: "Lakshmi", picture: "http://www.authorprofile.com/profile5", age: "31")), player: AVPlayer())
//}
