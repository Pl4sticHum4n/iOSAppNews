//
//  ViewController.swift
//  AppNews
//
//  Created by mac16 on 30/03/22.
//

import UIKit
import SafariServices

// MARK: -Estructuras
struct Noticias: Codable {
    var articles:[Noticia]
}

struct Noticia: Codable {
    var title: String?
    var description: String?
    var urlToImage: String
    var url: String?
    var source: Source?
}

struct Source: Codable {
    var name: String?
}

var articulosDeNoticias: [Noticia] = []

var urlMandar: String?

class ViewController: UIViewController {

    var noticias = [Noticia]()
    
    @IBOutlet weak var tablaNoticias: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - registrar celda
        
        tablaNoticias.register(UINib(nibName: "NoticiaTableViewCell", bundle: nil), forCellReuseIdentifier: "celda")
        tablaNoticias.delegate = self
        tablaNoticias.dataSource = self
        
        let urlString = "https://newsapi.org/v2/top-headlines?apiKey=dd126c2fa5214ecb97ff218873e7b1b7&country=mx"
        
        if let url = URL(string: urlString){
            if let data = try? Data(contentsOf: url){
                analizarJson(json: data)
            }
        }
        
    }
    func analizarJson(json: Data) {
        let decodificador = JSONDecoder()
        if let datosDecodificados = try? decodificador.decode(Noticias.self, from: json){
            articulosDeNoticias = datosDecodificados.articles
            print("Articulos: \(articulosDeNoticias)")
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articulosDeNoticias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaNoticias.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! NoticiaTableViewCell
        celda.tituloNoticiaLabel.text = articulosDeNoticias[indexPath.row].title
        celda.descripcionNoticiaLabel.text = articulosDeNoticias[indexPath.row].description
        celda.fuenteNoticiaLabel.text = "Fuente: \(articulosDeNoticias[indexPath.row].source?.name ?? "a")"
        
        //MARK: - Crear imagen desde sitio web
        let urlImagen = articulosDeNoticias[indexPath.row].urlToImage
        celda.imagenNoticiaIV.cargarDesdeSitioWeb(direccionURL: urlImagen)
        return celda
    }
    
    /*func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaNoticias.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        celda.textLabel?.text = "Titulo 1"
        return celda
    }*/
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        urlMandar = articulosDeNoticias[indexPath.row].url ?? "a"
        print(articulosDeNoticias[indexPath.row].url ?? "a")
        let url = URL(string: urlMandar ?? "")!
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
        //performSegue(withIdentifier: "navegarSitioWeb", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "navegarSitioWeb" {
            let objetoDestino = segue.destination as! PaginaWebController
            objetoDestino.recibirURL = urlMandar
        }
    }
}

extension UIImageView{
    func cargarDesdeSitioWeb(direccionURL: String){
        guard let url = URL(string: direccionURL) else {return}
        DispatchQueue.main.async {
            if let imagenData = try? Data(contentsOf: url){
                if let imagenCargada = UIImage(data: imagenData){
                    self.image=imagenCargada
                }
            }
        }
    }
}
