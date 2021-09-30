//
//  InicioVC.swift
//  BuscadorPeliculas
//
//  Created by alexandru.robert.local on 27/9/21.
//

import UIKit
import RxSwift


class IndexVC: UIViewController {
    
    //propiedad de viewmodel y router
    private var router = IndexRouter()
    private var viewModel = IndexViewModel()
    
    private var disposeBag = DisposeBag() //recolector de basura *
    private var peliculas = [Pelicula]() //array pelicula
    
    //outlets
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var mySearchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "BuscadorSP"
        //delegacion del searchbar para poder capturar el return o buscar del teclado
        configSearchBar()
        
        //enlazado el modulo
        viewModel.bind(view: self, router: router)
        configTableView()
    }
    
    private func configSearchBar(){
        mySearchBar.delegate = self
        mySearchBar.placeholder = "Fast and furious.."
    }
    
    private func configTableView(){
        myTableView.rowHeight = UITableView.automaticDimension
        myTableView.register(UINib(nibName: "CustomMovieCell", bundle: nil), forCellReuseIdentifier: "CustomMovieCell")
        //myTableView.keyboardDismissMode = .onDrag //cerrar teclado cuando desplacemos la tabla en caso de
    }
    
    private func solicitarDatos(busqueda:String){
        return viewModel.solicitarListaPeliculas(busqueda: busqueda)
        //RxSwift: Manejar la concurrencia o hilos de RxSwift
            .subscribe(on: MainScheduler.instance) //ejecutar en el hilo principal
            .observe(on: MainScheduler.instance)
        //RxSwift: Suscribirse al observable
            .subscribe(
                onNext: { peliculas in
                    self.peliculas = peliculas
                    self.recargarMyTableView()
                }, onError: { error in
                    print("->x Error: \(error)")
                }, onCompleted: {
                    print("\n->i Info: Completado!\n")
                }).disposed(by: disposeBag)//*
        
        //RxSwift: dar por completado la secuencia de RxSwift
        
    }
    
    private func recargarMyTableView(){
        DispatchQueue.main.async{
            self.myTableView.reloadData()
        }
    }
    
}

//delegate searchbar
extension IndexVC: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        mySearchBar.resignFirstResponder()
        if mySearchBar.text!.count > 0 || mySearchBar.text != nil{
            solicitarDatos(busqueda: mySearchBar.text!)
        }else{
            
        }
        
    }
}

//delegate y datasource tableview
extension IndexVC: UITableViewDelegate, UITableViewDataSource{
    
    //numero de filas de la tabla
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peliculas.count
    }
    
    //reusabilidad de las celdas
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomMovieCell") as! CustomMovieCell
        //fijando datos en la celda personalizada
        cell.tituloLabel.text = self.peliculas[indexPath.row].titulo
        cell.fechaEstrenoLabel.text = self.peliculas[indexPath.row].year
        cell.imgURL.load(imgURL: self.peliculas[indexPath.row].imgURL!)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print(peliculas[indexPath.row].titulo)
        viewModel.cambiarDetailView(imdbID: peliculas[indexPath.row].imdbID)
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}



