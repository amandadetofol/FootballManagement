//
//  NewEventInCalendarViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 26/07/23.
//

import UIKit

protocol NewEventInCalendarViewInteractorProtocol: AnyObject {
    func handleConfirmButtonTap(_ model: NewEventInCalendarViewModel)
}

final class NewEventInCalendarViewController: UIViewController {
    
    private lazy var newEventInCalendarView: NewEventInCalendarView = {
        let newEventInCalendarView = NewEventInCalendarView()
        newEventInCalendarView.delegate = self
        
        return newEventInCalendarView
    }()
    
    private let interactor: NewEventInCalendarViewInteractorProtocol
    
    init(interactor: NewEventInCalendarViewInteractorProtocol){
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = newEventInCalendarView
    }
    
}

extension NewEventInCalendarViewController: NewEventInCalendarViewDelegate {
    
    func handleConfirmButtonTap(_ model: NewEventInCalendarViewModel) {
        interactor.handleConfirmButtonTap(model)
    }

}
