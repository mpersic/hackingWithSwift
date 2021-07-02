import UIKit
import GameplayKit
//let int1 = Int.random(in: 0...10)
//let int2 = Int.random(in: 0..<10)
//let double1 = Double.random(in: 1000...10000)
//let float1 = Float.random(in: -100...100)
//
//print(arc4random())
//print(arc4random() % 6)
//
//print(arc4random_uniform(6))
//
//func RandomInt(min: Int, max: Int) -> Int {
//    if max < min { return min }
//    return Int(arc4random_uniform(UInt32((max - min) + 1))) + min
//}
//
//print(RandomInt(min: 3, max: 10))

print(GKRandomSource.sharedRandom().nextInt())
print(GKRandomSource.sharedRandom().nextInt(upperBound: 6))

let arc4 = GKARC4RandomSource()
arc4.nextInt(upperBound: 20)

let mersenne = GKMersenneTwisterRandomSource()
mersenne.nextInt(upperBound: 20)

arc4.dropValues(1024)

let d6 = GKRandomDistribution.d6()
d6.nextInt()

let shuffled = GKShuffledDistribution.d6()
print(shuffled.nextInt())
print(shuffled.nextInt())
print(shuffled.nextInt())
print(shuffled.nextInt())
print(shuffled.nextInt())
print(shuffled.nextInt())

extension Array {
    mutating func shuffle() {
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            swapAt(i, j)
        }
    }
}

let lotteryBalls = [Int](1...49)
let shuffledBalls = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: lotteryBalls)
print(shuffledBalls[0])
print(shuffledBalls[1])
print(shuffledBalls[2])
print(shuffledBalls[3])
print(shuffledBalls[4])
print(shuffledBalls[5])
