//
//  MainViewController.swift
//  TestSwift
//
//  Created by forty Lin on 2017/10/31.
//  Copyright © 2017年 forty. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController
{
    
    @IBAction func loadPIView(_ sender: Any) {
        var storyBoard: UIStoryboard?
        storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let mainVC = storyBoard?.instantiateViewController(withIdentifier: "idPIViewController") as? PIViewController
        navigationController?.pushViewController(mainVC!, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // My project use navigation controller just for transition animation right to left, thats why i hide it here on first view.
        navigationController?.isNavigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
