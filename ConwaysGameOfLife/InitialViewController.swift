//
//  InitialViewController.swift
//  ConwaysGameOfLife
//
//  Created by Renan on 24/04/17.
//  Copyright © 2017 docutoolschallenge. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class InitialViewController: UIViewController {
    
    @IBOutlet private var width: UITextField!
    @IBOutlet private var height: UITextField!
    @IBOutlet private var continueButton: UIButton!
    private let throttleInterval = 0.1

    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHandleTextField()
        // Do any additional setup after loading the view.
    }
    
    func setupHandleTextField() {
        
        let widthValid = width
            .rx
            .text
            .throttle(throttleInterval, scheduler: MainScheduler.instance)
            .map { self.validate($0!) }
        
        
        let heightValid = height
            .rx
            .text
            .throttle(throttleInterval, scheduler: MainScheduler.instance)
            .map { self.validate($0!) }
        
        let everythingValid = Observable
            .combineLatest(widthValid, heightValid) {
              $0 && $1
        }
        
        everythingValid
        .bindTo(continueButton.rx.isEnabled)
        .addDisposableTo(disposeBag)
        
    }
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        guard let w = Int(width.text!) , let h = Int(height.text!),
            w != 0 , h != 0, w == h else {
                let alert = UIAlertController(title: "Error", message: "Insert a valid number and width and height must be equal", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return false
        }
        return true
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as! ConwaysViewController
        destinationViewController.height = Int(height.text!)!
        destinationViewController.width = Int(width.text!)!
        
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
    
    func validate(_ value: String) -> Bool {
        return value.onlyNumber()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
