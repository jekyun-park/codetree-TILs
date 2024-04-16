import Foundation

let nt = readLine()!.split(separator: " ").map { Int($0)! }
let n = nt[0], t = nt[1]

var array = [Int]()

for i in 0..<2 {
    if i == 0 {
        array.append(contentsOf: readLine()!.split(separator: " ").map { Int($0)! })
    } else {
        array.append(contentsOf: readLine()!.split(separator: " ").map { Int($0)! })
    }   
}

for i in 0..<(t % (2*n)) {
    let num = array.popLast()!
    array.insert(num, at: 0)
}

for i in 0..<2*n {
    print(array[i], terminator: " ")
    if i == n-1 {
        print()
    }
}