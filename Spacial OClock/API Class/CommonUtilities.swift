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

    
    func showAlert(message :String){
        DispatchQueue.main.async
        {
            let alert = UIAlertController(title: appName, message: message, preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok" , style: .default, handler: { action in
                DispatchQueue.main.async {
                alert.dismiss(animated: true, completion: nil)
                }
               })
            
            alert.addAction(ok)
            
            DispatchQueue.main.async {
                //if let window = UIApplication.shared.keyWindow
                if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first{
                    DispatchQueue.main.async {
                        window.rootViewController!.present(alert, animated: true)
                    }
                }
            }
        }
    }
    
 func showAlert( Title :String = "", message: String , isSuccess : Theme,  duration: TimeInterval = 3){
        SwiftMessages.hideAll()
        DispatchQueue.main.async {
            let warning = MessageView.viewFromNib(layout: .cardView)
            warning.configureTheme(isSuccess)
            warning.backgroundView.backgroundColor = (isSuccess == .success) ? UIColor(named: "themeGreen") : .red
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
