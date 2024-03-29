//
//  FeedsListView.swift
//  LearningInstagram
//
//  Created by Lakshmi Ranganatha Hema on 28/03/24.
//

import SwiftUI

struct FeedsListView: View {
    @ObservedObject var feedListViewModel = FeedListViewModel()
    @ObservedObject var reelsViewModel = ReelsViewModel(feeds: [])
    @State var selectedFeed: Feed? = nil
    @State var showFeedView = false
    var body: some View {
        NavigationStack {
            ZStack {
                Color.indigo.opacity(0.2)
                Spacer()
                VStack(alignment: .center, spacing: 15) {
                    HStack(alignment: .center, spacing: 25) {
                        Image(systemName: "house")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40, height: 40)
                            .foregroundColor(.black.opacity(0.8))
                        
                        Text("Insta Learning")
                            .font(.largeTitle)
                        
                        NavigationLink(destination: {
                            ReelsView(reelsViewModel: ReelsViewModel(feeds: self.feedListViewModel.feeds))
                        }, label: {
                            Image(systemName: "video")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .foregroundColor(.black.opacity(0.8))
                            .frame(width: 40, height: 40)
                        })
                        
                    }
                    .padding(.top, 20)
                    Text("Explore Reels")
                        .font(.title)
                        .frame(alignment: .center)
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                    List(feedListViewModel.feeds, id: \.id) { feed in
                        FeedView(feed: feed)
                            .listRowBackground(Color.random(randomOpacity: true))
                            .onTapGesture {
                                self.selectedFeed = feed
                            }
                    }
                    .scrollContentBackground(.hidden)
                    .background(content: {
                        if let selectedFeed = self.selectedFeed {
                            self.feedListViewModel.reelsViewModel.reArrangeFeedsArray(basedOn: selectedFeed)
                        }
                        return NavigationLink(destination: ReelsView(reelsViewModel: feedListViewModel.reelsViewModel),
                            isActive: Binding<Bool>(
                                get: { self.selectedFeed != nil },
                                set: { _ in self.selectedFeed = nil })
                        ) {
                            EmptyView()
                        }
                        .hidden()
                    })
                }
            }
            .onReceive(feedListViewModel.objectWillChange) { _ in
                self.reelsViewModel.feeds = self.feedListViewModel.feeds
            }
        }
        .listRowSpacing(20)
    }
}

#Preview {
    FeedsListView()
}
