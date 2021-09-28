//
//  IndexViewModel.swift
//  BuscadorPeliculas
//
//  Created by alexandru.robert.local on 27/9/21.
//

import Foundation
import RxSwift


class IndexViewModel{
    //propiedades que necesitemos
    private weak var view: IndexVC?
    private var router: IndexRouter?
    //access data
    private var accessData = AccessData()

    //enlazar view con router
    func bind(view: IndexVC, router: IndexRouter){
        self.view = view
        self.router = router
        
        //enlazar router con la vista
        self.router?.setSourceView(sourceView: view)
    }
    
    func solicitarListaPeliculas() -> Observable<[Pelicula]>{
        return accessData.solicitarPeliculas()
    }
}
