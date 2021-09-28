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
    func load(url: URL){
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
