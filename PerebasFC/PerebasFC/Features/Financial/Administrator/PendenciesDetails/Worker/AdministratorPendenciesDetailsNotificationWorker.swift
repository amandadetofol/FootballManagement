//
//  AdministratorPendenciesDetailsNotificationWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 21/08/23.
//

import NotificationCenter

protocol AdministratorPendenciesDetailsNotificationWorkerProtocol {
    func sendPaymentMissingNotification()
}

final class AdministratorPendenciesDetailsNotificationWorker: AdministratorPendenciesDetailsNotificationWorkerProtocol {
    
    func sendPaymentMissingNotification() {
        let userNotificationCenter = UNUserNotificationCenter.current()
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Hey!"
        notificationContent.body = "Adicione o comprovante de pagemento na sua conta :)"
        
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: 5,
            repeats: false)
        let request = UNNotificationRequest(
            identifier: "testNotification",
            content: notificationContent,
            trigger: trigger)
        
        userNotificationCenter.add(request) { _ in }
    }
    
}
