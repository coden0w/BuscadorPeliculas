//
//  Const.swift
//  BuscadorPeliculas
//
//  Created by alexandru.robert.local on 27/9/21.
//

import Foundation
import UIKit

struct Const{
    //key api de omdbapi
    
    static let sinImagen:UIImage = UIImage(named: "NoImage")!
    
    //enlaces
    struct URL{
        //enlace para la busqueda multiple de peliculas
        static let omdbapi = "https://www.omdbapi.com/?apikey=a9ef137f&s="
        //enlace para la busqueda por imdbID para pelicula detallada
        static let selecSP = "https://www.omdbapi.com/?apikey=a9ef137f&i="
    }
    
    
}
