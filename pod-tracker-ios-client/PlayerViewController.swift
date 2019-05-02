//
//  PlayerViewController.swift
//  pod-tracker-ios-client
//
//  Created by will on 2019-05-01.
//  Copyright © 2019 will. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {

    
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var playerStateLabel: UILabel!
   

    @IBOutlet weak var playBtn: UIButton!
    
    
    var podcast: ItuneSearchResultItem?
    
    var player: AVPlayer?
    
    var embeddedViewController: PodcastInfoViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        player = AVPlayer()
        setStatus(str: "Stopped")
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PodcastInfoViewController,
            segue.identifier == "EmbedSegue" {
            self.embeddedViewController = vc
            vc.playViewController = self
            vc.podcast = podcast
        }
    }
    
    
    func setStatus(str: String){
        
        playerStateLabel.text = str
    }
    
    
    func setAudioUrl(url:String){
        
        
        setStatus(str: "Loading...")
        player?.pause()
        playBtn.setImage(UIImage(named: "play"), for: .normal)
        
        let url  = URL.init(string: url)
        let playerItem: AVPlayerItem = AVPlayerItem(url: url!)
        player?.replaceCurrentItem(with: playerItem)
        
        player?.play()
        setStatus(str: "Playing")
        playBtn.setImage(UIImage(named: "pause"), for: .normal)
    }
    
    
    @IBAction func playBtnHandler(_ sender: Any) {
        
        if ((player?.rate != 0) && (player?.error == nil)) {
            player?.pause()
            
            playBtn.setImage(UIImage(named: "play"), for: .normal)
            setStatus(str: "Paused")
            
         
        }else{
           player?.play()
            playBtn.setImage(UIImage(named: "pause"), for: .normal)
            setStatus(str: "Playing")
        }
    }
    
    @IBAction func stopBtnHandler(_ sender: Any) {
    
        player?.replaceCurrentItem(with: nil)
        playBtn.setImage(UIImage(named: "play"), for: .normal)
        setStatus(str: "Stopped")
    }


}
