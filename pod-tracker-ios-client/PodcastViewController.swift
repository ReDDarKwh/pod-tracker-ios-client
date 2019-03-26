//
//  PodcastViewController.swift
//  pod-tracker-ios-client
//
//  Created by will on 2019-02-19.
//  Copyright © 2019 will. All rights reserved.
//

import UIKit

class PodcastViewController: UIViewController {

    @IBOutlet weak var PodcastTitle: UILabel!
    @IBOutlet weak var PodcastImage: UIImageView!
    @IBOutlet weak var PodcastDescription: UITextView!
    
    
    var podcast: ItuneSearchResultItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        PodcastTitle.text = podcast?.trackName
        
        //PodcastDescription.text = podcast.debugDescription
        
        
        let url = URL(string: podcast!.artworkUrl600 )
        
        let data = try? Data(contentsOf: url!) //make sure your image in this url does
        
        PodcastImage?.image = UIImage(data: data!)
        
        
        PodcastDescription.text = "test"
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
