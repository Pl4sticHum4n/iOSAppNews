//
//  NoticiaTableViewCell.swift
//  AppNews
//
//  Created by mac16 on 04/04/22.
//

import UIKit

class NoticiaTableViewCell: UITableViewCell {

    @IBOutlet weak var imagenNoticiaIV: UIImageView!
    @IBOutlet weak var fuenteNoticiaLabel: UILabel!
    @IBOutlet weak var descripcionNoticiaLabel: UILabel!
    @IBOutlet weak var tituloNoticiaLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
