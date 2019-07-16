//
//  YearExpiryRule.swift
//  Validator
//
//  Created by Soumen Bhuin on 26/06/19.
//  Copyright © 2019 SMB. All rights reserved.
//

import Foundation

/**
 `YearExpiryRule` is a subclass of `ValidationRule` that defines how a credit/debit card's expiry year is validated
 */
public class YearExpiryRule : ValidationRule<String> {
    
    /// Default maximum validity period. Change to preferred value
    private var validity: Int = 3

    /**
     Initializes `YearExpiryRule` object with error message. Used to validate a card's expiry year.
     
     - parameter message: Error message string.
     - returns: An initialized `YearExpiryRule` object, or nil if an object could not be created for some reason that would not result in an exception.
     */
    public init(validity: Int = 3, message: String = "") {
        self.validity = validity
        super.init(message: message == "" ? "must be within \(3) years of validity": message)
    }

    /**
     Validates a field.
     
     - parameter value: String or Int to check for validation.
     - returns: `ValidationError`. nil on successful validation, otherwise `ValidationError` on failed Validation.
     */
    public override func validate(_ value: String?) -> ValidationError? {
        guard let v = value else { return nil }
        let error = ValidationError(self.message)
        guard let year = Int(v) else {
            return error
        }
        // Holds the current year
        let thisYear = Calendar.current.component(Calendar.Component.year, from: Date())
        if year < thisYear || year > (thisYear + validity) {
            return error
        }
        return nil
    }

}

public extension ValidationRule {
    
    /// Quick accessor for `YearExpiryRule`
    class func yearExpiry(validity: Int = 3) -> ValidationRule<String> {
        return YearExpiryRule(validity: 3)
    }
    
}
