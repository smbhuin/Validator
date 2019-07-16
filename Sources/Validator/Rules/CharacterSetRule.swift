//
//  CharacterSetRule.swift
//  Validator
//
//  Created by Soumen Bhuin on 25/06/19.
//  Copyright © 2019 SMB. All rights reserved.
//

import Foundation

/**
 `CharacterSetRule` is a subclass of `ValidationRule`. It is used to verify that a field has a
 valid list of characters.
 */
open class CharacterSetRule : ValidationRule<String> {
    
    /// NSCharacter that hold set of valid characters to hold
    private let characterSet: CharacterSet
    
    /**
     Initializes a `CharacterSetRule` object to verify that field has valid set of characters.
     
     - parameter characterSet: NSCharacterSet that holds group of valid characters.
     - returns: An initialized object, or nil if an object could not be created for some reason that would not result in an exception.
     */
    public init(characterSet: CharacterSet, message: String = "contains invalid characters") {
        self.characterSet = characterSet
        super.init(message: message)
    }
    
    /**
     Used to validate string value.
     
     - parameter value: String to be checked for validation.
     - returns: `ValidationError`. nil if validation is successful; `ValidationError` if validation fails.
     */
    open override func validate(_ value: String?) -> ValidationError? {
        guard let v = value else { return nil }
        for uni in v.unicodeScalars {
            guard let uniVal = UnicodeScalar(uni.value), characterSet.contains(uniVal) else {
                return ValidationError(self.message)
            }
        }
        return nil
    }
    
}

public extension ValidationRule {
    
    /// Quick accessor for `CharacterSetRule`
    class func characterSet(_ validCharacters: CharacterSet) -> ValidationRule<String> {
        return CharacterSetRule(characterSet: validCharacters)
    }
    
}
