//
//  JSONSerializer.swift
//  wiserIos
//
//  Created by Peter Helstrup Jensen on 27/08/2015.
//  Copyright © 2015 Peter Helstrup Jensen. All rights reserved.
//

//This is an ongoing effort by me which has been posted in various versions on github as gists and or questions on forums like stackoverflow etc.
//See JSONSerializerTests

import Foundation

/// Handles Convertion from instances of objects to JSON strings. Also helps with casting strings of JSON to Arrays or Dictionaries.
public class JSONSerializer {
    
    /**
    Errors that indicates failures of JSONSerialization
    - JsonIsNotDictionary:	-
    - JsonIsNotArray:			-
    - JsonIsNotValid:			-
    */
    enum JSONSerializerError: ErrorType {
        case JsonIsNotDictionary
        case JsonIsNotArray
        case JsonIsNotValid
    }
    
    //http://stackoverflow.com/questions/30480672/how-to-convert-a-json-string-to-a-dictionary
    /**
    Tries to convert a JSON string to a NSDictionary. NSDictionary can be easier to work with, and supports string bracket referencing. E.g. personDictionary["name"].
    - parameter jsonString:	JSON string to be converted to a NSDictionary.
    - throws: Throws error of type JSONSerializerError. Either JsonIsNotValid or JsonIsNotDictionary. JsonIsNotDictionary will typically be thrown if you try to parse an array of JSON objects.
    - returns: A NSDictionary representation of the JSON string.
    */
    public static func toDictionary(jsonString: String) throws -> NSDictionary {
        if let dictionary = try jsonToAnyObject(jsonString) as? NSDictionary {
            return dictionary
        } else {
            throw JSONSerializerError.JsonIsNotDictionary
        }
    }
    
    /**
    Tries to convert a JSON string to a NSArray. NSArrays can be iterated and each item in the array can be converted to a NSDictionary.
    - parameter jsonString:	The JSON string to be converted to an NSArray
    - throws: Throws error of type JSONSerializerError. Either JsonIsNotValid or JsonIsNotArray. JsonIsNotArray will typically be thrown if you try to parse a single JSON object.
    - returns: NSArray representation of the JSON objects.
    */
    public static func toArray(jsonString: String) throws -> NSArray {
        if let array = try jsonToAnyObject(jsonString) as? NSArray {
            return array
        } else {
            throw JSONSerializerError.JsonIsNotArray
        }
    }
    
    /**
    Tries to convert a JSON string to AnyObject. AnyObject can then be casted to either NSDictionary or NSArray.
    - parameter jsonString:	JSON string to be converted to AnyObject
    - throws: Throws error of type JSONSerializerError.
    - returns: Returns the JSON string as AnyObject
    */
    private static func jsonToAnyObject(jsonString: String) throws -> AnyObject? {
        var any: AnyObject?
        
        if let data = jsonString.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                any = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
            }
            catch let error as NSError {
                let sError = String(error)
                NSLog(sError)
                throw JSONSerializerError.JsonIsNotValid
            }
        }
        return any
    }
    
    /**
    Generates the JSON representation given any custom object of any custom class. Inherited properties will also be represented.
    - parameter object:	The instantiation of any custom class to be represented as JSON.
    - returns: A string JSON representation of the object.
    */
    public static func toJson(object: Any) -> String {
        var json = "{"
        let mirror = Mirror(reflecting: object)
        
        var children = [(label: String?, value: Any)]()
        let mirrorChildrenCollection = AnyRandomAccessCollection(mirror.children)!
        children += mirrorChildrenCollection
        
        var currentMirror = mirror
        while let superclassChildren = currentMirror.superclassMirror()?.children {
            let randomCollection = AnyRandomAccessCollection(superclassChildren)!
            children += randomCollection
            currentMirror = currentMirror.superclassMirror()!
        }
        
        let size = children.count
        var index = 0
        
        for (optionalPropertyName, value) in children {
            
            /*let type = value.dynamicType
            let typeString = String(type)
            print("SELF: \(type)")*/
            
            let propertyName = optionalPropertyName!
            let property = Mirror(reflecting: value)
            
            var handledValue = String()
            if value is Int || value is Double || value is Float || value is Bool {
                handledValue = String(value ?? "null")
            }
            else if let array = value as? [Int?] {
                handledValue += "["
                for (index, value) in array.enumerate() {
                    handledValue += value != nil ? String(value!) : "null"
                    handledValue += (index < array.count-1 ? ", " : "")
                }
                handledValue += "]"
            }
            else if let array = value as? [Double?] {
                handledValue += "["
                for (index, value) in array.enumerate() {
                    handledValue += value != nil ? String(value!) : "null"
                    handledValue += (index < array.count-1 ? ", " : "")
                }
                handledValue += "]"
            }
            else if let array = value as? [Float?] {
                handledValue += "["
                for (index, value) in array.enumerate() {
                    handledValue += value != nil ? String(value!) : "null"
                    handledValue += (index < array.count-1 ? ", " : "")
                }
                handledValue += "]"
            }
            else if let array = value as? [Bool?] {
                handledValue += "["
                for (index, value) in array.enumerate() {
                    handledValue += value != nil ? String(value!) : "null"
                    handledValue += (index < array.count-1 ? ", " : "")
                }
                handledValue += "]"
            }
            else if let array = value as? [String?] {
                handledValue += "["
                for (index, value) in array.enumerate() {
                    handledValue += value != nil ? "\"\(value!)\"" : "null"
                    handledValue += (index < array.count-1 ? ", " : "")
                }
                handledValue += "]"
            }
            else if let array = value as? [String] {
                handledValue += "["
                for (index, value) in array.enumerate() {
                    handledValue += "\"\(value)\""
                    handledValue += (index < array.count-1 ? ", " : "")
                }
                handledValue += "]"
            }
            else if let array = value as? NSArray {
                handledValue += "["
                for (index, value) in array.enumerate() {
                    if !(value is Int) && !(value is Double) && !(value is Float) && !(value is Bool) && !(value is String) {
                        handledValue += toJson(value)
                    }
                    else {
                        handledValue += "\(value)"
                    }
                    handledValue += (index < array.count-1 ? ", " : "")
                }
                handledValue += "]"
            }
            else if property.displayStyle == Mirror.DisplayStyle.Class {
                handledValue = toJson(value)
            }
            else if property.displayStyle == Mirror.DisplayStyle.Optional {
                let str = String(value)
                if str != "nil" {
                    handledValue = String(str).substringWithRange(Range<String.Index>(start: str.startIndex.advancedBy(9), end: str.endIndex.advancedBy(-1)))
                }
                else {
                    handledValue = "null"
                }
            }
            else {
                handledValue = String(value) != "nil" ? "\"\(value)\"" : "null"
            }
            
            json += "\"\(propertyName)\": \(handledValue)" + (index < size-1 ? ", " : "")
            ++index
        }
        json += "}"
        return json
    }
}