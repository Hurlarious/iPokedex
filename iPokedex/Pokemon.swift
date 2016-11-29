//
//  Pokemon.swift
//  iPokedex
//
//  Created by Dave Hurley on 2016-06-13.
//  Copyright © 2016 Dave Hurley. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    fileprivate var _name: String!
    fileprivate var _pokedexId: Int!
    fileprivate var _description: String!
    fileprivate var _type: String!
    fileprivate var _defense: String!
    fileprivate var _height: String!
    fileprivate var _weight: String!
    fileprivate var _attack: String!
    fileprivate var _nextEvoText: String!
    fileprivate var _nextEvoID: String!
    fileprivate var _nextEvoLevel: String!
    fileprivate var _pokemonURL: String!
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var nextEvoText: String {
        if _nextEvoText == nil {
            _nextEvoText = ""
        }
        return _nextEvoText
    }
    
    var nextEvoId: String {
        if _nextEvoID == nil {
            _nextEvoID = ""
        }
        return _nextEvoID
    }
    
    var nextEvoLevel: String {
        if _nextEvoLevel == nil {
            _nextEvoLevel = ""
        }
        return _nextEvoLevel
    }
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    init (name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        
        _pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId)/"
    }
    
    
    func downloadPokemonDetails(_ completed: @escaping DownloadComplete) {
        
        let url = URL(string: _pokemonURL)!
        Alamofire.request(url).responseJSON { response in
            
            let result = response.result

            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>], types.count > 0 {
                    
                    if let name = types[0]["name"] {
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1 {
                        
                        for i in 1 ..< types.count {
                            if let name = types[i]["name"] {
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                    
                } else {
                    self._type = ""
                }
                
                print(self._type)
                
                if let descriptionArray = dict["descriptions"] as? [Dictionary<String, String>], descriptionArray.count > 0 {
                    
                    if let url = descriptionArray[0]["resource_uri"] {
                        
                        let nsurl = URL(string: "\(URL_BASE)\(url)")!
                        Alamofire.request(nsurl).responseJSON { response in
                            
                            let descriptionResult = response.result
                            
                            if let descriptionDict = descriptionResult.value as? Dictionary<String, AnyObject> {
                                
                                if let description = descriptionDict["description"] as? String {
                                    self._description = description
                                    print(self._description)
                                }
                            }
                            
                            completed()
                        }
                    }
                    
                } else {
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>], evolutions.count > 0 {
                    
                    if let to = evolutions[0]["to"] as? String {
                        
                        // cant support mega pokemon just yet
                        // api still has mega data
                        
                        if to.range(of: "mega") == nil {
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                
                                let firstPart = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let parsedID = firstPart.replacingOccurrences(of: "/", with: "")
                                
                                if let lvl = evolutions[0]["level"] as? Int {
                                    self._nextEvoLevel = "\(lvl)"
                                } else {
                                    self._nextEvoLevel = ""
                                }
                                
                                self._nextEvoID = parsedID
                                self._nextEvoText = to
                                
                                print(self._nextEvoLevel)
                                print(self._nextEvoID)
                                print(self._nextEvoText)
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
    
}
