//
//  ViewController.swift
//  Timely
//
//  Created by cole stevens on 9/25/22.
//

import UIKit

class ViewController: UIViewController {

    var ItemArray = [ToDo]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    

}

