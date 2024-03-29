//
//  FeedListViewModel.swift
//  LearningInstagram
//
//  Created by Lakshmi Ranganatha Hema on 29/03/24.
//

import Combine
import Foundation
import AVKit
import SwiftUI


class FeedListViewModel: ObservableObject {
    
    enum FeedsFetchState {
        case loading
        case loaded([Feed])
        case error(Error?)
        
        public static func ==(lhs: FeedsFetchState, rhs: FeedsFetchState) -> Bool {
            switch (lhs, rhs) {
            case (.loaded(let lhs), .loaded(let rhs)):
                return lhs == rhs
            case (.error(_), .error(_)):
                return true
            default:
                return false
            }
        }
    }
    @Published var feeds = [Feed]()
    @Published var feedPlayers = [FeedPlayer]()
    @Published var feedService = APIService<[Feed]>()
    @Published var reelsViewModel = ReelsViewModel(feeds: [])
    @Published public var state: FeedsFetchState = .loading
    var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchFeeds()
    }
    
    public func fetchFeeds() {
        feedService.$result
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case let .failure(error):
                    self.state = .error(error)
                case .finished:
                    break
                }
            } receiveValue: { result in
                switch result {
                case let .success(feeds):
                    self.formFeedsWithUpdatedID(feeds: feeds)
                case let .failure(error):
                    self.state = .error(error)
                case .none:
                    self.state = .loading
                }
            }
            .store(in: &cancellables)
    }
    
    func formFeedsWithUpdatedID(feeds: [Feed]) {
        self.feeds = Array(feeds.repeated().prefix(50))as? [Feed] ?? []
        self.feeds = self.feeds.map({ feed -> Feed  in
            var updatedFeed = feed
            updatedFeed.id = NSUUID().uuidString
            return updatedFeed
        })
        self.feeds = self.feeds
        self.reelsViewModel = ReelsViewModel(feeds: self.feeds)
    }
}

