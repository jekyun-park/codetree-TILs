import Foundation

let nm = readLine()!.split(separator: " ").map { Int($0)! }
let n = nm[0], m = nm[1]
var grid = [[Int]]()
var answer = 0

for _ in 0..<n {
    grid.append(readLine()!.split(separator: " ").map { Int($0)! })
}

for row in grid {
    var last = 0
    var count = 1
    for i in row {
        if last == i {
            count += 1 
        } else {
            last = i
            count = 1
        }
    }
    if count >= m { answer += 1 }
}

for col in 0..<n {
    var last = 0
    var count = 1
    for i in 0..<n {
        if last == grid[i][col] {
            count += 1 
        } else {
            last = grid[i][col]
            count = 1
        }
    }
    if count >= m { answer += 1 }
}

print(answer)