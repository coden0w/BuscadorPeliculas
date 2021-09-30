//
//  PeliculaDetallada.swift
//  BuscadorPeliculas
//
//  Created by alexandru.robert.local on 29/9/21.
//

import Foundation

struct PeliculaDetallada: Codable{
        let Title:String
        let Year:String
        let Rated:String //calificacion
        let Runtime:String //duracion
        let Genre:String //genero
        let Director:String //director
        let Writer:String //escritor
        let Actors:String //actores
        let Plot:String //sinopsis
        let Language:String //idiomas disponibles
        let Country:String //paises
        let Awards:String //premios
        let Poster:String //url imagen
        let imdbID:String //id
    
    enum CodingKeys: String, CodingKey {
        case Title
        case Year
        case Rated
        case Runtime
        case Genre
        case Director
        case Writer
        case Actors
        case Plot
        case Language
        case Country
        case Awards
        case Poster
        case imdbID
    }
    
    
}


