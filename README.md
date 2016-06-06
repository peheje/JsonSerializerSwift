# JsonSerializerSwift
A simple Json Serializer for Swift

Parse your Swift object instances to a JSON string. This is a simple one-to-one conversion atm. No pretty print. Properties will be named the same thing as in your classes as in the JSON string. But I'm planning to add support for camelCaseName -> CamedCaseName in the conversion process, and maybe a custom name mapping (especially if Apple introduces property [Attributes]).

Uses reflection. On a MBP 15 Ultimo 2013 I'm getting about 1.5 sec for serializing a simple three-layer-inheritance object with 10000 array objects.

**To use**

Here a simple test case is shown. For more tests see the JsonSerializerSwiftTests file, git clone to run them yourself :)

```swift
//Arrange your model classes
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
stringCompareHelper(json, expected) //returns true

```
Currently supports standard types, optional standard types, arrays, arrays of nullables standard types, array of custom classes, inheritance, composition of custom objects, structs.
