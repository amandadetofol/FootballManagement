//
//  WeekTeamViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 28/05/23.
//

import UIKit

final class WeekTeamViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmentedControl()
        setupNavigationController()
    }
    
    private func setupNavigationController(){
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = false
        title = "Times"
    }
    
    private func setupSegmentedControl(){
        view.addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            segmentedControl.heightAnchor.constraint(equalToConstant: 48),
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4)
        ])
    }
}

extension WeekTeamViewController {
    
    @objc func segmentedValueChanged(_ sender:UISegmentedControl!) {
       print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
    }
    
}
