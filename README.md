# JsonSerializerSwift
A simple Json Serializer for Swift

**Update 14-06-2017:**

Merged a pull request, now arrays of primitives are no longer enclosed in tuborg clamps {}. Updated tests to reflect this. Might be a breaking change, but it is fixing a bug.

**Update 14-09-2016:**

Works with Swift 3.0. If you work with Swift 2.0 commit 921763ba36dbf1ce710f615d4c2ef838d2b4af3b will work. But I'm not planning on creating separate branches for Swift V2 and V3, so updates from now on will only be added to Swift 3.0 version.

**About**

Parse your Swift object instances to a JSON string. This is a simple one-to-one conversion atm. Pretty print is supported. Properties will be named the same as in your classes as in the JSON string. 

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