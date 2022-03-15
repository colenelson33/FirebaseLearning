//
//  ViewController.swift
//  LawnPro
//
//  Created by 90304588 on 3/2/22.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    var videoPlayer: AVPlayer?
    
    var videoPlayerLayer: AVPlayerLayer?
    
    
    
    
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // set up background vid
        
    }
    func setUpElements(){
        
        //style text fields
        Utilities.styleHollowButton(loginButton)
        Utilities.styleFilledButton(signupButton)
        
    }
    
    func setUpVideo(){
        //get the path to the resource in the bundle
        let bundlePath = Bundle.main.path(forResource: "background", ofType: "MOV")
        
        guard bundlePath != nil else{
            return
        }
        //create url from it
        
        let url = URL(fileURLWithPath: bundlePath!)
        
        //create video player item
        let item = AVPlayerItem(url: url)
        //create player
        videoPlayer = AVPlayer(playerItem: item)
        //create layer
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        //adjust size and frame
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*0.2, y: 0, width: self.view.frame.size.width*1.4, height: self.view.frame.size.height)
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        //add it and play it
        videoPlayerLayer?.opacity = 0.7
        videoPlayer?.playImmediately(atRate: 1)
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
