//
//  IndexRouter.swift
//  BuscadorPeliculas
//
//  Created by alexandru.robert.local on 27/9/21.
//

//esta clase crea el objeto index y de router para ir a otras vistas
import Foundation
import UIKit

class IndexRouter{
    
    private var sourceView: UIViewController?
    
    
    var viewController: UIViewController{
        return createViewController()
    }
    
    //inicializador de clase IndexVC
    private func createViewController() -> UIViewController{
        let view = IndexVC(nibName: "IndexVC", bundle: Bundle.main)
        return view
    }
    
    //enlazar router con la viewmodel
    func setSourceView(sourceView: UIViewController?){
        guard let view = sourceView else {fatalError("->x Error desconocido!")}
        self.sourceView = view
    }
    
    //mostrar vista detailView
    func navegarDetailVC(imdbID:String){
        let detailR = DetailRouter(imdbID: imdbID).viewController
        sourceView?.navigationController?.pushViewController(detailR, animated: true)
    }
}

