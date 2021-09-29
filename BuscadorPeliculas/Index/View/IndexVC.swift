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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //enlazado el modulo
        viewModel.bind(view: self, router: router)
        solicitarDatos()
        configTableView()

        
    }
    
    private func configTableView(){
        myTableView.rowHeight = UITableView.automaticDimension
        myTableView.register(UINib(nibName: "CustomMovieCell", bundle: nil), forCellReuseIdentifier: "CustomMovieCell")
        //myTableView.register(UINib(nibName: "CustomMovieCell", bundle: nil), forCellReuseIdentifier: "CeldaPeliculas")
    }
    
    private func solicitarDatos(){
        return viewModel.solicitarListaPeliculas()
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


extension IndexVC: UITableViewDelegate, UITableViewDataSource{
    
    //numero de filas de la tabla
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peliculas.count
    }
    
    //reusabilidad de las celdas
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "CeldaPeliculas")
//        cell.textLabel?.text = peliculas[indexPath.row].titulo
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomMovieCell") as! CustomMovieCell

        cell.tituloLabel.text = self.peliculas[indexPath.row].titulo
        cell.fechaEstrenoLabel.text = self.peliculas[indexPath.row].year
        //cell.imgURL.load(url: URL(string: self.peliculas[indexPath.row].imgURL ?? "")!)
        cell.imgURL.load(imgURL: self.peliculas[indexPath.row].imgURL!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}



