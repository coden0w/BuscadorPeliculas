//
//  DetailRouter.swift
//  BuscadorPeliculas
//
//  Created by alexandru.robert.local on 29/9/21.
//

import UIKit


class DetailRouter{
    
    private var sourceView: UIViewController?
    var imdbID:String?
    
    //constructor de inicio
    init(imdbID:String? = ""){
        self.imdbID = imdbID
    }
    
    //crear variable view controller
    var viewController: UIViewController{
        return createViewController()
    }
    
    //enlazar router con la detailviewmodel
    func setSourceView(sourceView: UIViewController?){
        guard let view = sourceView else {fatalError("->x Error desconocido!")}
        self.sourceView = view
    }
    
    //inicializador de clase DetailVC
    private func createViewController() -> UIViewController{
        let view = DetailVC(nibName: "DetailVC", bundle: Bundle.main)
        view.imdbID = self.imdbID
        return view
    }

}
