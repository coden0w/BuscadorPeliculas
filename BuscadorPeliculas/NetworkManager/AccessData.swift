//
//  AccessData.swift
//  BuscadorPeliculas
//
//  Created by alexandru.robert.local on 27/9/21.
//

import Foundation
import RxSwift


class AccessData{
    func solicitarPeliculas() -> Observable<[Pelicula]>{
        
        //empaquetar mediante closure
        return Observable.create { observer in
            //crear sesion
            let sesion = URLSession.shared
            //creamos una solicitud(request)
            let solicitud = URLRequest(url: URL(string: Const.URL.omdbapi+"The%20fast%20and%20the%20furious")!)
            
            //iniciar tarea (solicitud peliculas)
            sesion.dataTask(with: solicitud)  { (data, response, error) in
                //solicita de manera segura los datos (guard)
                guard let datos = data, error == nil, let response = response as? HTTPURLResponse else{ return }
                //OK
                if response.statusCode == 200{
                    do{
                        let decoder = JSONDecoder()
                        //Serializar los datos
                        let peliculas = try decoder.decode(Peliculas.self, from: datos)
                        //devolvemos el objeto peliculas recibidas de la solicitud json server omdbapi.com
                        observer.onNext(peliculas.listaPeliculas)
                    }catch{
                        print("->x Error: \(error)")
                    }
                    //NOT OK
                }else if response.statusCode == 401{
                    print("->x Error: 401 Acceso denegado!")
                }
                //tarea completada
                observer.onCompleted()
                
            }.resume()//para ejecutar el dataTask
            
            
            //aqui termina la tarea y cierra la sesion, (si se trabaja con objetos Observable)
            return Disposables.create{
                sesion.finishTasksAndInvalidate()
            }
        } //termina el return Observable
        
    }
    
    func detallePelicula(){
        
    }
}



