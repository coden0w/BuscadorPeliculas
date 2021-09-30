//
//  DetailVC.swift
//  BuscadorPeliculas
//
//  Created by alexandru.robert.local on 29/9/21.
//

import UIKit
import RxSwift

class DetailVC: UIViewController {
    
    private var router = DetailRouter()
    private var viewModel = DetailViewModel()
    private var disposeBag = DisposeBag()
    var imdbID: String?
    //array con los atributos que pasan a negrita para diferenciar
    private var atributos = ["Titulo: \n", "Sinopsis: \n", "Fecha de Estreno: \n", "Duracion(min): \n", "Genero: \n", "Director: \n", "Escritor: \n", "Actores: \n", "Premios: \n"]
    
    //OUTLETs
    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var sinopsisLabel: UILabel!
    @IBOutlet weak var fechaEstrenoLabel: UILabel!
    @IBOutlet weak var duracionMinsLabel: UILabel!
    @IBOutlet weak var generoLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var escritorLabel: UILabel!
    @IBOutlet weak var actoresLabel: UILabel!
    @IBOutlet weak var premiosLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelDesign()
        recibirPeliculaYMostrar()
        viewModel.bind(view: self, router: router) //enlazar viewmodel con esta vista
    }
    
    private func labelDesign(){
        tituloLabel.personalizarLabel()
        sinopsisLabel.personalizarLabel()
        fechaEstrenoLabel.personalizarLabel()
        duracionMinsLabel.personalizarLabel()
        generoLabel.personalizarLabel()
        directorLabel.personalizarLabel()
        escritorLabel.personalizarLabel()
        actoresLabel.personalizarLabel()
        premiosLabel.personalizarLabel()
        
    }
    
    
    private func combinarTextoNegrita(atributo:String, datoPelicula:String) -> NSMutableAttributedString{
        let negrita = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 25)]
        let negritaString = NSMutableAttributedString(string:atributo, attributes:negrita)
        
        let datoPeliculaString = NSMutableAttributedString(string: datoPelicula)
        
        negritaString.append(datoPeliculaString)
        
        return negritaString
    }
    
    private func recibirPeliculaYMostrar(){
        guard let imdbid = imdbID else { return }
        
        return viewModel.solicitarPeliculaDetallada(imdbID: imdbid).subscribe(
            onNext: { peliculaD in
                self.mostrarDatosPelicula(pelicula: peliculaD)
            },
            onError: { error in
                print("\n->x Error Pelicula detallada: \(error)\n")
            },
            onCompleted: {}).disposed(by: disposeBag)
    }
    
    func mostrarDatosPelicula(pelicula: PeliculaDetallada){
        DispatchQueue.main.async{
            self.imagen.load(imgURL: pelicula.Poster)
            self.tituloLabel.attributedText = self.combinarTextoNegrita(atributo: self.atributos[0], datoPelicula: pelicula.Title)
            self.sinopsisLabel.attributedText = self.combinarTextoNegrita(atributo: self.atributos[1], datoPelicula: pelicula.Plot)
            self.fechaEstrenoLabel.attributedText = self.combinarTextoNegrita(atributo: self.atributos[2], datoPelicula: pelicula.Year)
            self.duracionMinsLabel.attributedText = self.combinarTextoNegrita(atributo: self.atributos[3], datoPelicula: pelicula.Runtime)
            self.generoLabel.attributedText = self.combinarTextoNegrita(atributo: self.atributos[4], datoPelicula: pelicula.Genre)
            self.directorLabel.attributedText = self.combinarTextoNegrita(atributo: self.atributos[5], datoPelicula: pelicula.Director)
            self.escritorLabel.attributedText = self.combinarTextoNegrita(atributo: self.atributos[6], datoPelicula: pelicula.Writer)
            self.actoresLabel.attributedText = self.combinarTextoNegrita(atributo: self.atributos[7], datoPelicula: pelicula.Actors)
            self.premiosLabel.attributedText = self.combinarTextoNegrita(atributo: self.atributos[8], datoPelicula: pelicula.Awards)
        }
    }


}


extension UILabel{
    func personalizarLabel() {
        self.textColor = .white
        self.backgroundColor = .black
        self.layer.cornerRadius = self.frame.size.height/2.0
        self.layer.masksToBounds = true
    }

}
