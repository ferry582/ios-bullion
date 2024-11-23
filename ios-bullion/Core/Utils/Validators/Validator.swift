//
//  Validator.swift
//  ios-bullion
//
//  Created by Ferry Dwianta P on 23/11/24.
//

import Foundation

class Validator {
    static func validate(text: String, with rules: [Rule]) throws {
        for rule in rules {
            try rule.check(text)
        }
    }
}

struct Rule {
    let check: (String) throws -> Void
    
    static func notEmpty(field: String) -> Rule {
        return Rule { text in
            if text.isEmpty { throw ValidationError.notEmpty(field: field) }
        }
    }

    static let validEmail: Rule = Rule(check: { text in
        let regex = #"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        if !predicate.evaluate(with: text) { throw ValidationError.invalidEmail }
    })
    
    static let validPassword: Rule = Rule(check:  { pass in
        let regex = "^(?=.*[A-Z])(?=.*\\d)[A-Za-z\\d\\S]{8,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        if !predicate.evaluate(with: pass) { throw ValidationError.invalidPassword }
    })
}

enum ValidationError: Error {
    case notEmpty(field: String)
    case invalidEmail
    case invalidPassword
    
    var description: String {
        switch self {
        case .notEmpty(let field):
            return "\(field) must not be empty"
        case .invalidEmail:
            return "Must have valid email"
        case .invalidPassword:
            return "Invalid password, password must have at least 8 characters, one uppercase, and one number"
        }
    }
}
