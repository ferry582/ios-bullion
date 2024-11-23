//
//  Alert.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 24/11/24.
//

import UIKit

struct Alert {
    static func present(title: String?, message: String, actions: Alert.Action..., from controller: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alertController.addAction(action.alertAction)
        }
        controller.present(alertController, animated: true, completion: nil)
    }
}

extension Alert {
    enum Action {
        case ok(handler: (() -> Void)?)
        case close

        private var title: String {
            switch self {
            case .ok:
                return "OK"
            case .close:
                return "Close"
            }
        }

        private var style: UIAlertAction.Style {
            switch self {
            case .ok:
                return .default
            case .close:
                return .cancel
            }
        }
        
        private var handler: (() -> Void)? {
            switch self {
            case .ok(let handler):
                return handler
            case .close:
                return nil
            }
        }

        var alertAction: UIAlertAction {
            return UIAlertAction(title: title, style: style, handler: { _ in
                if let handler = self.handler {
                    handler()
                }
            })
        }
    }
}
