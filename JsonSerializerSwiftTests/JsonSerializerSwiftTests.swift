//
//  JSONSerializerTests.swift
//  wiserIos
//
//  Created by Peter Helstrup Jensen on 27/08/2015.
//  Copyright © 2015 Peter Helstrup Jensen. All rights reserved.
//

import XCTest
@testable import JsonSerializerSwift

class JSONSerializerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //JSONSerializer tests
    func stringCompareHelper(actual: String, _ expected: String) {
        XCTAssertTrue(expected == actual, "expected value:\(expected) not equal to actual:\(actual)")
    }
    
    func test_string_apple() {
        //Arrange
        class TestClass {
            var name = "apple"
        }
        
        let m = TestClass()
        
        //Act
        let json = JSONSerializer.toJson(m)
        
        //Assert
        let expected = "{\"name\": \"apple\"}"
        stringCompareHelper(json, expected)
    }
    
    func test_optionalString_nil() {
        //Arrange
        class TestClass {
            var name: String? = nil
        }
        
        let m = TestClass()
        
        //Act
        let json = JSONSerializer.toJson(m)
        
        //Assert
        let expected = "{\"name\": null}"
        stringCompareHelper(json, expected)
    }
    
    func test_optionalString_apple() {
        //Arrange
        class TestClass {
            var name: String? = "apple"
        }
        
        let m = TestClass()
        
        //Act
        let json = JSONSerializer.toJson(m)
        
        //Assert
        let expected = "{\"name\": \"apple\"}"
        stringCompareHelper(json, expected)
    }
    
    func test_int_5() {
        //Arrange
        class TestClass {
            var weight = 5
        }
        
        let m = TestClass()
        
        //Act
        let json = JSONSerializer.toJson(m)
        
        //Assert
        let expected = "{\"weight\": 5}"
        stringCompareHelper(json, expected)
    }
    
    
    func test_double_2dot1() {
        //Arrange
        class TestClass {
            var weight = 2.1
        }
        
        let m = TestClass()
        
        //Act
        let json = JSONSerializer.toJson(m)
        
        //Assert
        let expected = "{\"weight\": 2.1}"
        stringCompareHelper(json, expected)
    }
    
    func test_optionalInt_4() {
        //Arrange
        class TestClass {
            var weight: Int? = 4
        }
        
        let m = TestClass()
        
        //Act
        let json = JSONSerializer.toJson(m)
        
        //Assert
        let expected = "{\"weight\": 4}"
        stringCompareHelper(json, expected)
    }
    
    func test_optionalInt_null() {
        //Arrange
        class TestClass {
            var weight: Int? = nil
        }
        
        let m = TestClass()
        
        //Act
        let json = JSONSerializer.toJson(m)
        
        //Assert
        let expected = "{\"weight\": null}"
        stringCompareHelper(json, expected)
    }
    
    func test_optionalDouble_nil() {
        //Arrange
        class TestClass {
            var weight: Double? = nil
        }
        
        let m = TestClass()
        
        //Act
        let json = JSONSerializer.toJson(m)
        
        //Assert
        let expected = "{\"weight\": null}"
        stringCompareHelper(json, expected)
    }
    
    func test_bool_true() {
        //Arrange
        class TestClass {
            var delicious = true
        }
        
        let m = TestClass()
        
        //Act
        let json = JSONSerializer.toJson(m)
        
        //Assert
        let expected = "{\"delicious\": true}"
        stringCompareHelper(json, expected)
    }
    
    func test_optionalBool_nil() {
        //Arrange
        class TestClass {
            var delicious: Bool? = nil
        }
        
        let m = TestClass()
        
        //Act
        let json = JSONSerializer.toJson(m)
        
        //Assert
        let expected = "{\"delicious\": null}"
        stringCompareHelper(json, expected)
    }
    
    func test_date_specificDate() {
        //Arrange
        class TestClass {
            var date = NSDate(timeIntervalSince1970: NSTimeInterval(1440430564))
        }
        
        let m = TestClass()
        
        //Act
        let json = JSONSerializer.toJson(m)
        
        //Assert
        let expected = "{\"date\": \"2015-08-24 15:36:04 +0000\"}"
        stringCompareHelper(json, expected)
    }
    
    func test_intArray_1234() {
        //Arrange
        class TestClass {
            var array = [1, 2, 3, 4]
        }
        
        let m = TestClass()
        
        //Act
        let json = JSONSerializer.toJson(m)
        
        //Assert
        let expected = "{\"array\": [1, 2, 3, 4]}"
        stringCompareHelper(json, expected)
    }
    
    func test_optionalIntArray_1nil34() {
        //Arrange
        class TestClass {
            var array: [Int?] = [1, nil, 3, 4]
        }
        
        let m = TestClass()
        
        //Act
        let json = JSONSerializer.toJson(m)
        
        //Assert
        let expected = "{\"array\": [1, null, 3, 4]}"
        stringCompareHelper(json, expected)
    }
    
    func test_doubleArray_1dot12dot23dot3() {
        //Arrange
        class TestClass {
            var array = [1.1, 2.2, 3.3]
        }
        
        let m = TestClass()
        
        //Act
        let json = JSONSerializer.toJson(m)
        
        //Assert
        let expected = "{\"array\": [1.1, 2.2, 3.3]}"
        stringCompareHelper(json, expected)
    }
    
    func test_optionalDoubleArray_1dot1nil3dot3() {
        //Arrange
        class TestClass {
            var array: [Double?] = [1.1, nil, 3.3]
        }
        
        let m = TestClass()
        
        //Act
        let json = JSONSerializer.toJson(m)
        
        //Assert
        let expected = "{\"array\": [1.1, null, 3.3]}"
        stringCompareHelper(json, expected)
    }
    
    func test_stringArray_helloDogCat() {
        //Arrange
        class TestClass {
            var array = ["hello", "dog", "cat"]
        }
        
        let m = TestClass()
        
        //Act
        let json = JSONSerializer.toJson(m)
        
        //Assert
        let expected = "{\"array\": [\"hello\", \"dog\", \"cat\"]}"
        stringCompareHelper(json, expected)
    }
    
    func test_optionalStringArray_helloNilCat() {
        //Arrange
        class TestClass {
            var array: [String?] = ["hello", nil, "cat"]
        }
        
        let m = TestClass()
        
        //Act
        let json = JSONSerializer.toJson(m)
        
        //Assert
        let expected = "{\"array\": [\"hello\", null, \"cat\"]}"
        stringCompareHelper(json, expected)
    }
    
    func test_object_recursive() {
        //Arrange
        class Child {
            var name = "Vitamin"
            var amount = 4.2
            var intArray = [1, 5, 9]
            var stringArray = ["nutrients", "are", "important"]
        }
        class TestClass {
            var child = Child()
        }
        
        
        let m = TestClass()
        
        //Act
        let json = JSONSerializer.toJson(m)
        
        //Assert
        let expected = "{\"child\": {\"name\": \"Vitamin\", \"amount\": 4.2, \"intArray\": [1, 5, 9], \"stringArray\": [\"nutrients\", \"are\", \"important\"]}}"
        stringCompareHelper(json, expected)
    }
    
    func test_inheritance_included() {
        //Arrange
        class Animal {
            var weight: Double = 2.5
            var age: Int = 2
            var name: String? = "An animal"
        }
        class Cat: Animal {
            var fur: Bool = true
        }
        
        
        let m = Cat()
        
        //Act
        let json = JSONSerializer.toJson(m)
        
        //Assert
        let expected = "{\"fur\": true, \"weight\": 2.5, \"age\": 2, \"name\": \"An animal\"}"
        stringCompareHelper(json, expected)
    }
    
    func test_moreInheritance_included() {
        //Arrange
        class Object {
            var id: Int = 182371823
        }
        class Animal: Object {
            var weight: Double = 2.5
            var age: Int = 2
            var name: String? = "An animal"
        }
        class Cat: Animal {
            var fur: Bool = true
        }
        
        
        let m = Cat()
        
        //Act
        let json = JSONSerializer.toJson(m)
        
        //Assert
        let expected = "{\"fur\": true, \"weight\": 2.5, \"age\": 2, \"name\": \"An animal\", \"id\": 182371823}"
        stringCompareHelper(json, expected)
    }
    
    func test_arrayOfCustomClass_included() {
        //Arrange
        class Person {
            var name: String
            var age: Int
            
            init(name: String, age: Int) {
                self.name = name
                self.age = age
            }
        }
        class Family {
            var name = "Olsen"
            var persons = [Person]()
            init(){
                persons += [Person(name: "Peter", age: 24), Person(name: "Tomas", age: 1000)]
            }
        }
        
        let m = Family()
        
        //Act
        let json = JSONSerializer.toJson(m)
        
        //Assert
        let expected = "{\"name\": \"Olsen\", \"persons\": [{\"name\": \"Peter\", \"age\": 24}, {\"name\": \"Tomas\", \"age\": 1000}]}"
        stringCompareHelper(json, expected)
    }
    
    func testPerformance_singleObject7Properties_lessThan10ms() {
        
        class Person {
            var name: String
            var age: Int
            var favNumbers = [1, 5, -10, 1023]
            var height = 1.86
            var aStringArray = ["hest", "fest", "bedst"]
            var nullArray: [String?] = [nil, "2.4", "99", "hejsan"]
            var cool = true
            
            init(name: String, age: Int) {
                self.name = name
                self.age = age
            }
        }
        
        let m = Person(name: "testSubject", age: 25)
        
        self.measureBlock {
            JSONSerializer.toJson(m)
        }
    }
    
    
    func testPerformance_familyWith10000PersonsAndInheritance_lessThan1500ms() {
        
        //Arrange
        class Entity {
            var id = "An ID"
            var half = 0.5
        }
        
        class Person : Entity {
            var name: String
            var age: Int
            
            var favNumbers = [1, 5, -10, 1023]
            
            init(name: String, age: Int) {
                self.name = name
                self.age = age
            }
        }
        class Family {
            var name = "Olsen"
            var persons = [Person]()
            init(){
                
                for _ in 0...10000 {
                    persons += [Person(name: "Person", age: 25)]
                }
                
            }
        }
        
        let m = Family()
        
        self.measureBlock {
            //Act
            let json = JSONSerializer.toJson(m)
        }
    }
    
    
}
