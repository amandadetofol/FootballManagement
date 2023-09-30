//
//  WeekTeamViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 28/05/23.
//

import UIKit

protocol WeekTeamInteractorProtocol {
    func updateTeam(basedOn index: Int)
}

final class WeekTeamViewController: UIViewController {
    
    private let interactor: WeekTeamInteractorProtocol
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Time Branco", "Time Preto"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.backgroundColor = .systemYellow.withAlphaComponent(0.20)
        
        let titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)]
        segmentedControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
        segmentedControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        
        return segmentedControl
    }()
    
    private lazy var weekTeamView: WeekTeamView = {
        let view = WeekTeamView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    init(interactor: WeekTeamInteractorProtocol){
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmentedControl()
        setupNavigationController()
        interactor.updateTeam(basedOn: 1)
        view.backgroundColor = .white
    }
    
    private func setupNavigationController(){
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = false
        title = "Times"
    }
    
    private func setupSegmentedControl(){
        view.addSubview(segmentedControl)
        view.addSubview(weekTeamView)
        
        NSLayoutConstraint.activate([
            segmentedControl.heightAnchor.constraint(equalToConstant: 48),
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
            
            weekTeamView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            weekTeamView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            weekTeamView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
            weekTeamView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension WeekTeamViewController {
    
    @objc func segmentedValueChanged(_ sender: UISegmentedControl!) {
        interactor.updateTeam(basedOn: sender.selectedSegmentIndex)
    }
    
}

extension WeekTeamViewController: WeekTeamViewProtocol {
    
    func clearView() {
        weekTeamView.removeAllCards()
    }
    
    func updateView(team: [WeekTeamListViewModel]) {
        weekTeamView.setupView(with: team)
    }

}
