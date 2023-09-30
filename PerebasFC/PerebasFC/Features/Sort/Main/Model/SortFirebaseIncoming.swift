//
//  SortFirebaseIncoming.swift
//  PerebasFC
//
//  Created by Amanda Detofol on 29/09/23.
//

import FirebaseFirestore

struct SortFirebaseIncoming {
    let whiteTeam: [QuerySnapshot]
    let blackTeam: [QuerySnapshot]
    let otherData: [DocumentSnapshot]
}
