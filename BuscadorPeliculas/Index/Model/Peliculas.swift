//
//  Peliculas.swift
//  BuscadorPeliculas
//
//  Created by alexandru.robert.local on 27/9/21.
//

import Foundation


struct Peliculas: Codable{
    let listaPeliculas: [Pelicula]
    enum CodingKeys: String, CodingKey{
        case listaPeliculas = "Search"
    }
}

struct Pelicula: Codable{
    let titulo:String
    let year:String
    let imdbID:String
    let tipo:String
    let imgURL:String?
    
    enum CodingKeys: String, CodingKey{
        
        case titulo = "Title"
        case year = "Year"
        case imdbID = "imdbID"
        case tipo = "Type"
        case imgURL = "Poster"
    }
}





