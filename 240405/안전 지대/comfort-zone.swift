import Foundation

// O(N * M * K): 50 * 50 * 100 = 250,000 
// 1억회(100,000,000) 연산 = 1초

let nm = readLine()!.split(separator: " ").map { Int($0)! }
let n = nm[0], m = nm[1]
var originalMap = [[Int]]()

for _ in 0..<n {
    originalMap.append(readLine()!.split(separator: " ").map { Int($0)! })
}

var answers: [(K: Int, count: Int)] = []
var visited = Array(repeating: Array(repeating: false, count: m), count: n)
var map = [[Int]]()

for k in 1...100 {
    map = originalMap.map { $0.map { $0 - k } }
    for i in 0..<n {
        for j in 0..<m {
            let r = dfs(i, j, 0)
            print(r)
        }
    }
    visited = Array(repeating: Array(repeating: false, count: m), count: n)
}

func dfs(_ x: Int, _ y: Int, _ c: Int) -> Int {
    let dx = [-1, 1, 0, 0]
    let dy = [0, 0, -1, 1]

    visited[x][y] = true

    for i in 0..<4 {
        let nx = x + dx[i]
        let ny = y + dy[i]

        if canMove(nx, ny) {
            visited[nx][ny] = true
            dfs(nx, ny, c+1)
        }
    }

    return c
}

func isInRange(_ x: Int, _ y: Int) -> Bool {
    return ((0..<n) ~= x) && ((0..<m) ~= y)
}

func canMove(_ x: Int, _ y: Int) -> Bool {
    if !isInRange(x, y) { return false }
    if map[x][y] < 1 { return false }
    return true
}