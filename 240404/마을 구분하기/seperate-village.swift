import Foundation

let n = Int(readLine()!)!
var map: [[Int]] = []

for _ in 0..<n {
    map.append(readLine()!.split(separator: " ").map { Int($0)! })
}

var visited = Array(repeating: Array(repeating: false, count: n), count: n)
var answer = [Int]()
var count = 0

@discardableResult
func dfs(_ x: Int, _ y: Int) -> Int {
    let dx = [-1, 1, 0, 0]
    let dy = [0, 0, -1, 1]
    visited[x][y] = true

    for i in 0..<4 {
        let nx = x + dx[i]
        let ny = y + dy[i]

        if canMove(nx, ny) {
            visited[nx][ny] = true
            count += 1
            map[x][y] = 0
            dfs(nx, ny)
        }
    }

    return count
}

func isInRange(_ x: Int, _ y: Int) -> Bool {
    return ((0..<n) ~= x) && ((0..<n) ~= y)
}

func canMove(_ x: Int, _ y: Int) -> Bool {
    if !isInRange(x, y) { return false }
    if visited[x][y] || map[x][y] == 0 { return false }
    return true
}



for i in 0..<n {
    for j in 0..<n {
        if map[i][j] == 1 {
            dfs(i,j)
            answer.append(count)
            count = 0
        }
    }
}

answer = answer.filter { $0 != 0 }.map { $0 + 1 }
answer.sort(by: <)

print(answer.count)
answer.forEach { print($0) }