//
//  CoordinateRule.swift
//  Validator
//
//  Created by Soumen Bhuin on 07/07/19.
//  Copyright © 2019 SMB. All rights reserved.
//

import Foundation

/**
 `CoordinateRule` is a subclass of ValidationRule that defines how check if a value is a latitude or longitude value. Value must be array of string or double. longitude should be first element.
 */
public class CoordinateRule: ValidationRule {
    
    /**
     Initializes a `CoordinateRule` object to validate that provided value is valid lat or long coordinate.
     
     - parameter message: String of error message.
     - returns: An initialized object, or nil if an object could not be created for some reason that would not result in an exception.
     */
    public override init(message: String = "is not a valid geo coordinate"){
        super.init(message: message)
    }
    
    /**
     Used to validate Coordinate value.
     
     - parameter value: array of String/Double to be checked for validation. longitude should be first element.
     - returns: `ValidationError`. nil if validation is successful; `ValidationError` if validation fails.
     */
    public override func validate(_ value: Any?) -> ValidationError? {
        guard let ad = value
            else  {
                return nil
        }
        let error = ValidationError(self.message)
        switch ad {
        case let d as [String]:
            if d.count == 2 {
                if let long = Double(d[0]), let lat = Double(d[1]) {
                    if long >= -180.0 && long <= 180.0 && lat >= -90.0 && lat <= 90.0 {
                        return nil
                    }
                }
            }
        case let d as [Double]:
            if d.count == 2 {
                let long = d[0]
                let lat = d[1]
                if long >= -180.0 && long <= 180.0 && lat >= -90.0 && lat <= 90.0 {
                    return nil
                }
            }
        default:
            return ValidationError.inapplicable()
        }
        return error
    }
    
}

public extension ValidationRule {
    
    /// Quick accessor for `CoordinateRule`
    public class var coordinate: ValidationRule {
        get  {
            return CoordinateRule()
        }
    }
    
}