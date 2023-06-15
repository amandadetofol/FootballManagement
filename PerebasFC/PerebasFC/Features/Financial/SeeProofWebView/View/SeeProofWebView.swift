//
//  SeeProofWebView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 13/06/23.
//

import UIKit
import WebKit

final class SeeProofWebView: UIView {
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        return webView
    }()
    
    init(url: String){
        super.init(frame: .zero)
        loadContent(url: url)
        setupView()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadContent(url: String){
        guard let urlObject = URL(string: url) else { return }
        let request = URLRequest(url: urlObject)
        webView.load(request)
    }
    
    private func setupView(){
        addSubview(webView)
        backgroundColor = .systemBrown.withAlphaComponent(0.10)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
