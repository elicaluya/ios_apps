import UIKit

// rank function using binary search to find the index of a key in a sorted array. Returns -1 if not found.
func rank(key : Int, array : [Int]) -> Int {
    var left = 0
    var right = array.count - 1
    
    while left <= right {
        let mid = left + (right - left) / 2
        
        if array[mid] < key {
            left = mid + 1
        }
        else if array[mid] > key {
            right = mid - 1
        }
        else {
            return mid
        }
    }
    
    return -1
}


let k1 : Int = 3
let ar1 : [Int] = [1,2,3,4,5,6,7,8]
// Should print 2
print(rank(key: k1, array: ar1))

let ar2 : [Int] = [1,2,4,5,6,7,8]
// Should print -1 since key is not in sorted array
print(rank(key: k1, array: ar2))

let k2 = 5
let ar3 = [5,6,7,8,9,10]
// Should print 0 since the key is the first element
print(rank(key: k2, array: ar3))

let ar4 = [1,2,3,4,5]
// Should print 4 since the key is the last element of the array
print(rank(key: k2, array: ar4))



class Fraction {
    var numerator : Int = 0
    var denominator : Int = 1
    init(_ numerator: Int, over denominator: Int) {
        self.numerator = numerator
        self.denominator = denominator
    }
    
    init() { }
    
    func setTo(numerator : Int, denominator : Int){
        self.numerator = numerator
        self.denominator = denominator
    }
    
    func print() {
        Swift.print("\(numerator)/\(denominator)")
    }
    
    func toDouble() -> Double {
        return Double(numerator) / Double(denominator)
    }
    
    func reduce() {
        var u = abs(numerator)
        var v = denominator
        var r : Int
        while (v != 0) {
            r = u % v
            u = v
            v = r
        }
        numerator /= u
        denominator /= u
    }
    
    // Addition, subtraction, multiplication, and division functions provided by professor and from https://en.wikipedia.org/wiki/Rational_number
    
    func add(_ f : Fraction) -> Fraction{
        let res : Fraction = Fraction()
        res.numerator = numerator * f.denominator + denominator * f.numerator
        res.denominator = denominator * f.denominator
        res.reduce()
        return res
    }
    
    func subtract(_ f : Fraction) -> Fraction{
        let res : Fraction = Fraction()
        res.numerator = numerator * f.denominator - denominator * f.numerator
        res.denominator = denominator * f.denominator
        res.reduce()
        return res
    }
    
    func multiply(_ f : Fraction) -> Fraction{
        let res : Fraction = Fraction()
        res.numerator = numerator * f.numerator
        res.denominator = denominator * f.denominator
        res.reduce()
        return res
    }
    
    func divide(_ f : Fraction) -> Fraction{
        let res : Fraction = Fraction()
        res.numerator = numerator * f.denominator
        res.denominator = denominator * f.numerator
        res.reduce()
        return res
    }
}

var f1 = Fraction(1, over: 2)
var f2 = Fraction(1, over: 4)
var f3 = Fraction(1, over: 3)
var f4 = Fraction(1, over: 5)
var f5 = Fraction(1, over: 6)

// 1/2 + 1/4 = 3/4
var res1 : Fraction = f1.add(f2)
res1.print()

// 1/3 - 1/4 = 1/12
var res2 : Fraction = f3.subtract(f2)
res2.print()

// 1/4 * 1/5 = 1/20
var res3 : Fraction = f2.multiply(f4)
res3.print()

// 1/5 / 1/6 = 6/5
var res4 : Fraction = f4.divide(f5)
res4.print()
