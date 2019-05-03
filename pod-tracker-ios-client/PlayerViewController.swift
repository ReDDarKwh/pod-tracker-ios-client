//
//  PlayerViewController.swift
//  pod-tracker-ios-client
//
//  Created by will on 2019-05-01.
//  Copyright © 2019 will. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData


class PlayerViewController: UIViewController {

    
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var playerStateLabel: UILabel!
   

    @IBOutlet weak var playBtn: UIButton!
    
    
    
    var podcastEpisode	: [NSManagedObject] = []
    
    var currentEpisode: NSManagedObject?

    
    var podcast: ItuneSearchResultItem?
    
    var player: AVPlayer?
    
    var embeddedViewController: PodcastInfoViewController?
    
    var helloWorldTimer: Timer?
    

    @objc func sayHello()
    {
        if currentEpisode != nil {
            if player != nil{
                if ((player?.rate != 0) && (player?.error == nil)) {
                    
                    if(player?.currentItem != nil){
                         currentEpisode?.setValue( Int(player?.currentTime().seconds ?? 0), forKey: "timestep")
                        
                        let appDelegate =
                            UIApplication.shared.delegate as? AppDelegate
                        
                        
                        // 1
                        let managedContext =
                            appDelegate!.persistentContainer.viewContext
                        
                        do {
                            try managedContext.save()
                            
                        } catch let error as NSError {
                            print("Could not save. \(error), \(error.userInfo)")
                        }
                        
                    }
                    
                    
                    
                    
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        player = AVPlayer()
        setStatus(str: "Stopped")
        
        helloWorldTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(sayHello), userInfo: nil, repeats: true)
        
        
        
        
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "PodcastEpisode")
        
        //3
        do {
            podcastEpisode = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        
       
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
        
        if let ep = podcastEpisode.first(where: { $0.value(forKey: "url") as! String == url }) {
            currentEpisode = ep
        }else{
            currentEpisode = save(url: url, timestep: 0)
        }
        
        let url  = URL.init(string: url)
        let playerItem: AVPlayerItem = AVPlayerItem(url: url!)
        player?.replaceCurrentItem(with: playerItem)
        
        player?.seek(to:CMTimeMakeWithSeconds(Float64(currentEpisode?.value(forKey: "timestep") as! Int), preferredTimescale: 1000) )
        
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
    
    
    func save(url: String, timestep: Int) -> NSManagedObject {
        
        let appDelegate =
            UIApplication.shared.delegate as? AppDelegate
               
        
        // 1
        let managedContext =
            appDelegate!.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "PodcastEpisode",
                                       in: managedContext)!
        
        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        // 3
        person.setValue(url, forKeyPath: "url")
        person.setValue(timestep, forKeyPath: "timestep")
        
        // 4
        do {
            try managedContext.save()
            podcastEpisode.append(person)
            
          
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
          return person
    }



}
