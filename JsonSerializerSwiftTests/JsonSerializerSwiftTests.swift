/*The MIT License (MIT)

Copyright (c) 2015 Peter Helstrup Jensen

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.*/


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
    func stringCompareHelper(_ actual: String, _ expected: String) {
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
    
    func test_optionalDouble_2dot2() {
        /* Currently optional doubles cause trouble. This is because converting it to string to remove the optional part is kind of a hack and introduces double rounding errors. You are welcome to try fix it. */
        
        //Arrange
        class TestClass {
            var weight: Double? = 2.2
        }
        
        let m = TestClass()
        
        //Act
        let json = JSONSerializer.toJson(m)
        
        //Assert
        //Floating point numbers sometimes will give these innaccuracies see 
        //http://stackoverflow.com/questions/177506/why-do-i-see-a-double-variable-initialized-to-some-value-like-21-4-as-21-3999996
        let expected = "{\"weight\": 2.2000000000000002}"  //actually 2.2000000000000002
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
    
    func test_optionalBool_true() {
        //Arrange
        class TestClass {
            var delicious: Bool? = true
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
            var date = Date(timeIntervalSince1970: TimeInterval(1440430564)).description
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
    
    func testStruct_structWithMembers_structHandled() {
        
        //Arrange
        struct Location {
            var latitude: Int = 20
            var longitude: Int = 10
        }
        
        class Cat {
            var name: String? = "Kitty"
            var location = Location()
        }
        
        let m = Cat()
        
        //Act
        let json = JSONSerializer.toJson(m)
        
        //Assert
        let expected = "{\"name\": \"Kitty\", \"location\": {\"latitude\": 20, \"longitude\": 10}}"
        stringCompareHelper(json, expected)
    }
    
    func testStruct_structWithStruct_structsHandled() {
        
        //Arrange
        struct Identifier {
            var hash: String = "1337$"
            var id: Int = 42
        }
        
        struct Location {
            var latitude: Int = 20
            var longitude: Int = 10
            var Id = Identifier()
        }
        
        class Cat {
            var name: String? = "Kitty"
            var location = Location()
        }
        
        let m = Cat()
        
        //Act
        let json = JSONSerializer.toJson(m)
        
        //Assert
        let expected = "{\"name\": \"Kitty\", \"location\": {\"latitude\": 20, \"longitude\": 10, \"Id\": {\"hash\": \"1337$\", \"id\": 42}}}"
        stringCompareHelper(json, expected)
    }
    
    func test_optionalStruct_included() {
        
        //Arrange
        struct Location{
            var latitude: Int?
            var longitude: Int?
            var trueNorth: String
        }
        
        class Cat {
            var name: String?
            var color: String?
            var age: String?
            var location: Location?
            var purRate = 3.3
            init()
            {
                location = Location(latitude: 4034, longitude: 2012, trueNorth: "yes")
            }
        }
        
        let cat = Cat()
        cat.name = "Mr. Cat"
        cat.color = "Orange"
        cat.age = "3"
        
        //Act
        let json = JSONSerializer.toJson(cat)
        
        //Assert
        let expected = "{\"name\": \"Mr. Cat\", \"color\": \"Orange\", \"age\": \"3\", \"location\": {\"latitude\": 4034, \"longitude\": 2012, \"trueNorth\": \"yes\"}, \"purRate\": 3.3}"
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
        
        self.measure {
            JSONSerializer.toJson(m)
        }
    }
    
    
    func testPerformance_familyWith10000PersonsAndInheritance_lessThan2000ms() {
        
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
        
        self.measure {
            //Act
            let json = JSONSerializer.toJson(m)
        }
    }
    
    func testNotMapped_classWithPropertiesAndSomeNotMapped_notMappedDoesNotMap() {
        
        //Arrange
        class Object {
            var id: Int = 182371823
            var notMapped_appId = 2002
        }
        class Animal: Object {
            var weight: Double = 2.5
            var age: Int = 2
            var name: String? = "An animal"
            var notMapped_internalClass = "MyInternalClass"
        }
        class Cat: Animal {
            var fur: Bool = true
            var notMapped_information = [1.3, 5.0, 2.2]
        }
        
        
        let m = Cat()
        
        //Act
        let json = JSONSerializer.toJson(m)
        
        //Assert
        let expected = "{\"fur\": true, \"weight\": 2.5, \"age\": 2, \"name\": \"An animal\", \"id\": 182371823}"
        stringCompareHelper(json, expected)
    }
    
    func test_prettify() {
        
        //Arrange
        class Object {
            var id: Int = 182371823
            var notMapped_appId = 2002
        }
        class Animal: Object {
            var weight: Double = 2.5
            var age: Int = 2
            var name: String? = "An animal"
            var notMapped_internalClass = "MyInternalClass"
        }
        class Cat: Animal {
            var fur: Bool = true
            var information = [1.3, 5.0, 2.2]
        }
        
        
        let m = Cat()
        
        //Act
        let json = JSONSerializer.toJson(m, prettify: true)
        print(json)
        
        //Assert
        let expected = "{\n  \"information\" : [\n    1.3,\n    5,\n    2.2\n  ],\n  \"age\" : 2,\n  \"id\" : 182371823,\n  \"fur\" : true,\n  \"weight\" : 2.5,\n  \"name\" : \"An animal\"\n}"
        stringCompareHelper(json, expected)
    }
    
    func test_intArray_noIndex() {
        
        //Arrange
        let m = [1, 2, 3]
        
        //Act
        let json = JSONSerializer.toJson(m, prettify: false)
        print(json)
        
        //Assert
        let expected = "[1, 2, 3]"
        stringCompareHelper(json, expected)
    }
    
    func test_doubleArray_noIndex() {
        
        //Arrange
        let m = [2.2, 1.5, 5.6]
        
        //Act
        let json = JSONSerializer.toJson(m, prettify: false)
        print(json)
        
        //Assert
        let expected = "[2.2, 1.5, 5.6]"
        stringCompareHelper(json, expected)
    }
    
    func test_stringArray_noIndex() {
        
        //Arrange
        let m = ["hello", "how", "are"]
        
        //Act
        let json = JSONSerializer.toJson(m, prettify: false)
        print(json)
        
        //Assert
        let expected = "[\"hello\", \"how\", \"are\"]"
        stringCompareHelper(json, expected)
    }
    
    func test_array() {
        class Location {
            var lat: Int
            var lon: Int
            init(_ lat: Int, _ lon: Int) {
                self.lat = lat
                self.lon = lon
            }
        }
        
        var m = [Location]()
        m.append(Location(1, 2))
        m.append(Location(1, 2))
        
        let json = JSONSerializer.toJson(m, prettify: false)
        
        print(json)
    }
    
    func test_int64_notTreatedAsString() {
        //Arrange
        class TestClass {
            var weight: Int64 = 64
        }
        
        let m = TestClass()
        
        //Act
        let json = JSONSerializer.toJson(m)
        
        //Assert
        let expected = "{\"weight\": 64}"
        stringCompareHelper(json, expected)
    }
    
    func test_arrayInt64_notTreatedAsString() {
        //Arrange
        class TestClass {
            var array: [Int64] = [1, 2, 3, 4]
        }
        
        let m = TestClass()
        
        //Act
        let json = JSONSerializer.toJson(m)
        
        //Assert
        let expected = "{\"array\": [1, 2, 3, 4]}"
        stringCompareHelper(json, expected)
    }
    
}
