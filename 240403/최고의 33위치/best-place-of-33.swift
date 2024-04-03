import Foundation

let N = Int(readLine()!)!
var map = [[Int]]()

for _ in 0..<N {
    let line = readLine()!.split(separator: " ").map { Int($0)! }
    map.append(line)
}

var answer = Int.min

if N == 3 {
    print(map.flatMap { $0 }.filter { $0 == 1 }.count)
} else {
    var maxCoins = 0
    for i in 0...N-3 {
        for j in 0...N-3 {
            for x in 0..<3 {
                for y in 0..<3 {
                    if map[i+x][j+y] == 1 {
                        maxCoins += 1
                    }
                }
            }
            answer = max(answer, maxCoins)
            maxCoins = 0
        }
    }
    print(answer)
}