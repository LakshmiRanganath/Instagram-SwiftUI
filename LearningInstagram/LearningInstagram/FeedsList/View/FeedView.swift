//
//  FeedsListCellView.swift
//  LearningInstagram
//
//  Created by Lakshmi Ranganatha Hema on 25/03/24.
//

import SwiftUI

struct FeedView: View {
    @State var feed: Feed
    
    var body: some View {
        ZStack {
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 5) {
                        if let title = feed.title {
                            Text(title)
                                .font(.title3)
                        }
                        if let authorName = feed.author?.name {
                            Text(authorName)
                                .font(.caption)
                        }
                        
                    }
                    .padding(.leading, 5)
                    
                    Spacer()
                    
                    if let pictureUrl = feed.author?.picture {
                        ProfileImageView(pictureUrl: pictureUrl)
                    }
                        
                }
                if let tags = feed.tags {
                    ScrollView(.horizontal) {
                        ViewThatFits {
                            HStack(spacing: 5) {
                                ForEach(tags, id: \.self) { tag in
                                    if !tag.isEmpty {
                                        Text(tag)
                                            .foregroundColor(.white)
                                            .font(.caption2)
                                            .padding(6)
                                            .frame(alignment: .center)
                                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue.opacity(0.5)))
                                    }
                                }
                            }
                        }
                    }
                    .scrollBounceBehavior(.basedOnSize)
                }
            }
        }
    }
}

struct ProfileImageView: View {
    var pictureUrl: String
    var body: some View {
        AsyncImage(url: URL(string: pictureUrl)!) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .foregroundColor(.gray)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
            @unknown default:
                EmptyView()
            }
        }
        .padding(.trailing, 10)
    }
}

#Preview {
    FeedView(feed: Feed(videoUrl: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4", title: "WhatCarCanYouGetForAGrand", tags: ["Navaratri", "Happy Soul"], videoDurationInSeconds: "168", author: FeedAuthor(name: "Lakshmi", picture: "http://www.authorprofile.com/profile5", age: "31")))
}
