//
//  MapViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 23/08/23.
//

import UIKit
import WebKit

final class MapViewController: UIViewController,
                               WKNavigationDelegate {
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self
        webView.isAccessibilityElement = true
        webView.accessibilityTraits = .staticText
        webView.accessibilityLabel = "O jogo ocorrerá em Badenball, R. Villa Lobos, 78 - Badenfurt, Blumenau - SC."
        
        return webView
    }()
    
    private var interactor: MapInteractorProtocol
    
    init(interactor: MapInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        setupNavigationView()
        view = webView
        interactor.loadView()
    }
    
    private func setupNavigationView(){
        self.navigationController?.navigationBar.isHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Compartilhar",
            style: .plain,
            target: self,
            action: #selector(handleShareButtonTap))
        self.title = "Local do Jogo"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Voltar",
            style: .plain,
            target: self,
            action: #selector(handleGoToBack))
        self.title = "Local do Jogo"
    }

}

extension MapViewController: MapViewProtocol {
   
    func updateView(with url: String) {
        interactor.url = url 
        
        let url = URL(string: url)!
        webView.load(URLRequest(url: url))
    }
    
}

extension MapViewController {
    
    @objc func handleShareButtonTap(){
        interactor.handleShareButtonTap()
    }
    
    @objc func handleGoToBack(){
        guard let url = interactor.url else { return }
        interactor.goToBack(
            hasChangeUrl:
                (Session.shared.isAdm ?? false) &&
            !(webView.url?.absoluteString.lowercased().contains("badenball") ?? false),
            newUrl: webView.url?.absoluteString ?? "")
    }
    
}
