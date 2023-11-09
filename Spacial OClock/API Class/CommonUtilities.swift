//
//  CommonUtilities.swift
//  Schedula
//
//  Created by apple on 11/09/19.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
import UIKit
import SwiftMessages
class CommonUtilities{
    static let shared = CommonUtilities()
    
//    static let shared = CommonUtilities()

 func showAlert( Title :String = "", message: String , isSuccess : Theme,  duration: TimeInterval = 3){
        SwiftMessages.hideAll()
        DispatchQueue.main.async {
            let warning = MessageView.viewFromNib(layout: .cardView)
            warning.configureTheme(isSuccess)
            warning.backgroundView.backgroundColor = (isSuccess == .success) ? #colorLiteral(red: 0.4322607219, green: 0.792467773, blue: 0.0966636911, alpha: 1) : .red
            warning.configureDropShadow()
            warning.configureContent(title: Title, body: message)
            warning.button?.isHidden = true
            var warningConfig = SwiftMessages.defaultConfig
            warningConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
            warningConfig.duration = .seconds(seconds: duration)
            SwiftMessages.show(config: warningConfig, view: warning)
        }
    }

}
