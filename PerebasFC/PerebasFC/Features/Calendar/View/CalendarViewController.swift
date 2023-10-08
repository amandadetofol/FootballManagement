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
    func showConfirmPresencePopUp(model: NewEventInCalendarViewModel)
    func showCreateNewEventPopUp(date: Date)
    func showEventForSelectedDayPopUpNotFound(date: Date)
    func handlePopUpButtonTap(
        key: String,
        model: NewEventInCalendarViewModel?,
        date: Date?)
}

final class CalendarViewController: UIViewController {
    
    var eventDays: [NewEventInCalendarViewModel] = []
    var selectedDate = Date()
    
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
        
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Calendário de eventos"
        interactor.viewDidLoad()
        showEventForSelectedDayPopUpNotFound(date: selectedDate)
        self.accessibilityElements = [calendarView, calendarItemPopUpView]
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
            } else if self.eventDays.contains(where: { model in
                model.day == day.day
            }) { return DayLabel.calendarItemModel(
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
    
            let month = (day.components.month ?? 0 > 9) ? "\(day.components.month ?? 0)" : "0\(day.components.month ?? 0)"
            let string = "\(day.components.day ?? 0)/\(month)/\(day.components.year ?? 0)"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yy"
            let correctDate = dateFormatter.date(from: string)
     
            if eventDays.contains(where: { model in
                model.day == day.day
            }) {
                guard let item = eventDays.first(where: { model in
                    model.day == day.day
                }) else { return }
                self.interactor.showConfirmPresencePopUp(model: item)
                
            } else if isAdm {
                self.interactor.showCreateNewEventPopUp(date: correctDate ?? Date())
            } else {
                self.interactor.showEventForSelectedDayPopUpNotFound(date: day.components.date ?? Date())
            }
        }
    }
}

extension CalendarViewController: CalendarViewProtocol {
    
    func updateEvents(events: [NewEventInCalendarViewModel]) {
        self.eventDays = events
        addDateSelectorActionHandler()
        createCustomDayProviderForSelectedItem(iconmingDay: 0)
    }
    
    func showConfirmPresencePopUp(model: NewEventInCalendarViewModel) {
        calendarItemPopUpView.updateView(
            with: CalendarItemPopUpViewModel(
                title: "Evento do grupo!",
                description: "Encontramos um evento do grupo neste dia. Não esqueça de confirmar sua presença!",
                firstActionTitle: "confirmar presença".uppercased(),
                secondActionTitle: (Session.shared.isAdm ?? false) ? "lista de presença".uppercased() : nil,
                firstActionKey: CalendarPopUpKeysEnum.confirmPresence.rawValue,
                secondActionKey: (Session.shared.isAdm ?? false) ? CalendarPopUpKeysEnum.presenceList.rawValue : nil,
                numberOfCompanions: nil),
            date: model)
    }
    
    func showCreateNewEventPopUp(date:  Date) {
        calendarItemPopUpView.updateView(
            with: CalendarItemPopUpViewModel(
                title: "Nenhum evento!",
                description: "Não encontramos nenhum evento para a data selecionada. Deseja criar um novo evento?",
                firstActionTitle: "criar novo evento".uppercased(),
                secondActionTitle: "ok".uppercased(),
                firstActionKey: CalendarPopUpKeysEnum.createNewEvent.rawValue,
                secondActionKey: CalendarPopUpKeysEnum.close.rawValue,
                numberOfCompanions: nil),
            date: nil,
            itemDate: date)
    }
    
    func showEventForSelectedDayPopUpNotFound(date: Date) {
        calendarItemPopUpView.updateView(
            with: CalendarItemPopUpViewModel(
                title: "Nenhum evento!",
                description: "Não encontramos nenhum evento para a data selecionada.",
                firstActionTitle: "ok".uppercased(),
                secondActionTitle: nil,
                firstActionKey: CalendarPopUpKeysEnum.close.rawValue,
                secondActionKey: nil,
                numberOfCompanions: nil),
            date: nil,
            itemDate: date)
    }
    
}

extension CalendarViewController: CalendarItemPopUpViewDelegate {
    
    func handleFirstActionButtonTap(
        key: String,
        model: NewEventInCalendarViewModel?,
        date: Date?) {
            interactor.handlePopUpButtonTap(key: key, model: model, date: date)
    }
    
    func handleSecondActionButtonTap(
        key: String,
        model: NewEventInCalendarViewModel?,
        date: Date?) {
            interactor.handlePopUpButtonTap(key: key, model: model, date: date)
    }

}
