//
//  DetailViewController.swift
//  iPokedex
//
//  Created by Dave Hurley on 2016-06-21.
//  Copyright © 2016 Dave Hurley. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Variables/Properties/Outlets

    @IBOutlet weak var nameLabel: UILabel!
    var pokemon: Pokemon!

    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = pokemon.name.capitalizedString
        

    }


}
