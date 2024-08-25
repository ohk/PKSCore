//
//  PKSUICoreConfiguration.swift
//
//
//  Created by Ömer Hamid Kamışlı on 8/17/24.
//

import SwiftUI

public class PKSUICoreConfiguration: ObservableObject {  
    
    public static let shared: PKSUICoreConfiguration = .init()
    
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
