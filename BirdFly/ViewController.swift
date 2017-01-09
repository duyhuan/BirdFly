//
//  ViewController.swift
//  BirdFly
//
//  Created by huan huan on 1/9/17.
//  Copyright © 2017 huan huan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let bird = UIImageView()
    let imgBirds: [UIImage] = [UIImage(named: "bird0.png")!,
                               UIImage(named: "bird1.png")!,
                               UIImage(named: "bird2.png")!,
                               UIImage(named: "bird3.png")!,
                               UIImage(named: "bird4.png")!,
                               UIImage(named: "bird5.png")!]
    var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawJungle()
        addBird()
        flyUpAndDown()
        playMusic()
    }
    
    func drawJungle() {
        let background = UIImageView(image: UIImage(named: "jungle.jpg"))
        background.frame = self.view.bounds
        self.view.addSubview(background)
    }
    
    func addBird() {
        bird.frame = CGRect(x: 0.0, y: 0.0, width: 110.0, height: 68.0)
        bird.animationImages = imgBirds
        bird.animationRepeatCount = 0
        bird.animationDuration = 1
        bird.startAnimating()
        view.addSubview(bird)
    }
    
    func flyUpAndDown() {
        UIView.animate(withDuration: 3, animations: {
            self.bird.center = CGPoint(x: self.view.bounds.width - self.bird.bounds.width/2, y: self.view.bounds.height - self.bird.bounds.height/2)
            }, completion: { (true) in
                self.bird.transform = self.bird.transform.scaledBy(x: -1, y: 1)
                UIView.animate(withDuration: 2, animations: {
                    self.bird.center = CGPoint(x: self.bird.bounds.width/2, y: self.view.bounds.height - self.bird.bounds.height/2)
                    }, completion: { (true) in
                        self.bird.transform = self.bird.transform.scaledBy(x: -1, y: 1).rotated(by: -45 * CGFloat(M_PI/180))
                        UIView.animate(withDuration: 3, animations: {
                            self.bird.center = CGPoint(x: self.view.bounds.width - self.bird.bounds.width/2, y: self.bird.bounds.height/2)
                            }, completion: { (true) in
                                self.bird.transform = self.bird.transform.rotated(by: 45 * CGFloat(M_PI/180)).scaledBy(x: -1, y: 1)
                                UIView.animate(withDuration: 2, animations: {
                                    self.bird.center = CGPoint(x: self.bird.bounds.width/2, y: self.bird.bounds.height/2)
                                    }, completion: { (true) in
                                        self.bird.transform = CGAffineTransform.identity
                                        self.flyUpAndDown()
                                })
                        })
                })
        })
    }
    
    func playMusic() {
        let filePath = Bundle.main.path(forResource: "A+ – Chào Mào Mái Hót", ofType: ".mp3")
        let url = NSURL(fileURLWithPath: filePath!)
        audioPlayer = try! AVAudioPlayer(contentsOf: url as URL)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
}

