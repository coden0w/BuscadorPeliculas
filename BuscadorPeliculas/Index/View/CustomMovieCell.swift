//
//  CustomMovieCell.swift
//  BuscadorPeliculas
//
//  Created by alexandru.robert.local on 28/9/21.
//

import UIKit

class CustomMovieCell: UITableViewCell {
    
    @IBOutlet weak var imgURL: UIImageView!
    @IBOutlet weak var fechaEstrenoLabel: UILabel!
    @IBOutlet weak var tituloLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension UIImageView{
    
    func load(imgURL: String){
        if imgURL.count < 10{ //en mi caso el servidor devuelve siempre strings aunque no disponga de enlaces para imagenes ("")
            self.image = Const.sinImagen
        }else{
            URLSession.shared.dataTask(with: URL(string: imgURL)!) { (data, response, error) in
                if error != nil {
                    return
                }
                DispatchQueue.main.async {
                    guard let data = data else {return}
                    let img = UIImage(data:data)
                    self.image = img
                }
            }.resume()
        }
        
    }
    
    //usada inicialmente pero me salia muchos logs con error 1002 (conexion no segura a pesar de acceder a enlaces https)
    
    //    func load(url: URL){
    //        DispatchQueue.global().async { [weak self] in
    //            if let data = try? Data(contentsOf: url){
    //                if let image = UIImage(data: data){
    //                    DispatchQueue.main.async {
    //                        self?.image = image
    //                    }
    //                }
    //            }
    //        }
    //    }
}
