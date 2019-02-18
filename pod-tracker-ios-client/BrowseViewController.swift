//
//  BrowseViewController.swift
//  pod-tracker-ios-client
//
//  Created by will on 2019-02-17.
//  Copyright © 2019 will. All rights reserved.
//

import UIKit

class BrowseViewController: UIViewController {

    @IBOutlet weak var SearchField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func TouchSearchBtn(_ sender: Any) {
        
        
        performSegue(withIdentifier: "SearchResultSegue", sender: self)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! FollowedPodcastTableViewController
        
       
        vc.searchStr = SearchField.text!
        
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
