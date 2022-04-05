//
//  PaginaWebController.swift
//  AppNews
//
//  Created by mac16 on 01/04/22.
//

import UIKit
import WebKit

class PaginaWebController: UIViewController {

    var recibirURL: String?
    
    
    @IBOutlet weak var showURL: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: recibirURL!) else {return}
        showURL.load(URLRequest(url: url))
        // Do any additional setup after loading the view.
    }

}
