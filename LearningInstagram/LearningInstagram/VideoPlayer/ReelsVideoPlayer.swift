//
//  FeedsVideoPlayer.swift
//  LearningInstagram
//
//  Created by Lakshmi Ranganatha Hema on 21/03/24.
//

import SwiftUI
import AVKit

struct ReelsVideoPlayer: UIViewControllerRepresentable {
    var player: AVPlayer
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let playerController = AVPlayerViewController()
        playerController.player = self.player
        playerController.showsPlaybackControls = false
        playerController.exitsFullScreenWhenPlaybackEnds = true
        playerController.allowsPictureInPicturePlayback = true
        playerController.videoGravity = .resizeAspectFill
        
        return playerController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
