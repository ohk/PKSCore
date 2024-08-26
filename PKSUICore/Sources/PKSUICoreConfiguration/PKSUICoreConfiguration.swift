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
    
    public var imagePipeline: ImagePipeline = ImagePipeline {
        $0.dataCachePolicy = .automatic
        $0.isResumableDataEnabled = true
        $0.isProgressiveDecodingEnabled = true
        $0.isRateLimiterEnabled = true
        $0.isTaskCoalescingEnabled = true
    }
    
    public init() {}
    
    @Published public private(set) var avatarGlobalConfiguration: PKSAvatarConfiguration = PKSAvatarConfiguration()
    
    @Published public private(set) var radiusConfiguration: RadiusConfiguration = RadiusConfiguration()

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
}
