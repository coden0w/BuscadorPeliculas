//
//  DetailViewModel.swift
//  BuscadorPeliculas
//
//  Created by alexandru.robert.local on 29/9/21.
//

import Foundation
import RxSwift

class DetailViewModel{
    //llamar access data
    private var accessData = AccessData()
    //llamar vista detalle
    private(set) weak var view: DetailVC?
    //llamar al router de navegacion
    private var router: DetailRouter?
    
    //bind (enlace)
    func bind(view: DetailVC, router: DetailRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(sourceView: view)
    }
    
    //traer datos de PeliculaDetallada
    func solicitarPeliculaDetallada(imdbID: String) -> Observable<PeliculaDetallada>{
        return accessData.detallePelicula(imdbID: imdbID)
    }
    
    
}

