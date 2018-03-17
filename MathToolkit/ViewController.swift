//
//  ViewController.swift
//  MathToolkit
//
//  Created by Mulang Su on 2018/03/10.
//  Copyright © 2018年 Mulang Su. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let json = try! Data(contentsOf: Bundle.main.url(forResource: "operations", withExtension: "json")!)
        let decoder = JSONDecoder()
        let operations = try! decoder.decode([JsonOperation].self, from: json)
        let circle = operations.first!
        let results = circle.calculate(inputs: ["r": 2, "d": 4])!
        for result in results {
            print("\(result.name): \(result.value), from: \(result.from)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

