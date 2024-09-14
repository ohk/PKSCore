//
//  PKSMessageStatus.swift
//  
//
//  Created by Ömer Hamid Kamışlı on 8/17/24.
//

import Foundation

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public enum PKSMessageStatus: Int, Identifiable, CaseIterable, Equatable {
    
    /// The message has been sent but not yet delivered.
    ///
    /// This status indicates that the message has been successfully sent from the sender's device but has not yet reached the recipient.
    case sent = 0
    
    /// The message has been delivered to the recipient.
    ///
    /// This status indicates that the message has been successfully delivered to the recipient's device, but it has not been read yet.
    case delivered = 1
    
    /// The message has been read by the recipient.
    ///
    /// This status indicates that the recipient has opened and read the message.
    case read = 2
    
    /// The message has been failed to be sent.
    ///
    /// This status indicates that the message has failed to be sent from the sender's device.
    case failed = 3
    
    
    /// The unique identifier for each message status.
    ///
    /// This property conforms to the `Identifiable` protocol, allowing the enum to be used in SwiftUI lists and other views that require identifiable elements.
    ///
    /// - Returns: The raw value of the enum case as an `Int`.
    public var id: Int {
        return self.rawValue
    }
}

