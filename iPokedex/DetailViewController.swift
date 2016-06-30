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
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var pokedexLabel: UILabel!
    @IBOutlet weak var baseAttackLabel: UILabel!
    @IBOutlet weak var evoLabel: UILabel!
    @IBOutlet weak var currentEvoImage: UIImageView!
    @IBOutlet weak var nextEvoImage: UIImageView!
    
    var pokemon: Pokemon!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = pokemon.name.capitalizedString
        let img = UIImage(named: "\(pokemon.pokedexId)")
        mainImage.image = img
        currentEvoImage.image = img
        
        // called after network request if completed
        pokemon.downloadPokemonDetails {
            
            self.updateUI()
        }

    }
    
    // MARK: - Functions
    
    func updateUI() {
        
        descriptionLabel.text = pokemon.description
        typeLabel.text = pokemon.type
        defenseLabel.text = pokemon.defense
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        pokedexLabel.text = "\(pokemon.pokedexId)"
        baseAttackLabel.text = pokemon.attack
        
        if pokemon.nextEvoId == "" {
            
            evoLabel.text = "No Evolutions"
            nextEvoImage.hidden = true
            
        } else {
            
            nextEvoImage.hidden = false
            nextEvoImage.image = UIImage(named: pokemon.nextEvoId)
            var evoString = "Next Evolution: \(pokemon.nextEvoText)"
            
            if pokemon.nextEvoLevel != "" {
                evoString += " - Level \(pokemon.nextEvoLevel)"
            }
            
            evoLabel.text = evoString
        }
            
        
        
    }
    
    // MARK: - Actions

    @IBAction func backButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
