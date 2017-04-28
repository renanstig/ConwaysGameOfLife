//
//  ConwaysViewController.swift
//  ConwaysGameOfLife
//
//  Created by Renan on 26/04/17.
//  Copyright © 2017 docutoolschallenge. All rights reserved.
//

import UIKit

class ConwaysViewController: UIViewController {
    
    var width: Int = 0
    var height: Int = 0
    var grid: GridView?
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var start: UIButton!
    var started = false
    var loop: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rect = CGRect(x: 0, y: 64, width: width, height: height)
        grid = GridView(frame: rect, length: 20)
        self.scrollView.addSubview(grid!)
        grid!.topAnchor
        grid!.leadingAnchor
        grid!.trailingAnchor
        grid!.bottomAnchor
        scrollView.contentSize = CGSize(width: CGFloat(grid!.frame.width), height: CGFloat(grid!.frame.height) + 64)
        // Do any ad10ditional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressedStart(sender: AnyObject) {
        if !started {
            (sender as! UIButton).setTitle("Stop", for: .normal)
            grid!.isUserInteractionEnabled = false
            
            loop = Timer.scheduledTimer(timeInterval: 0.40, target: grid!, selector: #selector(grid!.nextGeneration), userInfo: nil, repeats: true)
            
            started = true
        } else {
            (sender as! UIButton).setTitle("Start", for: .normal)
            loop!.invalidate()
            started = false
            grid!.isUserInteractionEnabled = true
        }
            
    }

    
    @IBAction func shareButton(sender: AnyObject) {
        
    }
}

extension ConwaysViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return scrollView.subviews.first!
    }
}
