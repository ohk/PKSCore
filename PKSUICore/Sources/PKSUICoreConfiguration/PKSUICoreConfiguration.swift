//
//  PKSUICoreConfiguration.swift
//
//
//  Created by Ömer Hamid Kamışlı on 8/17/24.
//

import SwiftUI
import Nuke

public class PKSUICoreConfiguration: ObservableObject {
    
    public static let shared: PKSUICoreConfiguration = .init()
    
    public init() {}
    
    @Published public private(set) var avatarGlobalConfiguration: PKSAvatarConfiguration = PKSAvatarConfiguration()
    
    @Published public private(set) var radiusConfiguration: RadiusConfiguration = RadiusConfiguration()
    
    @Published public private(set) var messageBubbleConfiguration: PKSMessageBubbleConfiguration = PKSMessageBubbleConfiguration()

    @Published public private(set) var imageConfiguration: PKSImageConfiguration = PKSImageConfiguration()

    public func updateAvatarGlobalConfiguration(_ conf: PKSAvatarConfiguration) {
        DispatchQueue.main.async { [weak self] in
            self?.avatarGlobalConfiguration = conf
        }
    }

    public func updateRadiusConfiguration(_ conf: RadiusConfiguration) {
        DispatchQueue.main.async { [weak self] in
            self?.radiusConfiguration = conf
        }
    }   
    
    public func updateMessageBubbleConfiguration(_ conf: PKSMessageBubbleConfiguration) {
        DispatchQueue.main.async { [weak self] in
            self?.messageBubbleConfiguration = conf
        }
    } 

    public func updateImageConfiguration(_ conf: PKSImageConfiguration) {
        DispatchQueue.main.async { [weak self] in
            self?.imageConfiguration = conf
        }
    }

    public func updateImagePipelinePriority(_ priority: ImageRequest.Priority) {
        DispatchQueue.main.async { [weak self] in
            self?.imageConfiguration.defaultPriority = priority
        }
    }
}
