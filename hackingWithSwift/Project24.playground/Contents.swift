import UIKit

var str = "Hello, playground"

//let name = "Taylor"
//
//for letter in name {
//    print(letter)
//}
//let letter = name[name.index(name.startIndex, offsetBy: 3)]
//
//extension String {
//    subscript(i: Int) -> String {
//        return String(self[index(startIndex, offsetBy: i)])
//    }
//}
//
//let letter2 = name[3]

//let password = "12345"
//password.hasPrefix("123")
//
//extension String {
//    func deletingPrefix(_ prefix: String) -> String {
//        guard self.hasPrefix(prefix) else { return self }
//        return String(self.dropFirst(prefix.count))
//    }
//    func deletingSuffix(_ suffix: String) -> String {
//        guard self.hasSuffix(suffix) else { return self }
//        return String(self.dropLast(suffix.count))
//    }
//}

//let weather = "its going to rain"
//print(weather.capitalized)
//
//extension String {
//    var capitalizedFirst: String {
//        guard let firstLetter = self.first else { return ""}
//        return firstLetter.uppercased() + self.dropFirst()
//    }
//}

//let input = "Swift is like"
//input.contains("Swift")
//
//let languages = ["Python", "Swift"]
//languages.contains("Swift")
//
//extension String {
//    func containsAny(of array: [String]) -> Bool {
//        for item in array {
//            if self.contains(item){
//                return true
//            }
//        }
//        return false
//    }
//}
//input.containsAny(of: languages)
//
//languages.contains(where: input.contains)


extension String {
    func withPrefix(prefix: String) -> String{
        if self.contains(prefix) { return self}
        return prefix + self
    }
    func isNumeric() -> Bool {
        for letter in self {
            if Double(String(letter)) != nil {
                return true
            }
        }
        return false
    }
    func returnLines() -> [String.SubSequence]{
        return self.split(separator: "\n")
        
    }
}

var car = "Auto"
car.withPrefix(prefix: "Au")
car.withPrefix(prefix: "ZZ")
var number = "zzzz1"
number.isNumeric()
var word = "Venom\nLetter\nPoy"
word.returnLines()
