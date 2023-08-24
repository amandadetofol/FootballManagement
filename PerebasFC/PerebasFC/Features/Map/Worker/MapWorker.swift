//
//  MapWorker.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 23/08/23.
//

import Foundation

protocol MapWorkerProtocol {
    func getLocalUrl() -> String
}

final class MapWorker: MapWorkerProtocol {
    
    func getLocalUrl() -> String {
        return "https://www.google.com.br/maps/place/Badenball+Society/@-26.8789587,-49.1424786,17z/data=!3m1!4b1!4m6!3m5!1s0x94df1dc7d00b3973:0x8087b9461a6d3c37!8m2!3d-26.8789587!4d-49.1399037!16s%2Fg%2F11f121l5ms?entry=ttu"
    }
    
}
