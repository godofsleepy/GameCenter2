//
//  VideoPlayerView.swift
//  GameCenter2
//
//  Created by rifat khadafy on 12/02/21.
//

import Foundation
import AVKit
import SwiftUI

struct AVPlayerView: UIViewControllerRepresentable {
    
    var videoURL: URL?
    
    private var player: some View {
        return VideoPlayer(player : AVPlayer(url: videoURL!)).scaledToFit()
        
    }
    
    func updateUIViewController(_ playerController: AVPlayerViewController, context: Context) {
        playerController.modalPresentationStyle = .overCurrentContext
        playerController.player?.play()
    }
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let playerController = AVPlayerViewController()
        playerController.player = AVPlayer(url: videoURL!)
        return playerController
    }
}
