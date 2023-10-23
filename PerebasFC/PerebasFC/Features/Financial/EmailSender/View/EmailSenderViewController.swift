//
//  EmailSenderViewController.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 20/10/23.
//

import Foundation
import MessageUI

protocol EmailSenderInteractorProtocol {
    func showAlert()
    func showSuccessAlert()
    func showEmailUnavailableAlert()
    func showEmailView(controller: UIViewController)
    func popEmailView(controller: UIViewController)
}

final class EmailSender: NSObject, MFMailComposeViewControllerDelegate {
    
    private lazy var mailComposeViewController: MFMailComposeViewController = {
        let mailComposeViewController = MFMailComposeViewController()
        mailComposeViewController.mailComposeDelegate = self
        mailComposeViewController.setSubject("Perebas FC - Comprovante de pagamento!")
        
        return mailComposeViewController
    }()
    
    private let interactor: EmailSenderInteractorProtocol
    
    init(interactor: EmailSenderInteractorProtocol){
        self.interactor = interactor
    }
    
    func updateView(
        email: String,
        information: FinancialAdministratorPendenciesListCardModel){
            if MFMailComposeViewController.canSendMail() {
                mailComposeViewController.setToRecipients([email])
                mailComposeViewController
                    .setMessageBody("Olá \(email)! \n Lembre-se de adicionar o comprovante de pagamento do item \(information.name). \n", isHTML: false)
                interactor.showEmailView(controller: mailComposeViewController)
            } else {
                interactor.showEmailUnavailableAlert()
            }
        }
    
}

extension EmailSender {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error {
            interactor.showAlert()
        } else {
            interactor.showSuccessAlert()
        }
        mailComposeViewController.dismiss(animated: true)
    }
    
}
