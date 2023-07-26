//
//  CalendarViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 09/06/23.
//

import UIKit
import HorizonCalendar

protocol CalendarViewInteractorProtocol {
    func viewDidLoad()
    func showConfirmPresencePopUp()
    func showCreateNewEventPopUp()
    func showEventForSelectedDayPopUpNotFound()
    func handlePopUpButtonTap(key: String)
}

final class CalendarViewController: UIViewController {
    
    var eventDays: [Int] = []
    
    private lazy var calendarItemPopUpView: CalendarItemPopUpView = {
        let view = CalendarItemPopUpView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        self.view.addSubview(view)
        
        return view
    }()
    
    private var content: CalendarViewContent = {
        let calendar = Calendar.current
        let startDate = calendar.date(
            from: DateComponents(
                year: 2023,
                month: 07,
                day: 14))!
        
        let endDate = calendar.date(
            from: DateComponents(
                year: 2024,
                month: 07,
                day: 14))!
        
        return CalendarViewContent(
            calendar: calendar,
            visibleDateRange: startDate...endDate,
            monthsLayout: .vertical(options: VerticalMonthsLayoutOptions()))
    }()
    
    private lazy var calendarView: CalendarView = {
        let calendarView = CalendarView(initialContent: content)
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        return calendarView
    }()
    
    private let isAdm = Session.shared.isAdm ?? false 
    private let interactor: CalendarViewInteractorProtocol

    init(interactor: CalendarViewInteractorProtocol){
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        addDateSelectorActionHandler()
        
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Calendário de eventos"
        interactor.viewDidLoad()
        showEventForSelectedDayPopUpNotFound()
    }
    
    private func setupConstraints(){
        view.addSubview(calendarView)
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calendarView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/2 - 32),
            
            calendarItemPopUpView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            calendarItemPopUpView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarItemPopUpView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func createCustomDayProviderForSelectedItem(iconmingDay: Int) {
        content.dayItemProvider { day in
            if day.components.day == iconmingDay {
                return DayLabel.calendarItemModel(
                    invariantViewProperties: .init(
                        font: UIFont.systemFont(ofSize: 18),
                        textColor: .white,
                        backgroundColor: .gold),
                    content: .init(day: day))
            } else if self.eventDays.contains(day.components.day ?? 0) {
                return DayLabel.calendarItemModel(
                    invariantViewProperties: .init(
                        font: UIFont.systemFont(ofSize: 18),
                        textColor: .red,
                        backgroundColor: .clear),
                    content: .init(day: day))
            } else {
                return DayLabel.calendarItemModel(
                        invariantViewProperties: .init(
                          font: UIFont.systemFont(ofSize: 18),
                          textColor: .black,
                          backgroundColor: .clear),
                        content: .init(day: day))
            }
        }
        calendarView.setContent(content)
    }
    
    private func addDateSelectorActionHandler() {
        calendarView.daySelectionHandler = { [weak self] day in
            guard let self else { return }
            self.createCustomDayProviderForSelectedItem(iconmingDay: day.day)
            
            if eventDays.contains(day.day) {
                self.interactor.showConfirmPresencePopUp()
            } else if isAdm {
                self.interactor.showCreateNewEventPopUp()
            } else {
                self.interactor.showEventForSelectedDayPopUpNotFound()
            }
        }
    }
}

extension CalendarViewController: CalendarViewProtocol {
    
    func updateEvents(events: [Int]) {
        self.eventDays = events
        createCustomDayProviderForSelectedItem(iconmingDay: 0)
    }
    
    func showConfirmPresencePopUp() {
        calendarItemPopUpView.updateView(
            with: CalendarItemPopUpViewModel(
                title: "Evento do grupo!",
                description: "Encontramos um evento do grupo neste dia. Não esqueça de confirmar sua presença!",
                firstActionTitle: "confirmar presença".uppercased(),
                secondActionTitle: nil,
                firstActionKey: CalendarPopUpKeysEnum.confirmPresence.rawValue,
                secondActionKey: nil))
    }
    
    func showCreateNewEventPopUp() {
        calendarItemPopUpView.updateView(
            with: CalendarItemPopUpViewModel(
                title: "Nenhum evento!",
                description: "Não encontramos nenhum evento para a data selecionada. Deseja criar um novo evento?",
                firstActionTitle: "criar novo evento".uppercased(),
                secondActionTitle: "ok".uppercased(),
                firstActionKey: CalendarPopUpKeysEnum.createNewEvent.rawValue,
                secondActionKey: CalendarPopUpKeysEnum.close.rawValue))
    }
    
    func showEventForSelectedDayPopUpNotFound() {
        calendarItemPopUpView.updateView(
            with: CalendarItemPopUpViewModel(
                title: "Nenhum evento!",
                description: "Não encontramos nenhum evento para a data selecionada.",
                firstActionTitle: "ok".uppercased(),
                secondActionTitle: nil,
                firstActionKey: CalendarPopUpKeysEnum.close.rawValue,
                secondActionKey: nil))
    }
    
}

extension CalendarViewController: CalendarItemPopUpViewDelegate {
    
    func handleFirstActionButtonTap(key: String) {
        interactor.handlePopUpButtonTap(key: key)
    }
    
    func handleSecondActionButtonTap(key: String) {
        interactor.handlePopUpButtonTap(key: key)
    }

}
