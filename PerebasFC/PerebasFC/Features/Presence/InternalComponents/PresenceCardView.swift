//
//  PresenceCardView.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 07/09/23.
//

import UIKit

final class PresenceCardView: UIView {
    
    private lazy var participantName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var presenceSwitch: UISwitch = {
        let presenceSwitch = UISwitch()
        presenceSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        return presenceSwitch
    }()
    
    private lazy var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        
        return view
    }()
    
    var wasPresent: Bool {
        get {
            return presenceSwitch.isOn
        }
    }
    
    init(){
        super.init(frame: .zero)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateView(with model: PresenceCardViewModel) {
        
    }
    
    func updateAccessibility(with model: PresenceCardViewModel){
        
    }
    
    private func setupView(){
        
    }
    
    private func setupConstraints(){
        
    }
    
}
