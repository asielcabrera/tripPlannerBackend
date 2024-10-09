//
//  StyleConfiguration.swift
//  trip-planner
//
//  Created by Asiel Cabrera Gonzalez on 10/7/24.
//

import HTMLKitComponents

struct PrimaryButton: ButtonConfiguration {
    
    var foregroundColor: Tokens.ForegroundColor? = .white
    var borderColor: Tokens.BorderColor? = .accent
    var borderShape: Tokens.BorderShape? = .smallrounded
    var backgroundColor: Tokens.BackgroundColor? = .accent
}

struct ControlButton: ButtonConfiguration {
    
    var borderColor: Tokens.BorderColor? = .system
    var borderShape: Tokens.BorderShape? = .smallrounded
    var backgroundColor: Tokens.BackgroundColor? = .system
    var foregroundColor: Tokens.ForegroundColor? = .system
}
