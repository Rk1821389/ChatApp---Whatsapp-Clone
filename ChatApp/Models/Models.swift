//
//  Models.swift
//  ChatApp
//
//  Created by Rahul on 02/06/23.
//

import Foundation
import FirebaseAuth

@MainActor
class Models: ObservableObject {
    
    func updateDisplayName(for user: User, displayName: String) async throws {
        let request = user.createProfileChangeRequest()
        request.displayName = displayName
        try await request.commitChanges()
    }
    
}
