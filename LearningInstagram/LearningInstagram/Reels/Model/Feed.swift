//
//  Feed.swift
//  LearningInstagram
//
//  Created by Lakshmi Ranganatha Hema on 20/03/24.
//

import Foundation
import AVKit

struct Feed: Identifiable, Codable, Equatable {
    static func == (lhs: Feed, rhs: Feed) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: String
    var videoUrl: String?
    var title: String?
    var tags: [String]?
    var videoDurationInSeconds: String?
    var author: FeedAuthor?
    
    private enum JSONKeys: String, CodingKey {
        case videoUrl
        case title
        case tags
        case videoDurationInSeconds
        case author
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: JSONKeys.self)

        videoUrl = try container.decodeIfPresent(String.self, forKey: .videoUrl)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        tags = try container.decodeIfPresent([String].self, forKey: .tags)
        videoDurationInSeconds = try container.decodeIfPresent(String.self, forKey: .videoDurationInSeconds)
        author = try container.decodeIfPresent(FeedAuthor.self, forKey: .author)
        id = NSUUID().uuidString
    }
    
    public init(videoUrl: String?, title: String?, tags: [String]?, videoDurationInSeconds: String?, author: FeedAuthor?){
        self.videoUrl = videoUrl
        self.title = title
        self.tags = tags
        self.videoDurationInSeconds = videoDurationInSeconds
        self.author = author
        id = NSUUID().uuidString
    }
}
