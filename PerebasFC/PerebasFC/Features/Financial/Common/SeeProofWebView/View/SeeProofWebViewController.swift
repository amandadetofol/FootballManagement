//
//  SeeProofWebViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 13/06/23.
//

import UIKit

final class SeeProofWebViewController: UIViewController {
    
    init(url: String){
        super.init(nibName: nil, bundle: nil)
        view = SeeProofWebView(url: url)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Comprovante anexado"
        self.navigationController?.navigationBar.isHidden = false
    }
    
}
